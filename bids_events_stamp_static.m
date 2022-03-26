function events = bids_events_stamp_static(events,extras)
%% function task = bids_task_stamp(task)
% Using the BIDS format, you should be creating an events.tsv file for your
% paradigms. This is a short function to grow this at each event in the paradigm
% The basic structure has the following required fields:
%
% events.onset
% events.duration
%
% There are a number of optional or customisable fields, you should pass
% these as "extras" and they will be added accordingly:
%
% extras.trial_type
% extras.response_time
%
% For the FIRST event (i.e. start), you should specify an entry for each
% extra field, even if it is empty - This allows the code to figure out
% which fields should be strings later on, and can add NaN or 'NaN' without
% you needing to manually specify. Note, the code expects you to build the
% empty structured array first. For example:
%
% events.onset = [];
% events.duration = [];
% events.trial_type = [];
% events.image = [];
% events.value
%
% This file is intended as a function for behavioural tasks and does not get used in the toolbox.
% The static version is used for coverting historic datasets (i.e. you pass the timestamp rather than create)
%
% I've left it in as it may be useful for some people
%__________________________________________________________________________
% C.Lambert, Wellcome Centre for Human Neuroimaging
% Version 1.0, November 2021
%__________________________________________________________________________

fx=fields(events);fe=fields(extras); cn=numel(events.onset)+1;

%Add any extra values that have been passed
for k=1:numel(fx)
    missing = true;

    if missing

        for kk = 1:numel(fe)
            if strcmp(fx{k},fe{kk})
                missing = false;
                if iscell(events.(fe{kk}))
                    events.(fe{kk}){cn,1}=extras.(fe{kk});
                else
                    events.(fe{kk})(cn,1)=extras.(fe{kk});
                end
            end
        end

        if missing
            if iscell(events.(fx{k})(1))
                events.(fx{k}){cn,1}='NaN';
            else
                events.(fx{k})(cn,1)=NaN;
            end
        end
    end
end
end



