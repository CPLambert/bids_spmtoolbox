function bids_read_json(job)
%% function bids_read_json(job)
% Read in json files (currently tabular or dataset description) and output
% "Create JSON file" batch. Useful for editing/reviewing
%_______________________________________________________________________
% Version History:
% Version 1.0, May 2020
%--------------------------------------------------------------------------
% C.Lambert - Wellcome Centre for Human Neuroimaging
%--------------------------------------------------------------------------

%% Main batch
for i=1:numel(job.jsonselect)
    
    [op,filename,~]=fileparts(job.jsonselect{i});
    if ~isempty(job.savedetails)
        op=job.savedetails(1).outdir{1};
    end
    
    root = spm_jsonread(job.jsonselect{i},struct('ReplacementStyle','nop'));
    
    if contains(filename,'dataset_description')
        x = parse_datasetdescription(root,op);
    else
        job2.input(i).filename=filename;
        tmp=fieldnames(root);
        for ii=1:numel(tmp)
            if strcmp(deblank(tmp{ii}),'MeasurementToolMetadata')
                job2.input(i).inputjson{ii}.addtool.description=root.(tmp{ii}).Description;
                job2.input(i).inputjson{ii}.addtool.url=root.(tmp{ii}).TermURL;
            else
                job2.input(i).inputjson{ii}.addvar{1}.varname=deblank(tmp{ii});
                subfield=fieldnames(root.(deblank(tmp{ii})));
                for k=1:numel(subfield)
                    if strcmp(deblank(subfield{k}),'LongName')
                        job2.input(i).inputjson{ii}.addvar{k+1}.longname=root.(deblank(tmp{ii})).(deblank(subfield{k}));
                    end
                    if strcmp(deblank(subfield{k}),'Description')
                        job2.input(i).inputjson{ii}.addvar{k+1}.description=root.(deblank(tmp{ii})).(deblank(subfield{k}));
                    end
                    if strcmp(deblank(subfield{k}),'Levels')
                        levnam=fieldnames(root.(deblank(tmp{ii})).(deblank(subfield{k})));
                        for j=1:numel(levnam)
                            job2.input(i).inputjson{ii}.addvar{k+1}.addlevel(j).levelval=deblank(levnam{j});
                            job2.input(i).inputjson{ii}.addvar{k+1}.addlevel(j).levelcat=root.(deblank(tmp{ii})).(deblank(subfield{k})).(deblank(levnam{j}));
                        end
                    end
                    if strcmp(deblank(subfield{k}),'Units')
                        job2.input(i).inputjson{ii}.addvar{k+1}.units=root.(deblank(tmp{ii})).(deblank(subfield{k}));
                    end
                    if strcmp(deblank(subfield{k}),'TermURL')
                        job2.input(i).inputjson{ii}.addvar{k+1}.url=root.(deblank(tmp{ii})).(deblank(subfield{k}));
                    end
                    if strcmp(deblank(subfield{k}),'Derivative')
                        job2.input(i).inputjson{ii}.addvar{k+1}.derivative=root.(deblank(tmp{ii})).(deblank(subfield{k}));
                    end
                end
            end
        end
        x.matlabbatch{1}.spm.tools.bids.makejson=job2;
        x.matlabbatch{1}.spm.tools.bids.makejson.outdir=cellstr(op);
    end
    if ~isempty(job.savedetails)
        for k=1:numel(job.savedetails)
            filename=fullfile(job.savedetails(k).outdir{1},[job.savedetails(k).filename,'.mat']);
            spm_save(filename,x);
        end
    end
    
    if job.loadbatch
        spm_jobman('interactive',x.matlabbatch);
    end
end
end

%% Sort out valid dataset description json
function x = parse_datasetdescription(root,op)
job2.name=root.Name;
job2.bidsver=root.BIDSVersion;

if contains(root.License,'ODC-BY')
    job2.license.lice_ccby='ODC-BY 1.0';
elseif contains(root.License,'PDDL')
    job2.license.lice_pddl='PDDL 1.0';
elseif contains(root.License,'ODC-ODbL')
    job2.license.lice_odbl='ODC-ODbL 1.0';
elseif contains(root.License,'CC0')
    job2.license.lice_cc0='CC0 1.0';
elseif contains(root.License,'CC BY')
    job2.license.lice_ccby='CC BY 4.0';
elseif contains(root.License,'CC-BY-SA')
    job2.license.lice_ccbysa='CC-BY-SA 4.0';
else
    job2.license.lice_custom=root.License;
end

if isfield(root,'Authors')
    for k=1:numel(root.Authors)
        job2.authors.addauthor{k}=root.Authors{k};
    end
end

if isfield(root,'Acknowledgements')
    if iscell(root.Acknowledgements)
        for k=1:numel(root.Acknowledgements)
            job2.acktext{k}=root.Acknowledgements{k};
        end
    else
        job2.acktext{1}=root.Acknowledgements;
    end
    
end

if isfield(root,'HowToAcknowledge')
    if iscell(root.HowToAcknowledge)
        
        for k=1:numel(root.HowToAcknowledge)
            job2.pub{k}=root.HowToAcknowledge{k};
        end
    else
        job2.pub{1}=root.HowToAcknowledge;
    end
end

if isfield(root,'Funding')
    if iscell(root.Funding)
        for k=1:numel(root.Funding)
            job2.grant{k}=root.Funding{k};
        end
    else
        job2.grant{1}=root.Funding;
    end
    
end

if isfield(root,'EthicsApprovals')
    if iscell(root.EthicsApprovals)
        
        for k=1:numel(root.EthicsApprovals)
            job2.ethics{k}=root.EthicsApprovals{k};
        end
    else
        job2.ethics{1}=root.EthicsApprovals;
    end
end

if isfield(root,'ReferencesAndLinks')
    if iscell(root.ReferencesAndLinks)
        for k=1:numel(root.ReferencesAndLinks)
            job2.ref1{k}=root.ReferencesAndLinks{k};
        end
    else
        job2.ref1{1}=root.ReferencesAndLinks;
    end
else
    job2.ref1={};
end

if isfield(root,'DatasetDOI')
    job2.doi=root.DatasetDOI;
else
    job2.doi='';
end
x.matlabbatch{1}.spm.tools.bids.datadescription=job2;
x.matlabbatch{1}.spm.tools.bids.datadescription.outdir=cellstr(op);
end

