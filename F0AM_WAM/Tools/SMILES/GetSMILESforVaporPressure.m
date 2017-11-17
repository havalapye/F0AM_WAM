%get the SMILES from the MCM into a text file so you can 
%9/30/16 ELD
%feed this generated text file into:
%http://umansysprop.seaes.manchester.ac.uk/tool/vapour_pressure 
%to get vapor pressures, export as excel spreadsheet

% %if you want to change the SMILES/mol weight, etc, might need to clear them
% %out first if they already exist
% jnk = strcmp(MCMnames, 'DHHPAO2'); ind = find(jnk==1); %where the DHDHP stuff added
% MCMnames(ind:end) = []; InChI(ind:end) = []; SMILES(ind:end) = [];
% MolWeight(ind:end) = [];


load C:\MATLAB_Emma\Models\F0AM\F0AMv3.1_GP\Tools\SMILES\MCMv331SpeciesInfo.mat

fID = fopen('SMILES.txt','w');
 
 formatSpec = '%s \n';
 
 [nrows,ncols] = size(SMILES);
 
 for row = 1:nrows;
     fprintf(fID, formatSpec, SMILES{row,:});
 end
 
 fclose(fID);
 
 
 