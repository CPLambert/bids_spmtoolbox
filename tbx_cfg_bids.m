function cfg = tbx_cfg_bids
%% cfg = tbx_cfg_bids
% BIDS Toolbox for phenotyping and dataset annotation
% Collection of useful functions for creating BIDs compliant datasets in
% SPM.
%_______________________________________________________________________
% Version History:
% Version 1.0, May 2020
% Version 1.1, March 2022 - Simplified merge function for stability for now
%--------------------------------------------------------------------------
% C.Lambert - Wellcome Centre for Human Neuroimaging
%--------------------------------------------------------------------------

if ~isdeployed
    addpath(fullfile(spm('Dir'),'toolbox','BIDS'));
end

%% GENERIC: SAVE DATA
% ---------------------------------------------------------------------
% Enter filename
% ---------------------------------------------------------------------
filename                 = cfg_entry;
filename.tag             = 'filename';
filename.name            = 'Output filename';
filename.help            = {'Define filename. If this is JSON file it should be the same as the corresponding tsv table'};
filename.strtype         = 's';
filename.val             = {''};
filename.num             = [0 Inf];

% ---------------------------------------------------------------------
% Select output directory
% ---------------------------------------------------------------------
outdir              = cfg_files;
outdir.tag          = 'outdir';
outdir.name         = 'Output directory';
outdir.help         = {'Select output dirctory'};
outdir.filter       = 'dir';
outdir.ufilter      = '.*';
outdir.num          = [1 1];

% ---------------------------------------------------------------------
% If select save, enter filename and output
% ---------------------------------------------------------------------
savedetails           = cfg_branch;
savedetails.tag       = 'savedetails';
savedetails.name      = 'Save file details';
savedetails.val       = {filename outdir};
savedetails.help      = {'Output details'};

% ---------------------------------------------------------------------
% Optional save
% ---------------------------------------------------------------------
savebatch            = cfg_repeat;
savebatch.tag        = 'inputtab';
savebatch.name       = 'Add save output';
savebatch.values     = {savedetails};
savebatch.help       = {'Save as "Create JSON files" batch'};
savebatch.val        = {};

%% BRANCH SUB-COMPONENTS: dataset_description
% ---------------------------------------------------------------------
% Dataset name
% ---------------------------------------------------------------------
name                = cfg_entry;
name.tag            = 'name';
name.name           = 'Dataset name';
name.help           = {'Name of the dataset (REQUIRED)'};
name.strtype        = 's';
name.num            = [1 Inf];

% ---------------------------------------------------------------------
% BIDS version
% ---------------------------------------------------------------------
bidsver             = cfg_entry;
bidsver.tag         = 'bidsver';
bidsver.name        = 'BIDS version';
bidsver.help        = {'The version of the BIDS standard that was used (REQUIRED)'};
bidsver.strtype     = 's';
bidsver.val         = {'1.6.0'};
bidsver.num         = [1 Inf];

% ---------------------------------------------------------------------
% License options - May be a better way of doing this, but I wanted to
% provide details of each in the help box. Also to recommend not leaving blank
% ---------------------------------------------------------------------
lice_odcby          = cfg_entry;
lice_odcby.tag      = 'lice_odcby';
lice_odcby.name     = 'Open Data Commons Attribution License (ODC-BY 1.0)';
lice_odcby.help     = {'Open Data Commons Attribution License (ODC-BY 1.0)',...
                    'Users are free to use the database and its content in new and different ways, provided they provide attribution to the source of the data and/or the database.'};
lice_odcby.val      = {'ODC-BY 1.0'};
lice_odcby.strtype  = 's';
lice_odcby.num      = [1 Inf];

lice_pddl           = cfg_entry;
lice_pddl.tag       = 'lice_pddl';
lice_pddl.name      = 'Open Data Public Domain Dedication and License (PDDL 1.0)';
lice_pddl.help      = {'Open Data Public Domain Dedication and License (PDDL 1.0)',...
                    'This dedicates the database and its content to the public domain, free for everyone to use as they see fit.'};
lice_pddl.val       = {'PDDL 1.0'};
lice_pddl.strtype   = 's';
lice_pddl.num       = [1 Inf];

lice_odbl           = cfg_entry;
lice_odbl.tag       = 'lice_odbl';
lice_odbl.name      = 'Open Data Commons Open Database License (ODC-ODbL 1.0)';
lice_odbl.help      = {'Open Data Commons Open Database License (ODC-ODbL 1.0)',...
                    'Any subsequent use of the database must fufil the following requirements:',...
                    '1. Provide attribution',...
                    '2. An unrestricted version of the new product must always be accessible',...
                    '3. Any new products made using ODbL material must be distributed using the same terms (i.e. under ODbL license)'};
lice_odbl.val       = {'ODC-ODbL 1.0'};
lice_odbl.strtype   = 's';
lice_odbl.num       = [1 Inf];

lice_cc0            = cfg_entry;
lice_cc0.tag        = 'lice_cc0';
lice_cc0.name       = 'Creative Commons Zero 1.0 Universal (CC0 1.0)';
lice_cc0.help       = {'Creative Commons Zero 1.0 Universal (CC0 1.0)',...
                    'You are the database owner and wish to waive all copyright and/or database rights, effectively placing the database and data into the public domain. It is the functional equivalent of an ODC PDDL license.'};
lice_cc0.val        = {'CC0 1.0'};
lice_cc0.strtype    = 's';
lice_cc0.num        = [1 Inf];

lice_ccby           = cfg_entry;
lice_ccby.tag       = 'lice_ccby';
lice_ccby.name      = 'Creative Commons Attribution 4.0 International (CC BY 4.0)';
lice_ccby.help      = {'Creative Commons Attribution 4.0 International (CC BY 4.0)',...
                    'This license lets others distribute, remix, adapt, and build upon your work, even commercially, as long as they credit you for the original creation.'};
lice_ccby.val       = {'CC BY 4.0'};
lice_ccby.strtype   = 's';
lice_ccby.num       = [1 Inf];

lice_ccbysa         = cfg_entry;
lice_ccbysa.tag     = 'lice_cc0';
lice_ccbysa.name    = 'Creative Commons Attribution ShareAlike 4.0 International (CC-BY-SA 4.0)';
lice_ccbysa.help    = {'Creative Commons Attribution ShareAlik 4.0 Internationale (CC-BY-SA 4.0)',...
                    'This license lets others distribute, remix, adapt, and build upon your work, even commercially, as long as they credit you and license derivatives based on this database under the identical terms. This license is often compared to ?copyleft? free and open source software licenses. All new works based on yours will carry the same license, so any derivatives will also allow commercial use. '};
lice_ccbysa.val     = {'CC-BY-SA 4.0'};
lice_ccbysa.strtype = 's';
lice_ccbysa.num     = [1 Inf];

lice_custom         = cfg_entry;
lice_custom.tag     = 'lice_custom';
lice_custom.name    = 'Other';
lice_custom.help    = {'Manually specify other license for this dataset'};
lice_custom.strtype = 's';
lice_custom.num     = [1 Inf];

% ---------------------------------------------------------------------
% Add license
% ---------------------------------------------------------------------
license             = cfg_choice;
license.tag         = 'license';
license.name        = 'Select license';
license.values      = {lice_odcby,lice_pddl,lice_odbl,lice_cc0,lice_ccby,lice_ccbysa,lice_custom};
license.help        = {'What license is this dataset distributed under? Some common open data licenses have been provided with a brief summary of their scope. For more information please consult the original license details'};
license.val         ={lice_ccby};

% ---------------------------------------------------------------------
% Input author(s) - JSON read will convert any authors to addauthor
% ---------------------------------------------------------------------
authorslist         = cfg_entry;
authorslist.tag     = 'authorslist';
authorslist.name    = 'Add csv list of authors';
authorslist.help    = {'Add list of authors, each separated by a comma'};
authorslist.strtype = 's';
authorslist.val     = {''};
authorslist.num     = [0 Inf];

addauthor          = cfg_entry;
addauthor.tag      = 'addauthor';
addauthor.name     = 'Add new author';
addauthor.help     = {'Add author'};
addauthor.strtype  = 's';
addauthor.val      = {''};
addauthor.num      = [0 Inf];

% ---------------------------------------------------------------------
% Add author(s) individually
% ---------------------------------------------------------------------
inputauthors          = cfg_repeat;
inputauthors.tag      = 'inputauthors';
inputauthors.name     = 'Add authors individually';
inputauthors.help     = {'Add author'};
inputauthors.values   = {addauthor};
inputauthors.num      = [1 Inf];

% ---------------------------------------------------------------------
% Optional: Add authors?
% ---------------------------------------------------------------------
authors             = cfg_choice;
authors.tag         = 'authors';
authors.name        = 'Authors (optional)';
authors.help        = {'Optional list of individuals who contributed to the creation/curation of the dataset.',...
                    'Either add seperately or input a comma separated list'};
authors.values      = {authorslist inputauthors};
authors.val         = {authorslist};

% ---------------------------------------------------------------------
% Input acknowledgement text text
% ---------------------------------------------------------------------
acktext             = cfg_entry;
acktext.tag         = 'acktext';
acktext.name        = 'Add new attribition/acknowedgement text';
acktext.help        = {'Optional text acknowledging contributions of individuals or institutions beyond those listed in Authors or Funding'};
acktext.strtype     = 's';
acktext.val         = {};
acktext.num         = [1 Inf];

% ---------------------------------------------------------------------
% Add acknowledgements - Generic acknowledgement text
% ---------------------------------------------------------------------
ackopt                 = cfg_repeat;
ackopt.tag             = 'ack';
ackopt.name            = 'Acknowledgement (optional)';
ackopt.help            = {'Optional text acknowledging contributions of individuals or institutions beyond those listed in Authors or Funding'};
ackopt.values          = {acktext};
ackopt.val             = {};
ackopt.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter publications/attributions/url
% ---------------------------------------------------------------------
pub                 = cfg_entry;
pub.tag             = 'pub';
pub.name            = 'Attribution text/Publication';
pub.help            = {'Add attribution text, publication or url'};
pub.strtype         = 's';
pub.val             = {''};
pub.num             = [1 Inf];

% ---------------------------------------------------------------------
% Add explicit "How to acknowledge". For simplicity, just use pub entry
% ---------------------------------------------------------------------
addack              = cfg_repeat;
addack.tag          = 'addack';
addack.name         = 'How to acknowledge (optional)';
addack.help         = {'Optional - Add instructions of attribution e.g. Publications. Can add seperate groups if needed'};
addack.values       = {pub};
addack.val          = {};
addack.num          = [0 Inf];

% ---------------------------------------------------------------------
% Input new grant code(s)
% ---------------------------------------------------------------------
grant               = cfg_entry;
grant.tag           = 'grant';
grant.name          = 'Add new grant code';
grant.help          = {'Add new funding grant code'};
grant.strtype       = 's';
grant.val           = {''};
grant.num           = [0 Inf];

% ---------------------------------------------------------------------
% Add funding
% ---------------------------------------------------------------------
fund                = cfg_repeat;
fund.tag            = 'fund';
fund.name           = 'Funding (optional)';
fund.help           = {'Optional - List of sources of funding (grant numbers)'};
fund.values         = {grant};
fund.val            = {};
fund.num            = [0 Inf];

% ---------------------------------------------------------------------
% Input new ethics/protocol numbers
% ---------------------------------------------------------------------
ethics           = cfg_entry;
ethics.tag       = 'ethics';
ethics.name      = 'Add new ethics/protocl code';
ethics.help      = {'Add new ethics/protocol code'};
ethics.strtype   = 's';
ethics.val       = {''};
ethics.num       = [0 Inf];

% ---------------------------------------------------------------------
% Add ethics
% ---------------------------------------------------------------------
ethicsopt           = cfg_repeat;
ethicsopt.tag       = 'ethics';
ethicsopt.name      = 'Ethics (optional)';
ethicsopt.help      = {'Optional - List of ethics committee approvals of the research protocols and/or protocol identifiers'};
ethicsopt.values    = {ethics};
ethicsopt.val       = {};
ethicsopt.num       = [0 Inf];

% ---------------------------------------------------------------------
% Input related publications/references - Seperate field to how to acknowledge
% ---------------------------------------------------------------------
ref1                 = cfg_entry;
ref1.tag             = 'ref1';
ref1.name            = 'Add new reference';
ref1.help            = {'Add publication/links'};
ref1.strtype         = 's';
ref1.val             = {''};
ref1.num             = [1 Inf];

% ---------------------------------------------------------------------
% Add references
% ---------------------------------------------------------------------
ref                 = cfg_repeat;
ref.tag             = 'ref';
ref.name            = 'References and links (optional)';
ref.help            = {'Optional - List of references to publication that contain information on the dataset, or links'};
ref.values          = {ref1};
ref.val             = {};
ref.num             = [0 Inf];

% ---------------------------------------------------------------------
% Input DOI
% ---------------------------------------------------------------------
doi                 = cfg_entry;
doi.tag             = 'doi';
doi.name            = 'Dataset DOI (optional)';
doi.help            = {'Optional Document Object Identifier of the dataset (not the corresponding paper)'};
doi.strtype         = 's';
doi.val             = {''};
doi.num             = [0 Inf];

%% BRANCH SUB-COMPONENTS: Create JSON file(s)
% Include filename from generic for save
% ---------------------------------------------------------------------
% Enter new variable name
% ---------------------------------------------------------------------
varname            = cfg_entry;
varname.tag        = 'varname';
varname.name       = 'Variable name';
varname.help       = {'Variable name as used in the table (essential)'};
varname.strtype    = 's';
varname.val        = {''};

% ---------------------------------------------------------------------
% Enter BIDS "Longname" for variable
% ---------------------------------------------------------------------
longname            = cfg_entry;
longname.tag        = 'longname';
longname.name       = 'Longname for variable';
longname.help       = {'Longname for variable (essential)'};
longname.strtype    = 's';
longname.val        = {''};

% ---------------------------------------------------------------------
% Enter BIDS "Description" for variable
% ---------------------------------------------------------------------
description         = cfg_entry;
description.tag     = 'description';
description.name    = 'Description';
description.help    = {'Description of variable (essential)'};
description.strtype = 's';
description.val     = {''};

% ---------------------------------------------------------------------
% BIDS "Levels" for categorical data: Enter category descriptor
% ---------------------------------------------------------------------
levelcat            = cfg_entry;
levelcat.tag        = 'levelcat';
levelcat.name       = 'Add category assigned to value';
levelcat.help       = {'What category does the corresponding value mean'};
levelcat.strtype    = 's';
levelcat.val        = {''};

% ---------------------------------------------------------------------
% BIDS "Levels" for categorical data: Enter category value
% ---------------------------------------------------------------------
levelval            = cfg_entry;
levelval.tag        = 'levelval';
levelval.name       = 'Add new categorical value';
levelval.help       = {'Integer value'};
levelval.strtype    = 's';
levelval.val        = {''};

% ---------------------------------------------------------------------
% BIDS "Levels" for categorical data: Add new level
% ---------------------------------------------------------------------
addlevel            = cfg_branch;
addlevel.tag        = 'addlevel';
addlevel.name       = 'Add categorical data level';
addlevel.val        = {levelval levelcat};
addlevel.help       = {'Add new level per category'};

% ---------------------------------------------------------------------
% BIDS "Levels" for categorical data: Add categorical data
% ---------------------------------------------------------------------
catdat              = cfg_repeat;
catdat.tag          = 'catdat';
catdat.name         = 'Categorical data';
catdat.values       = {addlevel};
catdat.help         = {'If variable is categorical, specify "Levels" (i.e. value-category mappings)'};
catdat.val          = {};

% ---------------------------------------------------------------------
% Enter BIDS "Units"
% ---------------------------------------------------------------------
units               = cfg_entry;
units.tag           = 'units';
units.name          = 'Add measurement units';
units.help          = {'Measurement units, ideally in SI standard'};
units.strtype       = 's';
units.val           = {''};

% ---------------------------------------------------------------------
% Enter BIDS "TermURL"
% ---------------------------------------------------------------------
url                 = cfg_entry;
url.tag             = 'url';
url.name            = 'Add URL';
url.help            = {'Add term URL'};
url.strtype         = 's';
url.val             = {''};
url.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS TaskName
% ---------------------------------------------------------------------
taskname                 = cfg_entry;
taskname.tag             = 'taskname';
taskname.name            = 'Add Task Name';
taskname.help            = {'Name of the task (for resting state use the ?rest? prefix). No two tasks should have the same name. Task label is derived from this field by removing all non-alphanumeric ([a-zA-Z0-9]) characters. Note this does not have to be a ?behavioral task? that subjects perform, but can reflect some information about the conditions present when the data was acquired (e.g., ?rest?, ?seizure?, or ?sleep?). '};
taskname.strtype         = 's';
taskname.val             = {''};
taskname.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS TaskName
% ---------------------------------------------------------------------
taskdesc                 = cfg_entry;
taskdesc.tag             = 'taskdesc';
taskdesc.name            = 'Add Task Description';
taskdesc.help            = {'Add longer task description'};
taskdesc.strtype         = 's';
taskdesc.val             = {''};
taskdesc.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS Instructions
% ---------------------------------------------------------------------
taskinst                 = cfg_entry;
taskinst.tag             = 'taskinst';
taskinst.name            = 'Add Instructions';
taskinst.help            = {'Text of the instructions given to participants before the recording'};
taskinst.strtype         = 's';
taskinst.val             = {''};
taskinst.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS Institution
% ---------------------------------------------------------------------
instname                 = cfg_entry;
instname.tag             = 'instname';
instname.name            = 'Add Institution Name';
instname.help            = {'The name of the institution in charge of the equipment that produced the composite instances'};
instname.strtype         = 's';
instname.val             = {''};
instname.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS Institution dept
% ---------------------------------------------------------------------
instdept                 = cfg_entry;
instdept.tag             = 'instdept';
instdept.name            = 'Add Institution Department';
instdept.help            = {'The department in the institution in charge of the equipment that produced the composite instances'};
instdept.strtype         = 's';
instdept.val             = {''};
instdept.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS Institution address
% ---------------------------------------------------------------------
instadd                 = cfg_entry;
instadd.tag             = 'instadd';
instadd.name            = 'Add Institution Address';
instadd.help            = {'The address of the institution in charge of the equipment that produced the composite instances'};
instadd.strtype         = 's';
instadd.val             = {''};
instadd.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter CogPO
% ---------------------------------------------------------------------
cogpoid                 = cfg_entry;
cogpoid.tag             = 'cogpoid';
cogpoid.name            = 'Add CogPO ID';
cogpoid.help            = {'URL of the corresponding CogPO term.'};
cogpoid.strtype         = 's';
cogpoid.val             = {''};
cogpoid.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS Institution address
% ---------------------------------------------------------------------
cogatlas                 = cfg_entry;
cogatlas.tag             = 'cogatlas';
cogatlas.name            = 'Add CogAtlas ID';
cogatlas.help            = {'URL of the corresponding Cognitive Atlas Task term.'};
cogatlas.strtype         = 's';
cogatlas.val             = {''};
cogatlas.num             = [0 Inf];

% ---------------------------------------------------------------------
% Enter BIDS derivative, if variable is derived from others?
% ---------------------------------------------------------------------
derivative          = cfg_menu;
derivative.tag      = 'derivative';
derivative.name     = 'Derivative?';
derivative.help     = {'Is this measure derived from others e.g. total score?'};
derivative.labels   = {'Yes','No'};
derivative.values   = {true,false};
derivative.val      = {false};  

% ---------------------------------------------------------------------
% Make new blank table for this json?
% ---------------------------------------------------------------------
maketab              = cfg_menu;
maketab.tag          = 'maketab';
maketab.name         = 'Create new table?';
maketab.help         = {'Create new .tsv table for this json?'};
maketab.labels       = {'Yes','No'};
maketab.values       = {true,false};
maketab.val           = {false};    

% ---------------------------------------------------------------------
% Add new variable to JSON: BIDS tabular format
% ---------------------------------------------------------------------
addvar              = cfg_repeat;
addvar.tag          = 'addvar';
addvar.name         = 'Add datafield (tabular)';
addvar.values       = {varname longname description catdat units url derivative};
addvar.val          = {varname longname description};
addvar.help         = {'Complete JSON headings for new tabular variable. Any blank fields will be simply be removed'};

% ---------------------------------------------------------------------
% Add measurement tool metadata (if applicable)
% ---------------------------------------------------------------------
addtool             = cfg_branch;
addtool.tag         = 'addtool';
addtool.name        = 'Measurement tool metadata';
addtool.val         = {description url};
addtool.help        = {'If you are using a recognised measurement tool for your tabular data, you may want to include details at the start of the json file that describes the measurement tool (as a whole) e.g. Name and corresponding URL'};

% ---------------------------------------------------------------------
% Add measurement tool metadata (if applicable)
% ---------------------------------------------------------------------
addtask             = cfg_repeat;
addtask.tag         = 'addtask';
addtask.name        = 'Measurement task metadata';
addtask.values         = {taskname taskdesc taskinst instname instdept instadd cogpoid cogatlas};
addtask.val         = {taskname taskdesc};
addtask.help        = {'Add task data'};

% ---------------------------------------------------------------------
% Add Annotation  metadata (if applicable)
% ---------------------------------------------------------------------
metaauthor                 = cfg_entry;
metaauthor.tag             = 'metaauthor';
metaauthor.name            = 'Author of annotation file';
metaauthor.help            = {'Define author e.g. Lambert C'};
metaauthor.strtype         = 's';
metaauthor.val             = {''};
metaauthor.num             = [0 Inf];

metadescription                 = cfg_entry;
metadescription.tag             = 'metadescription';
metadescription.name            = 'Add description for annotation file';
metadescription.help            = {'Description of annotation'};
metadescription.strtype         = 's';
metadescription.val             = {''};
metadescription.num             = [0 Inf];

metadate                 = cfg_entry;
metadate.tag             = 'metadate';
metadate.name            = 'Date created';
metadate.help            = {'Date created in the form: yyyy-mm-ddTHH:MM:SS'};
metadate.strtype         = 's';
metadate.val             = {''};
metadate.num             = [0 Inf];

addannot             = cfg_repeat;
addannot.tag         = 'addannot';
addannot.name        = 'Data annotation metadata';
addannot.values         = {metaauthor metadescription metadate};
addannot.val         = {metaauthor metadescription};
addannot.help        = {'Add task data'};


% ---------------------------------------------------------------------
% Add contents (variables) to JSON file
% ---------------------------------------------------------------------
inputjson           = cfg_repeat;
inputjson.tag       = 'inputjson';
inputjson.name      = 'Add JSON file contents';
inputjson.values    = {addtool addtask addannot addvar};
inputjson.help      = {'Add structured fields to JSON file'};
inputjson.val       = {};
inputjson.num       = [1 Inf];

% ---------------------------------------------------------------------
% Create new JSON file: Necessary input
% ---------------------------------------------------------------------
input           = cfg_branch;
input.tag       = 'input';
input.name      = 'New JSON file';
input.val       = {filename inputjson maketab};
input.help      = {'Create BIDS compliant JSON files'};

% ---------------------------------------------------------------------
% Create new JSON file
% ---------------------------------------------------------------------
inputtab            = cfg_repeat;
inputtab.tag        = 'inputtab';
inputtab.name       = 'Add new JSON file';
inputtab.values     = {input};
inputtab.help       = {'Manually create BIDS compliant JSON files'};
inputtab.val        = {input};

%% BRANCH SUB-COMPONENTS: Read JSON file(s)
% Include save batch from generic
% ---------------------------------------------------------------------
% Select JSON files
% ---------------------------------------------------------------------
jsonselect         = cfg_files;
jsonselect.tag     = 'jsonselect';
jsonselect.name    = 'Select JSON files';
jsonselect.help    = {'Select JSON files (at the moment only for tabular data)'};
jsonselect.filter = 'json';
jsonselect.ufilter = '.*';
jsonselect.num     = [1 Inf];

% ---------------------------------------------------------------------
% Select JSON files
% ---------------------------------------------------------------------
jsonselect1         = cfg_files;
jsonselect1.tag     = 'jsonselect1';
jsonselect1.name    = 'Select JSON file';
jsonselect1.help    = {'Select JSON file (at the moment only for tabular data)'};
jsonselect1.filter = 'json';
jsonselect1.ufilter = '.*';
jsonselect1.num     = [0 inf];

% ---------------------------------------------------------------------
% Add to new table
% ---------------------------------------------------------------------
addmerge              = cfg_menu;
addmerge.tag          = 'addmerge';
addmerge.name         = 'Create batch for "Merge JSON files"';
addmerge.help         = {'Will save a SPM batch that will load "Merge JSON files" pipeline'};
addmerge.labels       = {'Yes','No'};
addmerge.values       = {true,false};
addmerge.val           = {false};  

%% BRANCH SUB-COMPONENTS: Merge JSON file(s)
% Include filename from generic for save
% ---------------------------------------------------------------------
% Add to new table
% ---------------------------------------------------------------------
addtab              = cfg_menu;
addtab.tag          = 'addtab';
addtab.name         = 'Add to table?';
addtab.help         = {'Add this variable to new table?'};
addtab.labels       = {'Yes','No'};
addtab.values       = {true,false};
addtab.val           = {true};    

% ---------------------------------------------------------------------
% Add to new table
% ---------------------------------------------------------------------
addcalc        = cfg_entry;
addcalc.tag     = 'addcalc';
addcalc.name    = 'Add calculation';
addcalc.help    = {
                      'Use some of the input variables to create a new derivative'
                      'To use this, you must be supplying the corresponding .tsv files for all input json files'
                      'Simply use the variable names with "tab." prefix [example here uses "score"] to write a valid matlab expression, e.g:'
                      ''
                      '  * Identify all those above a score threshold of 5'
                      '        tab.score>5'
                      '  * Add a few scores together'
                      '        tab.score1 + tab.score2 + tab.score3 ...'
                      '  * Create derivative scores'
                      '        (tab.score1.*tab.score2)./tab.score3'
}';
addcalc.strtype = 's';
addcalc.num     = [0 Inf];

% ---------------------------------------------------------------------
% Add TSV to extract columns (if available)
% ---------------------------------------------------------------------
addtsv              = cfg_files;
addtsv.tag          = 'addtsv';
addtsv.name         = 'TSV file';
addtsv.help         = {'Select tsv file(s)'};
addtsv.filter       = 'tsv';
addtsv.ufilter      = '.*';
addtsv.num          = [0 1];

% ---------------------------------------------------------------------
% Add new variable to JSON: BIDS tabular format - Merge JSON version
% ---------------------------------------------------------------------
addmvar              = cfg_repeat;
addmvar.tag          = 'addmvar';
addmvar.name         = 'Add datafield (tabular)';
addmvar.values       = {addtab varname longname description catdat units url derivative addcalc};
addmvar.val          = {addtab varname longname description};
addmvar.help         = {'Complete JSON headings for new tabular variable. Any blank fields will be simply be removed'};

% ---------------------------------------------------------------------
% Add contents (variables) to merge JSON file
% ---------------------------------------------------------------------
inputmjson           = cfg_repeat;
inputmjson.tag       = 'inputmjson';
inputmjson.name      = 'Merge JSON: Individual file contents';
inputmjson.values    = {addtool addmvar addtsv};
inputmjson.help      = {'Merge JSON files to create new. If corresponding tsv files are selected, the data will be extracted and placed in new table. This can also be applied to longitudinal data. NOTE: The pipeline expects the same number of tsv entries per json file, and the rows should align (i.e. same subjects/same order). If no tsv files are selected a new blank table will be created'};
inputmjson.val       = {};
inputmjson.num       = [1 Inf];

% ---------------------------------------------------------------------
% Create new JSON file: Necessary input
% ---------------------------------------------------------------------
inputm           = cfg_branch;
inputm.tag       = 'inputm';
inputm.name      = 'New merge JSON files';
inputm.val       = {jsonselect1 inputmjson};
inputm.help      = {'Create BIDS compliant JSON files'};

% ---------------------------------------------------------------------
% Create new JSON file
% ---------------------------------------------------------------------
inputmtab            = cfg_repeat;
inputmtab.tag        = 'inputmtab';
inputmtab.name       = 'Add new JSON file';
inputmtab.values     = {inputm};
inputmtab.help       = {'Select contents from BIDS compliant JSON files'};
inputmtab.val        = {inputm};

%% MAIN TOOLBOX OPTIONS
% ---------------------------------------------------------------------
% 1. BIDS: DATASET DESCRIPTION
% ---------------------------------------------------------------------
datadescription     = cfg_exbranch;
datadescription.tag = 'datadescription';
datadescription.name= 'Create dataset description';
datadescription.val = {name bidsver license authors ackopt addack fund ethicsopt ref doi outdir};
datadescription.help= {'Create BIDS compliant dataset description json file'};
datadescription.prog= @bids_create_datadescription;

% ---------------------------------------------------------------------
% 2. BIDS: MAKE JSON FILES
% ---------------------------------------------------------------------
makejson     = cfg_exbranch;
makejson.tag = 'makejson';
makejson.name= 'Create JSON files';
makejson.val = {inputtab outdir};
makejson.help= {'Create BIDS compliant JSON files for any tabular data'};
makejson.prog= @bids_make_json;

% ---------------------------------------------------------------------
% 3. BIDS: READ JSON FILES
% ---------------------------------------------------------------------
readjson     = cfg_exbranch;
readjson.tag = 'readjson';
readjson.name= 'Read JSON files';
readjson.val = {filename outdir addmerge jsonselect};
readjson.help= {'Read in JSON files and make "Create JSOB files" job batch (for checking/editing). Currently, you have to load the .mat output into the GUI. If you select the "Merge" option, then the batch will be formatted to combine all of variables into a single json, that you can then format/merge in the same way as "read_json".'};
readjson.prog= @bids_read_json;

%% MAIN SPM MENU: BIDS TOOLBOX
cfg                 = cfg_choice;
cfg.tag             = 'bids';
cfg.name            = 'BIDS';
cfg.values          = {datadescription makejson readjson};
end
