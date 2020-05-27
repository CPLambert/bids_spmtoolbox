function cfg = tbx_cfg_bids
% BIDS Toolbox
% Collection of useful functions for creating BIDs compliant datasets in
% SPM.
%_______________________________________________________________________
% Version History:
% Version 1.0, May 2020
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
filename.num             = [1 Inf];

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
bidsver.val         = {'1.3.0'};
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
url.num             = [1 Inf];

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
% Add contents (variables) to JSON file
% ---------------------------------------------------------------------
inputjson           = cfg_repeat;
inputjson.tag       = 'inputjson';
inputjson.name      = 'Add JSON file contents';
inputjson.values    = {addtool addvar};
inputjson.help      = {'Add structured fields to JSON file'};
inputjson.val       = {};
inputjson.num       = [1 Inf];

% ---------------------------------------------------------------------
% Create new JSON file: Necessary input
% ---------------------------------------------------------------------
input           = cfg_branch;
input.tag       = 'input';
input.name      = 'New JSON file';
input.val       = {filename inputjson};
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
% Load selected JSON files into the SPM batch GUI
% ---------------------------------------------------------------------
loadbatch          = cfg_menu;
loadbatch.tag      = 'loadbatch';
loadbatch.name     = 'Load batch window';
loadbatch.help     = {'Open new spm batch window and load selected JSON files'};
loadbatch.labels   = {'Yes','No'};
loadbatch.values   = {true,false};
loadbatch.val      = {true}; 

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
readjson.val = {jsonselect loadbatch savebatch};
readjson.help= {'Read in JSON files and make "Create JSOB files" job batch (for checking/editing). Leave filename blank if you do not want to save batch'};
readjson.prog= @bids_read_json;

% ---------------------------------------------------------------------
% run test
% ---------------------------------------------------------------------
bselect         = cfg_files;
bselect.tag     = 'bselect';
bselect.name    = 'Select files';
bselect.help    = {'Select JSON files (at the moment only for tabular data)'};
bselect.filter = 'mat';
bselect.ufilter = '.*';
bselect.num     = [1 Inf];

runtest     = cfg_exbranch;
runtest.tag = 'runtest';
runtest.name= 'test';
runtest.val = {bselect};
runtest.help= {'Read in JSON files and make "Create JSOB files" job batch (for checking/editing). Leave filename blank if you do not want to save batch'};
runtest.prog= @goon;

%% MAIN SPM MENU: BIDS TOOLBOX
cfg                 = cfg_choice;
cfg.tag             = 'bids';
cfg.name            = 'BIDS';
cfg.values          = {datadescription makejson readjson runtest};
end