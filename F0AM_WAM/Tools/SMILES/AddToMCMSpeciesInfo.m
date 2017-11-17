function k = AddToMCMSpeciesInfo(nnames,nforms,nmass,nsmiles,matfilepath)
% AddToMCMSpeciesInfo.m
% Adds info for new chemical species to the MCMnames, MolWeight and MolFormula variables of MCMSpeciesInfo.mat file.
% Use MCMmassread.m and the mcm_subset_mass.txt file downloaded from the
% MCM website to create the .mat file if it doesn't exist. 
%
% Inputs required to run this script:
% nnames:       cell array of species names to add
% nforms:       cell array of molecular formulas - must be in same order as nnames
% nmass:        exact molecular mass of each new species (e.g., use "tof_exact_mass.m"
%                   from University of Helsinki, or UW, to generate the exact mass from the nforms
%                   cell array)
% nsmiles:      people who actually use the SMILES string, for reasons I do not
%                   understand,can add those too. If you don't have it, use {'UNKOWN'} in the function
%                   call
% matfilepath:  path string to the MCMSpeciesInfo.mat file, make sure
% string includes both the directory location AND file name.
% 
% The output is structure containing the new MCMnames, MolWeight,
% MolFormula, and SMILES fields, and the variables are also saved in the
% MCMSpeciesInfo.mat file
%
% Example call: junk = AddToMCMSpeciesInfo(SpeciesToAdd,FormulasToAdd,SpeciesMasses,{'UNKNOWN'},matfilepath) 
% 071614 Joel Thornton (UW)

%% Check for variable length consistency
% if (length(nnames) ~= length(nforms)) || (length(nnames) ~= length(nmass)) || (length(nforms) ~= length(nmass))
%     display('Names, formulas, and masses have to be the same length. SMILES length has to be less than or equal to Names. Aborting...')
%     return
% end



if ~isempty(nsmiles)
        
    if length(nsmiles)>length(nnames)
        display('SMILES length greater than Names, aborting...')
        return
    elseif length(nsmiles)<length(nnames)
        display('SMILES strings not same length as Names. Will add UNKNOWN for missing strings at the end of nsmiles')
        nsmiles([length(nsmiles)+1:length(nnames)])={'UNKNOWN'};
    end
end
%% Load MCMSpeciesInfo.mat
load(matfilepath)

%% Check For Preexisting Names
addit = ones(1,length(nnames));
for i=1:length(nnames)
    if any(strcmp(nnames{i},MCMnames))
        addit(i) =0;
        display([nnames(i),' is already an MCM name, it will NOT be added'])
    end
end
nnames = nnames(addit==1); nmass = nmass(addit==1); nforms = nforms(addit==1); 
if ~isempty(nsmiles)
nsmiles = nsmiles(addit==1);
end

%% ADD TO MCMnames, MolWeight, MolFormulas, and SMILES

if ~isempty(nnames)
    lnames = length(nnames);
    MCMnames(end+1:end+lnames)=nnames;
else
    display('Non-duplicative names array is empty. Aborting...')
    k = [];
    return
end

if ~isempty(nmass)
    lmass = length(nmass);
    MolWeight(end+1:end+lmass)=nmass;
else
    display('Non-duplicative molecular mass array is empty. Aborting...')
    k = [];
    return
end

if ~isempty(nforms) && exist('MolForms')
    lforms = length(nforms);
    MolForms(end+1:end+lforms)=nforms;
elseif ~isempty(nforms) && exist ('InChI')
    lforms = length(nforms);
    InChI(end+1:end+lforms) = {'NaN'};
else
    display('Non-duplicative molecular formula array is empty. Aborting...')
    k=[];
    return
end

if ~isempty(nsmiles)
    lsmiles = length(nsmiles);
    SMILES(end+1:end+lsmiles)=nsmiles;
elseif isempty(nsmiles) && ~isempty(nnames)
    SMILES(end+1:end+lnames)={'UNKNOWN'};
else
    k = [];
    return
end

%% Save new MCMSpeciesInfo.mat file
eval(['save ',matfilepath,' MCMnames MolWeight InChI SMILES'])

%% Output structure
jnk = struct('MCMnames',{MCMnames},'MolWeight',MolWeight,'SMILES',{SMILES});

%%
k = jnk;




