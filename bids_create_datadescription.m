function bids_create_datadescription(job)
%% function bids_create_datadescription(job)
% Parse SPM BIDS Toolbox input for dataset description
% Return BIDS compliant dataset_decription.json file
%_______________________________________________________________________
% Version History:
% Version 1.0, May 2020
%--------------------------------------------------------------------------
% C.Lambert - Wellcome Centre for Human Neuroimaging
%--------------------------------------------------------------------------

options=bids_toolbox_defaults; %Get current structure
root=options.datasetdescription; %BIDs fields

%% Add job data:
root.Name=job.name;
root.BIDSVersion=job.bidsver;
f=cell2mat(fieldnames(job.license));
root.License=job.license.(f);

if ~isempty(job.authors)
    if isfield(job.authors,'addauthor')
        root.Authors=job.authors.addauthor(:);
    elseif isfield(job.authors,'authorslist')
        root.Authors=split(job.authors.authorslist,',');
    end
    for i=1:numel(root.Authors)
        root.Authors{i}=deblank(root.Authors{i});
    end
else
    root=rmfield(root,'Authors');
end

if ~isempty(job.acktext)
    root.Acknowledgements=job.acktext(:);
else
    root=rmfield(root,'Acknowledgements');
end

if ~isempty(job.pub)
    for i=1:numel(job.pub)
        root.HowToAcknowledge{i}=deblank(job.pub{i});
    end
    root.HowToAcknowledge=root.HowToAcknowledge(:);
else
    root=rmfield(root,'HowToAcknowledge');
end

if ~isempty(job.grant)
    root.Funding=job.grant(:);
else
    root=rmfield(root,'Funding');
end

if ~isempty(job.ethics)
    root.EthicsApprovals=job.ethics(:);
else
    root=rmfield(root,'EthicsApprovals');
end

if ~isempty(job.ref1)
    root.ReferencesAndLinks=job.ref1(:);
else
    root=rmfield(root,'ReferencesAndLinks');
end

if ~isempty(job.doi)
    root.DatasetDOI=deblank(job.doi);
else
    root=rmfield(root,'DatasetDOI');
end

filename=fullfile(job.outdir{1},'dataset_description.json');
spm_jsonwrite(filename,root);
end
