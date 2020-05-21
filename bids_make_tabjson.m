function bids_make_tabjson(job)
% function bids_make_tabjson(job)
% Make BIDS compliant json file for tabular daya
%_______________________________________________________________________
% Version History:
% Version 1.0, May 2020
%--------------------------------------------------------------------------
% C.Lambert - Wellcome Centre for Human Neuroimaging
%--------------------------------------------------------------------------

%% Work through and make levels
for i=1:numel(job.inputtab.addvar)
    f=job.inputtab.addvar(i).varname;
    if ~isempty(job.inputtab.addvar(i).longname)
        root.(f).LongName=deblank(job.inputtab.addvar(i).longname);
    end
    if ~isempty(job.inputtab.addvar(i).description)
        root.(f).Description=deblank(job.inputtab.addvar(i).description);
    end
    if ~isempty(job.inputtab.addvar(i).addlevel)
        for k=1:numel(job.inputtab.addvar(i).addlevel)
            c{k}=containers.Map(job.inputtab.addvar(i).addlevel(k).levelval,job.inputtab.addvar(i).addlevel(k).levelcat);
        end
        root.(f).Levels=vertcat((c{1:end}));
    end
    if ~isempty(job.inputtab.addvar(i).units)
        root.(f).Units=deblank(job.inputtab.addvar(i).units);
    end
    if ~isempty(job.inputtab.addvar(i).url)
        root.(f).TermURL=deblank(job.inputtab.addvar(i).url);
    end
end

%% Write json file
filename=fullfile(job.outdir{1},[job.filename,'.json']);
spm_jsonwrite(filename,root,struct('indent','  '));
end

