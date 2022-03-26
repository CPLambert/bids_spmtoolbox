function bids_make_json(job)
% function bids_make_json(job)
% Make BIDS compliant json files from SPM batch input
%_______________________________________________________________________
% Version History:
% Version 1.0, May 2020
%--------------------------------------------------------------------------
% C.Lambert - Wellcome Centre for Human Neuroimaging
%--------------------------------------------------------------------------

for i=1:numel(job.input)
    filename=fullfile(job.outdir{1},[job.input(i).filename,'.json']);tab=[];
    
    for ii=1:numel(job.input(i).inputjson)
        
        %% Add Measurement Tool
        if isfield(job.input(i).inputjson{ii},'addtool')
            root.MeasurementToolMetadata.Description=job.input(i).inputjson{ii}.addtool.description;
            root.MeasurementToolMetadata.TermURL=job.input(i).inputjson{ii}.addtool.url;
        end
        
        if isfield(job.input(i).inputjson{ii},'addtask')
            tmp=[];
            for iii=1:numel(job.input(i).inputjson{ii}.addtask)
                nam=cell2mat(fieldnames(job.input(i).inputjson{ii}.addtask{iii}));
                tmp.(nam)=job.input(i).inputjson{ii}.addtask{iii}.(nam);
            end
            
            if isfield(tmp,'taskname')
                if ~isempty(tmp.taskname)
                    root.TaskName=deblank(tmp.taskname);
                end
            end
            
            if isfield(tmp,'taskdesc')
                if ~isempty(tmp.taskdesc)
                    root.TaskDescription=deblank(tmp.taskdesc);
                end
            end
            
            if isfield(tmp,'taskinst')
                if ~isempty(tmp.taskinst)
                    root.Instructions=deblank(tmp.taskinst);
                end
            end
            
            if isfield(tmp,'instname')
                if ~isempty(tmp.instname)
                    root.InstitutionName=deblank(tmp.instname);
                end
            end
            
            if isfield(tmp,'instdept')
                if ~isempty(tmp.instdept)
                    root.InstitutionalDepartmentName=deblank(tmp.instdept);
                end
            end
            
            if isfield(tmp,'instadd')
                if ~isempty(tmp.instadd)
                    root.InstitutionAddress=deblank(tmp.instadd);
                end
            end
            
            if isfield(tmp,'cogpoid')
                if ~isempty(tmp.cogpoid)
                    root.CogPOID=deblank(tmp.cogpoid);
                end
            end
            
            if isfield(tmp,'cogatlas')
                if ~isempty(tmp.cogatlas)
                    root.CogAtlasID=deblank(tmp.cogatlas);
                end
            end
        end
        
        
        if isfield(job.input(i).inputjson{ii},'addannot')
            for k=1:numel(job.input(i).inputjson{ii}.addannot)
                if isfield(job.input(i).inputjson{ii}.addannot{k},'metaauthor')
                    root.annotation.metadata.createdby=job.input(i).inputjson{ii}.addannot{k}.metaauthor;
                end
                
                if isfield(job.input(i).inputjson{ii}.addannot{k},'metadescription')
                    root.annotation.metadata.description=job.input(i).inputjson{ii}.addannot{k}.metadescription;
                end
                
                if isfield(job.input(i).inputjson{ii}.addannot{k},'metadate')
                    root.annotation.metadata.datecreated=job.input(i).inputjson{ii}.addannot{k}.metadate;
                end
                
            end
        end
        
        %% Add tabular data &/or custom fields
        if isfield(job.input(i).inputjson{ii},'addvar')
            f=[];tmp=[];c=[];
            for iii=1:numel(job.input(i).inputjson{ii}.addvar)
                nam=cell2mat(fieldnames(job.input(i).inputjson{ii}.addvar{iii}));
                tmp.(nam)=job.input(i).inputjson{ii}.addvar{iii}.(nam);
            end
            
            if isfield(tmp,'varname')
                f=tmp.varname;f(isspace(f))='_';
                if job.input(i).maketab
                    tab.(f)=[];
                end
            end
            
            if ~isempty(f)
                if isfield(tmp,'longname')
                    if ~isempty(tmp.longname)
                        root.(f).LongName=deblank(tmp.longname);
                    end
                end
                
                if isfield(tmp,'description')
                    if ~isempty(tmp.description)
                        root.(f).Description=deblank(tmp.description);
                    end
                end
                
                if isfield(tmp,'addlevel')
                    if ~isempty(tmp.addlevel)
                        for k=1:numel(tmp.addlevel)
                            c{k}=containers.Map(tmp.addlevel(k).levelval,tmp.addlevel(k).levelcat);
                        end
                        root.(f).Levels=vertcat((c{1:end}));
                    end
                end
                
                if isfield(tmp,'units')
                    if ~isempty(tmp.units)
                        root.(f).Units=deblank(tmp.units);
                    end
                end
                
                if isfield(tmp,'url')
                    if ~isempty(tmp.url)
                        root.(f).TermURL=deblank(tmp.url);
                    end
                end
                
                if isfield(tmp,'derivative')
                    if ~isempty(tmp.derivative)
                        root.(f).Derivative=tmp.derivative;
                    end
                end
            end
        end
    end
    
    if isstruct(tab)
        spm_save(fullfile(job.outdir{1},[job.input(i).filename,'.tsv']),tab);
    end
    
    spm_jsonwrite(filename,root,struct('indent','  '));clear root;
end
end

