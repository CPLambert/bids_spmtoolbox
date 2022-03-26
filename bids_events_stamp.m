function events = bids_events_stamp(events,extras)
%% function task = bids_task_stamp(task)
%
% This file is intended as a function for behavioural tasks and does not get used in the toolbox.
% I've left it in as it may be useful for some people
%
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
%__________________________________________________________________________
% C.Lambert, Wellcome Centre for Human Neuroimaging
% Version 1.0, November 2021
%__________________________________________________________________________

fx=fields(events);fe=fields(extras);

if isempty(events.onset)
    events.onset=now;
    events.duration=NaN;
    for k=1:numel(fe)
        if ischar(extras.(fe{k}))
            events.(fe{k}){1}=extras.(fe{k});
        else
            events.(fe{k})(1)=extras.(fe{k});
        end
    end

else
    cn=numel(events.onset)+1;
    events.onset(cn,1)=now;
    events.duration(cn,1)=NaN;

    %Duration of the last event is the time taken to transition to this one
    events.duration(cn-1)=etime(datevec(events.onset(cn)),datevec(events.onset(cn-1)));

    %Add any extra values that have been passed
    for k=1:numel(fx)
        missing = true;
        if strcmp(fx{k},'onset') || strcmp(fx{k},'duration')
            missing = false;
        end

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
end



