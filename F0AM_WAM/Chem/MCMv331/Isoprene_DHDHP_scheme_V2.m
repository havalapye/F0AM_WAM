% Isoprene_DHDHP_scheme.m
% generated based on PNNL observations
%
%*********************************************************
% IMPORTANT NOTE ON USAGE!
% This mechanism is designed for use with the isoprene mechanism found in
% MCM v3.2 and UWCM v2.1
% This must appear after the MCM mechanism in the "ChemFiles" structure.
%*********************************************************
%
% This mechanism follows the detailed MCM-protocol for representation of
% reactions resulting from Joel's brain.


% 2014-0603 JAT
% # of species = I have no idea
% # of reactions = I have no idea (123--ELD 12/8/16)

%TO REMOVE
%ISOPAOOH + OH --> IEPOXA
%ISOPBOOH + OH --> IEPOXB
%ISOPCOOH + OH --> IEPOXC
%ISOPDOOH + OH --> IEPOXB --YES, IEPOXB

%ISOPDOOH + OH --> HCOC5 + OH - at least make it <22% yield, for other
%ISOPOOH isomers in the MCM, this reaction is max 5% of total OH + ISOPOOH.

SpeciesToAdd = {...
'DHHPAO2';'DHHPBO2';'DHHPCO2';'DHHPDO2';'THHPO2';'DHHPBNO3';'DHHPANO3';'DHHPCNO3';'DHHPDNO3';...
'DHDHP';'THHP';'DHHPAO';'DHHPBO';'DHHPCO';'DHHPDO'; 'THHPO'; 'THHPBO'; 'THBC5O'; 'THACDC5O';...
'THDHP'; 'THHPNO3';'TETROLHP';'HYPERACETOL'; 'C5H10O6'; 'C5H10O7'; 'ALCOCH2OOH';'DHHEPOX';...
'THHO2'; 'TETROL';'THHNO3';'THHO';'C5H8O4epox';'C5H8O5';'C5H8O4ald';'DHDHPket';'HDHPald';...
'DHPDA';'HHPDc';'HHPcarb';'HDHPDc';...
};

RO2ToAdd = {...
'DHHPAO2';'DHHPBO2';'DHHPCO2';'DHHPDO2';'THHPO2';'THHO2'; };

AddSpecies

%% Add species, formulas, and masses to MCMSpeciesInfo.mat file
matfilepath = 'C:\MATLAB_Emma\Models\F0AM\F0AMv3.1_GP\Tools\SMILES\MCMv331SpeciesInfo.mat';

SpeciesToAdd = {...
'DHHPAO2';'DHHPBO2';'DHHPCO2';'DHHPDO2';'THHPO2';'DHHPBNO3';'DHHPANO3';'DHHPCNO3';'DHHPDNO3';...
'DHDHP';'THHP';'DHHPAO';'DHHPBO';'DHHPCO';'DHHPDO'; 'THHPO'; 'THHPBO'; 'THBC5O'; 'THACDC5O';...
'THDHP'; 'THHPNO3';'TETROLHP';'HYPERACETOL'; 'C5H10O6'; 'C5H10O7'; 'ALCOCH2OOH';'DHHEPOX';...
'THHO2'; 'TETROL';'THHNO3';'THHO';'C5H8O4epox';'C5H8O5';'C5H8O4ald';'DHDHPket';'HDHPald';...
'DHPDA';'HHPDc';'HHPcarb';'HDHPDc';...
};

FormulasToAdd = {...
'C5H11O6';'C5H11O6';'C5H11O6';'C5H11O6';'C5H11O7';'C5H11O7N';'C5H11O7N';'C5H11O7N';'C5H11O7N';...
'C5H12O6';'C5H12O5';'C5H11O5';'C5H11O5';'C5H11O5';'C5H11O5'; 'C5H11O6'; 'C5H11O6'; 'C5H11O4'; ...
'C5H11O4'; 'C5H12O7'; 'C5H11O8N'; 'C5H12O6'; 'C3H6O4'; 'C5H10O6'; 'C5H10O7'; 'C3H4O4';...
'C5H10O5'; 'C5H11O5';'C5H12O4';'C5H11NO6';'C5H11O4';'C5H8O4';'C5H8O5';'C5H8O4';'C5H10O7';...
'C5H10O6';'C5H8O6';'C5H8O5';'C5H8O6';'C5H8O7';...
};

MassesToAdd = tof_exact_mass(FormulasToAdd);

SMILESToAdd = {'CC(C(O)COO)(O[O])CO';'CC(C(O[O])CO)(OO)CO';'CC(C(O)CO)(O[O])COO';'CC(C(OO)CO)(O[O])CO';...
    'OC(C(OO)CO)(CO[O])CO';'CC(C(O[N+]([O-])=O)CO)(OO)CO';'CC(C(O)COO)(O[N+]([O-])=O)CO';'CC(C(O)CO)(O[N+]([O-])=O)COO';...
    'CC(C(OO)CO)(O[N+]([O-])=O)CO';'CC(C(OO)CO)(OO)CO';'CC(C(O)CO)(OO)CO';'CC(C(O)COO)([O])CO';'CC(C([O])CO)(OO)CO';...
    'CC(C(O)CO)([O])COO';'CC(C(OO)CO)([O])CO';'OCC(C(CO)OO)(O)C[O]';'CC(C(C(O)[O])OO)(O)CO';'CC([O])(CO)C(O)CO';...
    'CC(O)(CO)C([O])CO';'OCC(C(CO)OO)(O)COO';'OCC(C(CO)OO)(O)CO[N+]([O-])=O';'OCC(C(CO)OO)(O)CO';...
    'O=C(CO)COO';'OCC(C(CO)OO)(O)C=O';'O=CC(C(CO)OO)(O)COO';'O=C(COO)C=O';'CC(C(O1)C1O)(OO)CO';...
    'CC(C(CO)O)(O[O])CO';'CC(C(CO)O)(O)CO';'CC(C(CO)O[N+]([O-])=O)(O)CO';'CC(C(CO)[O])(O)CO';'CC(C(O1)C1O)(O2)C2O';...
    'CC(C(OO)C=O)(O1)C1O';'CC(C(CO)=O)(O1)C1O';'CC(C(CO)=O)(OO)C(OO)O';'CC(C(CO)OO)(OO)C=O';'CC(C(C=O)OO)(OO)C=O';...
    'CC(C(CO)=O)(OO)C=O';'CC(C(CO)=O)(OO)C(O)=O';'CC(C(C=O)=O)(OO)C(OO)O';...
    };
%12/2/16: for model paper, did all runs with wrong SMILES for THHPO2,
%THHPO, THHPBO, THDHP, THHPNO3, TETROLHP, HPMVKOH, C5H10O7... not sure why
%the wrong SMILES were in here... only for 8 compounds that are not major
%components. C5H10O7 however is a somewhat important compound?

junk = AddToMCMSpeciesInfo(SpeciesToAdd,FormulasToAdd,MassesToAdd,SMILESToAdd,matfilepath);
clear junk SpeciesToAdd FormulasToAdd MassesToAdd SMILESToAdd

%% remove old ISOPOOH oxidation
RxnToReplace = 'OH + ISOPAOOH = ISOPAO2';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPBOOH = ISOPBO2';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPCOOH = ISOPCO2';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPDOOH = ISOPDO2';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPAOOH = IEPOXA + OH';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPBOOH = IEPOXB + OH';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPCOOH = IEPOXC + OH';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPDOOH = IEPOXB + OH';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPAOOH = HC4ACHO + OH';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPCOOH = HC4CCHO + OH';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPDOOH = HCOC5 + OH';
kToReplace = 0;
ReplaceRxn

%remove NISOPOOH oxidation
RxnToReplace = 'OH + NISOPOOH = NC4CHO + OH';
kToReplace = 0;
ReplaceRxn

%remove old ISOPOH oxidation (C5H10O2)
%note: CISOPCO2-->ISOPCOOH, but there is no ISOPCOH, CISOPCO2 goes to ISOPAOH
RxnToReplace = 'OH + ISOPAOH = HC4ACHO + HO2';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPAOH = HC4CCHO + HO2';
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPBOH = ISOPBO'; 
kToReplace = 0;
ReplaceRxn

RxnToReplace = 'OH + ISOPDOH = HCOC5 + HO2';
kToReplace = 0;
ReplaceRxn



%new chemistry
% %%N2O5 wall loss
% i=i+1;
% Rnames{i} = 'N2O5 + wall = product';
% k(:,i) = 0.1; %our estimated diffusion rate constant 
% Gstr{i,1} = 'N2O5'; 
% fN2O5(i)=fN2O5(i)-1; 

%% OH+ ISOPOH
i=i+1;
Rnames{i} = 'OH + ISOPAOH = HC4ACHO + HO2';
k(:,i) = 9.3E-11.*0.05;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPAOH'; 
fOH(i)=fOH(i)-1; fISOPAOH(i)=fISOPAOH(i)-1; fHC4ACHO(i)=fHC4ACHO(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPAOH = HC4CCHO + HO2';
k(:,i) = 9.3E-11.*0.05;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPAOH'; 
fOH(i)=fOH(i)-1; fISOPAOH(i)=fISOPAOH(i)-1; fHC4CCHO(i)=fHC4CCHO(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPAOH = THHO2'; %C5H11O5 peroxy radical
k(:,i) = 9.3E-11.*0.9;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPAOH'; 
fOH(i)=fOH(i)-1; fISOPAOH(i)=fISOPAOH(i)-1; fTHHP(i)=fTHHP(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPBOH = MVK + HCHO + HO2';
k(:,i) = 3.85E-11.*0.1;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPBOH'; 
fOH(i)=fOH(i)-1; fISOPBOH(i)=fISOPBOH(i)-1; fMVK(i)=fMVK(i)+1; fHCHO(i)=fHCHO(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPBOH = THHO2'; %C5H11O5 peroxy radical
k(:,i) = 3.85E-11.*0.9;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPBOH'; 
fOH(i)=fOH(i)-1; fISOPBOH(i)=fISOPBOH(i)-1; fTHHP(i)=fTHHP(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPDOH = HCOC5 + HO2';
k(:,i) = 7.38E-11.*0.1;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPDOH'; 
fOH(i)=fOH(i)-1; fISOPDOH(i)=fISOPDOH(i)-1; fHCOC5(i)=fHCOC5(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPDOH = THHO2'; %C5H11O5 peroxy radical
k(:,i) = 7.38E-11.*0.9;
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPDOH'; 
fOH(i)=fOH(i)-1; fISOPDOH(i)=fISOPDOH(i)-1; fTHHP(i)=fTHHP(i)+1; 

%%ISOPOOH+NO3 -- probably need to change these rate constants AND
%%products!
i=i+1;
Rnames{i} = 'NO3 + ISOPAOOH = IEPOXA + OH';
k(:,i) = 3.15E-12*exp(-450/T);  
Gstr{i,1} = 'NO3'; Gstr{i,2} = 'ISOPAOOH'; 
fOH(i)=fOH(i)+1; fISOPAOOH(i)=fISOPAOOH(i)-1; fIEPOXA(i)=fIEPOXA(i)+1; fNO3(i)=fNO3(i)-1;

i=i+1;
Rnames{i} = 'NO3 + ISOPBOOH = IEPOXB + OH';
k(:,i) = 3.15E-12*exp(-450/T);
Gstr{i,1} = 'NO3'; Gstr{i,2} = 'ISOPBOOH'; 
fOH(i)=fOH(i)+1; fISOPBOOH(i)=fISOPBOOH(i)-1; fIEPOXB(i)=fIEPOXB(i)+1; fNO3(i)=fNO3(i)-1;

i=i+1;
Rnames{i} = 'NO3 + ISOPCOOH = IEPOXC + OH';
k(:,i) =3.15E-12*exp(-450/T);
Gstr{i,1} = 'NO3'; Gstr{i,2} = 'ISOPCOOH'; 
fOH(i)=fOH(i)+1; fISOPCOOH(i)=fISOPCOOH(i)-1; fIEPOXC(i)=fIEPOXC(i)+1; fNO3(i)=fNO3(i)-1;

i=i+1;
Rnames{i} = 'NO3 + ISOPDOOH = IEPOXB + OH';
k(:,i) = 3.15E-12*exp(-450/T);
Gstr{i,1} = 'NO3'; Gstr{i,2} = 'ISOPDOOH'; 
fOH(i)=fOH(i)+1; fISOPDOOH(i)=fISOPDOOH(i)-1; fIEPOXB(i)=fIEPOXB(i)+1; fNO3(i)=fNO3(i)-1;

%----------------------------------------------------------------------------------------
%ISOPOOH + OH reactions

%%IEPOX formation
i=i+1;
Rnames{i} = 'OH + ISOPAOOH = IEPOXA + OH';
k(:,i) = 0.58.*1.54e-10; %0.93from MCM 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPAOOH'; 
fOH(i)=fOH(i)-0; fISOPAOOH(i)=fISOPAOOH(i)-1; fIEPOXA(i)=fIEPOXA(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'OH + ISOPBOOH = IEPOXB + OH';
k(:,i) = 0.72.*5e-11; %0.92from MCM %roughly 25x greater than .04 per Bate's 2014 relative iepox yields
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPBOOH'; 
fOH(i)=fOH(i)-0; fISOPBOOH(i)=fISOPBOOH(i)-1; fIEPOXB(i)=fIEPOXB(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'OH + ISOPCOOH = IEPOXC + OH';
k(:,i) = 0.58.*1.54e-10; %0.93from MCM
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPCOOH'; 
fOH(i)=fOH(i)-0; fISOPCOOH(i)=fISOPCOOH(i)-1; fIEPOXC(i)=fIEPOXC(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'OH + ISOPDOOH = IEPOXB + OH';
k(:,i) = 0.72.*1.15e-10;%0.75from MCM 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPDOOH'; 
fOH(i)=fOH(i)-0; fISOPDOOH(i)=fISOPDOOH(i)-1; fIEPOXB(i)=fIEPOXB(i)+1; fOH(i)=fOH(i)+1;

%%DHHPO2 formation
i=i+1;
Rnames{i} = 'OH + ISOPAOOH = DHHPAO2';
k(:,i) = 0.38.*1.54e-10; % 0.96.*1.54e-10; %0.05
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPAOOH'; 
fOH(i)=fOH(i)-1; fISOPAOOH(i)=fISOPAOOH(i)-1; fDHHPAO2(i)=fDHHPAO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPBOOH = DHHPBO2';
k(:,i) = 0.2.*5e-11; %0.3.*5e-11; %0.1.*5e-11; %0.08 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPBOOH'; 
fOH(i)=fOH(i)-1; fISOPBOOH(i)=fISOPBOOH(i)-1; fDHHPBO2(i)=fDHHPBO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPCOOH = DHHPCO2';
k(:,i) = 0.38.*1.54e-10; %0.96.*1.54e-10; %0.05
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPCOOH'; 
fOH(i)=fOH(i)-1; fISOPCOOH(i)=fISOPCOOH(i)-1; fDHHPCO2(i)=fDHHPCO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPDOOH = DHHPDO2';
k(:,i) = 0.2.*1.15e-10; % 0.3.*1.15e-10; %0.1.*1.15e-10; %0.08 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPDOOH'; 
fOH(i)=fOH(i)-1; fISOPDOOH(i)=fISOPDOOH(i)-1; fDHHPDO2(i)=fDHHPDO2(i)+1; 

%%ISOPO2 formation
i=i+1;
Rnames{i} = 'OH + ISOPAOOH = ISOPAO2';
k(:,i) = 0.02.*1.54e-10; 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPAOOH'; 
fOH(i)=fOH(i)-1; fISOPAOOH(i)=fISOPAOOH(i)-1; fISOPAO2(i)=fISOPAO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPBOOH = ISOPBO2';
k(:,i) = 0.08.*5e-11; 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPBOOH'; 
fOH(i)=fOH(i)-1; fISOPBOOH(i)=fISOPBOOH(i)-1; fISOPBO2(i)=fISOPBO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPCOOH = ISOPCO2';
k(:,i) = 0.02.*1.54e-10; 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPCOOH'; 
fOH(i)=fOH(i)-1; fISOPCOOH(i)=fISOPCOOH(i)-1; fISOPCO2(i)=fISOPCO2(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPDOOH = ISOPDO2';
k(:,i) = 0.03.*1.15e-10; 
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPDOOH'; 
fOH(i)=fOH(i)-1; fISOPDOOH(i)=fISOPDOOH(i)-1; fISOPDO2(i)=fISOPDO2(i)+1; 

%%Alkenal formation
i=i+1;
Rnames{i} = 'OH + ISOPAOOH = HC4ACHO + OH';
k(:,i) = 0.02.*1.54e-10;%0.02from MCM
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPCOOH'; 
fOH(i)=fOH(i)-0; fISOPCOOH(i)=fISOPCOOH(i)-1; fHC4ACHO(i)=fHC4ACHO(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'OH + ISOPCOOH = HC4CCHO + OH';
k(:,i) = 0.02.*1.54e-10;%0.02from MCM
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPCOOH'; 
fOH(i)=fOH(i)-0; fISOPCOOH(i)=fISOPCOOH(i)-1; fHC4CCHO(i)=fHC4CCHO(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'OH + ISOPDOOH = HCOC5 + OH';
k(:,i) = 0.05.*1.15e-10;%0.22from MCM
Gstr{i,1} = 'OH'; Gstr{i,2} = 'ISOPDOOH'; 
fOH(i)=fOH(i)-0; fISOPDOOH(i)=fISOPDOOH(i)-1; fHCOC5(i)=fHCOC5(i)+1; fOH(i)=fOH(i)+1;

%----------------------------------------------------------------------------------------

%%THHO2
i=i+1;
Rnames{i} = 'THHO2 + Isomerization = C57OOH'; %C5H10O5 formed
k(:,i) = 0.002; %Isomerization of ISOPOO radical (crounse)                           
Gstr{i,1} = 'THHO2'; 
fTHHO2(i)=fTHHO2(i)-1; fC57OOH(i)=fC57OOH(i)+1;

i=i+1;
Rnames{i} = 'THHO2 + NO = THHO + NO2';
k(:,i) = KRO2NO.*0.892;
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'NO'; 
fTHHO2(i)=fTHHO2(i)-1; fNO(i)=fNO(i)-1; fTHHO(i)=fTHHO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'THHO2 + NO = THHNO3';
k(:,i) = KRO2NO.*0.108;
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'NO'; 
fTHHO2(i)=fTHHO2(i)-1; fNO(i)=fNO(i)-1; fTHHNO3(i)=fTHHNO3(i)+1; 

i=i+1;
Rnames{i} = 'THHO2 + NO3 = THHO + NO2';
k(:,i) = KRO2NO3;
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'NO3'; 
fTHHO2(i)=fTHHO2(i)-1; fNO3(i)=fNO3(i)-1; fTHHO(i)=fTHHO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'THHO2 + HO2 = THHP';
k(:,i) = KRO2HO2;
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'HO2'; 
fTHHO2(i)=fTHHO2(i)-1; fHO2(i)=fHO2(i)-1; fTHHP(i)=fTHHP(i)+1; 

i=i+1;
Rnames{i} = 'THHO2 + RO2 =  THHO';
k(:,i) = 2.40e-11.*.1; 
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'RO2';
fTHHO2(i)=fTHHO2(i)-1; fTHHO(i)=fTHHO(i)+1; 

i=i+1;
Rnames{i} = 'THHO2 + RO2 = C58OH';
k(:,i) =  2.40e-11.*0.1; 
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'RO2';
fTHHO2(i)=fTHHO2(i)-1; fC58OH(i)=fC58OH(i)+1; 

i=i+1;
Rnames{i} = 'THHO2 + RO2 = TETROL';
k(:,i) =  2.40e-11.*.8; 
Gstr{i,1} = 'THHO2'; Gstr{i,2} = 'RO2';
fTHHO2(i)=fTHHO2(i)-1; fTETROL(i)=fTETROL(i)+1; 

%%THHO (alkoxy)
i=i+1;
Rnames{i} = 'THHO = THHO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHO'; 
fTHHO(i)=fTHHO(i)-1; fTHHO2(i)=fTHHO2(i)+1;

i=i+1;
Rnames{i} = 'THHO = TETROL + HO2'; 
k(:,i) = KDEC.*0.4;
Gstr{i,1} = 'THHO'; 
fTHHO(i)=fTHHO(i)-1; fTETROL(i)=fTETROL(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'THHO = MACROH + HCHO + HO2'; 
k(:,i) = KDEC.*0.1;
Gstr{i,1} = 'THHO';
fTHHO(i)=fTHHO(i)-1; fMACROH(i)=fMACROH(i)+1; fHCHO(i) = fHCHO(i) + 1; fHO2(i)=fHO2(i)+1; 
i=i+1;

Rnames{i} = 'THHO = ACETOL + HOCH2CHO + OH';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHO'; 
fTHHO(i)=fTHHO(i)-1; fHOCH2CHO(i)=fHOCH2CHO(i)+1; fACETOL(i) = fACETOL(i)+1; fOH(i)=fOH(i)+1; 


%%DHHPBO2
i=i+1;
Rnames{i} = 'DHHPBO2 + Isomerization = HDHPald + HO2';%this has a carbonyl
k(:,i) = 0.0099.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPBO2'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fHDHPald(i)=fHDHPald(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + Isomerization = DHDHPket + OH'; %dihydroxy dihydroperoxy ketone
k(:,i) = 0.0001.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPBO2'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fDHDHPket(i)=fDHDHPket(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + Isomerization = DHHEPOX + OH';%this has an epoxide
k(:,i) =  0.99.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                            
Gstr{i,1} = 'DHHPBO2'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fDHHEPOX(i)=fDHHEPOX(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + NO = DHHPBO + NO2';
k(:,i) = KRO2NO.*0.892;
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'NO'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fNO(i)=fNO(i)-1; fDHHPBO(i)=fDHHPBO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + NO = DHHPBNO3';
k(:,i) = KRO2NO.*0.108;
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'NO'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fNO(i)=fNO(i)-1; fDHHPBNO3(i)=fDHHPBNO3(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + NO3 = DHHPBO + NO2';
k(:,i) = KRO2NO3;
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'NO3'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fNO3(i)=fNO3(i)-1; fDHHPBO(i)=fDHHPBO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + HO2 = DHDHP';
k(:,i) = KRO2HO2;
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'HO2'; 
fDHHPBO2(i)=fDHHPBO2(i)-1; fHO2(i)=fHO2(i)-1; fDHDHP(i)=fDHDHP(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + RO2 =  DHHPBO';
k(:,i) = 2.40e-11.*.1; 
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'RO2';
fDHHPBO2(i)=fDHHPBO2(i)-1; fDHHPBO(i)=fDHHPBO(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + RO2 = C59OOH';
k(:,i) =  2.40e-11.*0.1; 
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'RO2';
fDHHPBO2(i)=fDHHPBO2(i)-1; fC59OOH(i)=fC59OOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO2 + RO2 = THHP';
k(:,i) =  2.40e-11.*.8; 
Gstr{i,1} = 'DHHPBO2'; Gstr{i,2} = 'RO2';
fDHHPBO2(i)=fDHHPBO2(i)-1; fTHHP(i)=fTHHP(i)+1; 

%DHHPBO (alkoxy)
i=i+1;
Rnames{i} = 'DHHPBO = THHPO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'DHHPBO'; 
fDHHPBO(i)=fDHHPBO(i)-1; fTHHPO2(i)=fTHHPO2(i)+1;

i=i+1;
Rnames{i} = 'DHHPBO = C57OOH + HO2'; %C57OOH is in MCM
k(:,i) = KDEC.*0.4;
Gstr{i,1} = 'DHHPBO'; 
fDHHPBO(i)=fDHHPBO(i)-1; fC57OOH(i)=fC57OOH(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPBO = MACROOH + HCHO + HO2'; %all products in MCM
k(:,i) = KDEC.*0.1;
Gstr{i,1} = 'DHHPBO';
fDHHPBO(i)=fDHHPBO(i)-1; fMACROOH(i)=fMACROOH(i)+1; fHCHO(i) = fHCHO(i) + 1; fHO2(i)=fHO2(i)+1; 
i=i+1;

Rnames{i} = 'DHHPBO = ACETOL + HOCH2CHO + OH';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'DHHPBO'; 
fDHHPBO(i)=fDHHPBO(i)-1; fHOCH2CHO(i)=fHOCH2CHO(i)+1; fACETOL(i) = fACETOL(i)+1; fOH(i)=fOH(i)+1; 


%%DHHPAO2
i=i+1;
Rnames{i} = 'DHHPAO2 + Isomerization = HDHPald + HO2';%this has a carbonyl
k(:,i) = 0.0099.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPAO2'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fHDHPald(i)=fHDHPald(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + Isomerization = DHDHPket + OH'; %dihydroxy dihydroperoxy ketone
k(:,i) = 0.0001.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPAO2'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fDHDHPket(i)=fDHDHPket(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + Isomerization = DHHEPOX + OH';%this has an epoxide
k(:,i) =  0.99.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                            
Gstr{i,1} = 'DHHPAO2'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fDHHEPOX(i)=fDHHEPOX(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + NO = DHHPAO + NO2'; 
k(:,i) = KRO2NO.*0.892;
Gstr{i,1} = 'DHHPAO2'; Gstr{i,2} = 'NO'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fNO(i)=fNO(i)-1; fDHHPAO(i)=fDHHPAO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + NO = DHHPANO3';
k(:,i) = KRO2NO.*0.108;
Gstr{i,1} = 'DHHPAO2'; Gstr{i,2} = 'NO'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fNO(i)=fNO(i)-1; fDHHPANO3(i)=fDHHPANO3(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + NO3 = DHHPAO + NO2';
k(:,i) = KRO2NO3;
Gstr{i,1} = 'DHHPAO2'; Gstr{i,2} = 'NO3'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fNO3(i)=fNO3(i)-1; fDHHPAO(i)=fDHHPAO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + HO2 = DHDHP';
k(:,i) = KRO2HO2;
Gstr{i,1} = 'DHHPAO2'; Gstr{i,2} = 'HO2'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fHO2(i)=fHO2(i)-1; fDHDHP(i)=fDHDHP(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + RO2 = DHHPAO';
k(:,i) =  2.40e-11.*0.2;  
Gstr{i,1} = 'DHHPAO2'; Gstr{i,2} = 'RO2';
fDHHPAO2(i)=fDHHPAO2(i)-1; fDHHPAO(i)=fDHHPAO(i)+1; 

i=i+1;
Rnames{i} = 'DHHPAO2 + RO2 = THHP';
k(:,i) = 2.40e-11.*0.8; 
Gstr{i,1} = 'DHHPAO2'; Gstr{i,2} = 'RO2';
fDHHPAO2(i)=fDHHPAO2(i)-1; fTHHP(i)=fTHHP(i)+1;

%DHHPAO (alkoxy)
i=i+1;
Rnames{i} = 'DHHPAO = C57OH + OH';
k(:,i) = KDEC.*0.2;
Gstr{i,1} = 'DHHPAO2';
fDHHPAO2(i)=fDHHPAO2(i)-1; fC57OH(i)=fC57OH(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'DHHPAO = HMVKAOOH + HCHO + HO2';
k(:,i) = KDEC.*0.3;
Gstr{i,1} = 'DHHPAO2'; 
fDHHPAO2(i)=fDHHPAO2(i)-1; fHMVKAOOH(i)=fHMVKAOOH(i)+1; fHCHO(i)=fHCHO(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'DHHPAO = ACETOL + HCOCH2OOH + HO2';
k(:,i) = KDEC.*0.5;
Gstr{i,1} = 'DHHPAO2';
fDHHPAO2(i)=fDHHPAO2(i)-1; fHO2(i)=fHO2(i)+1; fHCOCH2OOH(i)=fHCOCH2OOH(i)+1; fACETOL(i)=fACETOL(i)+1; 


%%DHHPCO2
i=i+1;
Rnames{i} = 'DHHPCO2 + Isomerization = HDHPald + HO2';%this has a carbonyl
k(:,i) = 0.0099.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPCO2'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fHDHPald(i)=fHDHPald(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + Isomerization = DHDHPket + OH'; %dihydroxy dihydroperoxy ketone
k(:,i) = 0.0001.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPCO2'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fDHDHPket(i)=fDHDHPket(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + Isomerization = DHHEPOX + OH';%this has an epoxide
k(:,i) =  0.99.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                            
Gstr{i,1} = 'DHHPCO2'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fDHHEPOX(i)=fDHHEPOX(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'DHHPCO2 + NO = DHHPCO + NO2';
k(:,i) = KRO2NO.*0.892;
Gstr{i,1} = 'DHHPCO2'; Gstr{i,2} = 'NO'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fNO(i)=fNO(i)-1; fDHHPCO(i)=fDHHPCO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + NO = DHHPCNO3';
k(:,i) = KRO2NO.*0.108;
Gstr{i,1} = 'DHHPCO2'; Gstr{i,2} = 'NO'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fNO(i)=fNO(i)-1; fDHHPCNO3(i)=fDHHPCNO3(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + NO3 = DHHPCO + NO2';
k(:,i) = KRO2NO3;
Gstr{i,1} = 'DHHPCO2'; Gstr{i,2} = 'NO3'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fNO3(i)=fNO3(i)-1; fDHHPCO(i)=fDHHPCO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + HO2 = DHDHP';
k(:,i) = KRO2HO2;
Gstr{i,1} = 'DHHPCO2'; Gstr{i,2} = 'HO2'; 
fDHHPCO2(i)=fDHHPCO2(i)-1; fHO2(i)=fHO2(i)-1; fDHDHP(i)=fDHDHP(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + RO2 = DHHPCO';
k(:,i) =  2.40e-11.*0.2; 
Gstr{i,1} = 'DHHPCO2'; Gstr{i,2} = 'RO2';
fDHHPCO2(i)=fDHHPCO2(i)-1; fDHHPCO(i)=fDHHPCO(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO2 + RO2 = THHP';
k(:,i) = 2.40e-11.*0.8;  
Gstr{i,1} = 'DHHPCO2'; Gstr{i,2} = 'RO2';
fDHHPCO2(i)=fDHHPCO2(i)-1; fTHHP(i)=fTHHP(i)+1; 

%DHHPCO (alkoxy)
i=i+1;
Rnames{i} = 'DHHPCO = C58OOH + HO2';
k(:,i) = KDEC.*0.2;
Gstr{i,1} = 'DHHPCO'; 
fDHHPCO(i)=fDHHPCO(i)-1; fC58OOH(i)=fC58OOH(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPCO = HO12CO3C4 + HCHO + OH';
k(:,i) = KDEC.*0.3;
Gstr{i,1} = 'DHHPCO'; 
fDHHPCO(i)=fDHHPCO(i)-1; fHCHO(i)=fHCHO(i)+1; fHO12CO3C4(i)=fHO12CO3C4(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'DHHPCO = HYPERACET + HOCH2CHO + HO2';
k(:,i) = KDEC.*0.5;
Gstr{i,1} = 'DHHPCO'; 
fDHHPCO(i)=fDHHPCO(i)-1; fHO2(i)=fHO2(i)+1; fHOCH2CHO(i)=fHOCH2CHO(i)+1; fHYPERACET(i)=fHYPERACET(i)+1; 


%%DHHPDO2
i=i+1;
Rnames{i} = 'DHHPDO2 + Isomerization = HDHPald + HO2';%this has a carbonyl
k(:,i) = 0.0099.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPDO2'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fHDHPald(i)=fHDHPald(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO2 + Isomerization = DHDHPket + OH'; %dihydroxy dihydroperoxy ketone
k(:,i) = 0.0001.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                           
Gstr{i,1} = 'DHHPDO2'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fDHDHPket(i)=fDHDHPket(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO2 + Isomerization = DHHEPOX + OH';%this has an epoxide
k(:,i) =  0.99.*0.8; %Isomerization of RO2 based on Kajegaerd measurements (5/2016)                            
Gstr{i,1} = 'DHHPDO2'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fDHHEPOX(i)=fDHHEPOX(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'DHHPDO2 + NO = DHHPDO + NO2';
k(:,i) = KRO2NO.*0.892;
Gstr{i,1} = 'DHHPDO2'; Gstr{i,2} = 'NO'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fNO(i)=fNO(i)-1; fDHHPDO(i)=fDHHPDO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO2 + NO = DHHPDNO3';
k(:,i) = KRO2NO.*0.108;
Gstr{i,1} = 'DHHPDO2'; Gstr{i,2} = 'NO'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fNO(i)=fNO(i)-1; fDHHPCNO3(i)=fDHHPCNO3(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO2 + NO3 = DHHPDO + NO2';
k(:,i) = KRO2NO3;
Gstr{i,1} = 'DHHPDO2'; Gstr{i,2} = 'NO3'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fNO3(i)=fNO3(i)-1; fDHHPDO(i)=fDHHPDO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO2 + HO2 = DHDHP';
k(:,i) = KRO2HO2;
Gstr{i,1} = 'DHHPDO2'; Gstr{i,2} = 'HO2'; 
fDHHPDO2(i)=fDHHPDO2(i)-1; fHO2(i)=fHO2(i)-1; fDHDHP(i)=fDHDHP(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO2 + RO2 =  DHHPDO';
k(:,i) = 2.40e-11.*0.2; 
Gstr{i,1} = 'DHHPDO2'; Gstr{i,2} = 'RO2';
fDHHPDO2(i)=fDHHPDO2(i)-1; fDHHPDO(i)=fDHHPDO(i)+1;

i=i+1;
Rnames{i} = 'DHHPDO2 + RO2 = THHP';
k(:,i) = 2.4e-11.*0.8; 
Gstr{i,1} = 'DHHPDO2'; Gstr{i,2} = 'RO2';
fDHHPDO2(i)=fDHHPDO2(i)-1; fTHHP(i)=fTHHP(i)+1; 

%DHHPDO (alkoxy)
i=i+1;
Rnames{i} = 'DHHPDO = C57OOH + HO2';
k(:,i) = KDEC.*0.5;
Gstr{i,1} = 'DHHPDO';
fDHHPDO(i)=fDHHPDO(i)-1; fC57OOH(i)=fC57OOH(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'DHHPDO = HMVKBOOH + HCHO + OH';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'DHHPDO';
fDHHPDO(i)=fDHHPDO(i)-1; fHCHO(i)=fHCHO(i)+1; fHMVKBOOH(i)=fHMVKBOOH(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHPDO = ACETOL + HOCH2CHO + HO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'DHHPDO';
fDHHPDO(i)=fDHHPDO(i)-1; fHO2(i)=fHO2(i)+1; fHOCH2CHO(i)=fHOCH2CHO(i)+1; fACETOL(i)=fACETOL(i)+1; 


%%THHPO2
i=i+1;
Rnames{i} = 'THHPO2 = C5H10O7 + HO2'; %NEED TO ADD SPECIES
k(:,i) = 0; %ESTIMATE!!! Isomerization of RO2
Gstr{i,1} = 'THHPO2';
fTHHPO2(i)=fTHHPO2(i)-1; fC5H10O7(i)=fC5H10O7(i)+1; fHO2(i) = fHO2(i)+1;

i=i+1;
Rnames{i} = 'THHPO2 + NO = THHPO + NO2';
k(:,i) = KRO2NO.*0.892;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'NO'; 
fTHHPO2(i)=fTHHPO2(i)-1; fNO(i)=fNO(i)-1; fTHHPO(i)=fTHHPO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'THHPO2 + NO = THHPNO3';
k(:,i) = KRO2NO.*0.108;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'NO'; 
fTHHPO2(i)=fTHHPO2(i)-1; fNO(i)=fNO(i)-1; fTHHPNO3(i)=fTHHPNO3(i)+1; 

i=i+1;
Rnames{i} = 'THHPO2 + NO3 = THHPO + NO2';
k(:,i) = KRO2NO3.*0.25;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'NO3'; 
fTHHPO2(i)=fTHHPO2(i)-1; fNO3(i)=fNO3(i)-1; fTHHPO(i)=fTHHPO(i)+1; fNO2(i)=fNO2(i)+1; 

i=i+1;
Rnames{i} = 'THHPO2 + HO2 = THDHP';
k(:,i) = KRO2HO2;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'HO2'; 
fTHHPO2(i)=fTHHPO2(i)-1; fHO2(i)=fHO2(i)-1; fTHDHP(i)=fTHDHP(i)+1; 

i=i+1;
Rnames{i} = 'THHPO2 =  THHPO';
k(:,i) = 2.40e-12.*0.8;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'RO2';
fTHHPO2(i)=fTHHPO2(i)-1; fTHHPO(i)=fTHHPO(i)+1; 

i=i+1; 
Rnames{i} = 'THHPO2 + RO2 = C5H10O6';%Add another species??
k(:,i) = 2.40e-12.*0.1;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'RO2';
fTHHPO2(i)=fTHHPO2(i)-1; fC5H10O6(i)=fC5H10O6(i)+1; 

i=i+1;
Rnames{i} = 'THHPO2 + RO2 = TETROLHP'; %C5H12O6! %NEED to ADD SPECIES & RXNs
k(:,i) = 2.40e-12.*0.1;
Gstr{i,1} = 'THHPO2'; Gstr{i,2} = 'RO2';
fTHHPO2(i)=fTHHPO2(i)-1; fTETROLHP(i)=fTETROLHP(i)+1; 

%%THHPO
i=i+1;
Rnames{i} = 'THHPO = C5H10O6 + HO2'; %NEED TO ADD SPECIES & RXNs
k(:,i) = KDEC.*0.1;
Gstr{i,1} = 'THHPO'; 
fTHHPO(i)=fTHHPO(i)-1; fC5H10O6(i)=fC5H10O6(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'THHPO = MVKOHAOH + HCHO + OH';
k(:,i) = KDEC.*0.1;
Gstr{i,1} = 'THHPO';
fTHHPO(i)=fTHHPO(i)-1; fMVKOHAOH(i)=fMVKOHAOH(i)+1; fHCHO(i) = fHCHO(i) + 1; fOH(i)=fOH(i)+1; 
i=i+1;

Rnames{i} = 'THHPO = HO12CO3C4 + HCHO + OH';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHPO'; 
fTHHPO(i)=fTHHPO(i)-1; fHO12CO3C4(i)=fHO12CO3C4(i)+1; fHCHO(i) = fHCHO(i)+1; fOH(i)=fOH(i)+1; 


%%DHDHP + OH
i=i+1;
Rnames{i} = 'DHDHP + OH = C58OOH + OH'; %THIS IS SIMPLIFIED...NEEDS SOME MORE DETAILED CONSIDERATION
k(:,i) = 5e-11.*0.64; %0; %1e-11.*0.64;
Gstr{i,1} = 'DHDHP'; Gstr{i,2} = 'OH'; 
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)-1; fC58OOH(i)=fC58OOH(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + OH = DHHPBO2';
k(:,i) = 5e-11.*0.33.*0.5; %0 %1e-11.*0.64;
Gstr{i,1} = 'DHDHP'; Gstr{i,2} = 'OH'; 
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)-1; fDHHPBO2(i)=fDHHPBO2(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + OH = DHHPDO2';
k(:,i) = 5e-11.*0.33.*0.25; %0; %1e-11.*0.64;
Gstr{i,1} = 'DHDHP'; Gstr{i,2} = 'OH'; 
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)-1; fDHHPDO2(i)=fDHHPDO2(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + OH = DHHPAO2';
k(:,i) = 5e-11.*0.33.*0.125; %0; %1e-11.*0.64;
Gstr{i,1} = 'DHDHP'; Gstr{i,2} = 'OH'; 
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)-1; fDHHPAO2(i)=fDHHPAO2(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + OH = DHHPCO2';
k(:,i) = 5e-11.*0.33.*0.125; %0; %1e-11.*0.64;
Gstr{i,1} = 'DHDHP'; Gstr{i,2} = 'OH'; 
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)-1; fDHHPCO2(i)=fDHHPCO2(i)+1;

%%THDHP + OH
i=i+1;
Rnames{i} = 'THDHP + OH = C5H10O7 + HO2';
k(:,i) = 0;%5e-11.*5/9 ;
Gstr{i,1} = 'THDHP'; Gstr{i,2} = 'OH'; 
fTHDHP(i)=fTHDHP(i)-1; fOH(i)=fOH(i)-1; fC5H10O7(i)=fC5H10O7(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'THDHP + OH = C5H10O7 + OH';
k(:,i) = 0;%5e-11.*2/9 ;
Gstr{i,1} = 'THDHP'; Gstr{i,2} = 'OH'; 
fTHDHP(i)=fTHDHP(i)-1; fOH(i)=fOH(i)-0; fC5H10O7(i)=fC5H10O7(i)+1;

i=i+1;
Rnames{i} = 'THDHP + OH = THHPO2';
k(:,i) = 0;%5e-11.*2/9 ;
Gstr{i,1} = 'THDHP'; Gstr{i,2} = 'OH'; 
fTHDHP(i)=fTHDHP(i)-1; fOH(i)=fOH(i)-1; fTHHPO2(i)=fTHHPO2(i)+1;

%%DHDHP + hv
i=i+1;
Rnames{i} = 'DHDHP + hv = DHHPBO + OH';
k(:,i) = J41.*0.5;
Gstr{i,1} = 'DHDHP';
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)+1; fDHHPBO(i)=fDHHPBO(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + hv = DHHPDO + OH';
k(:,i) = J41.*0.25;
Gstr{i,1} = 'DHDHP';
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)+1; fDHHPDO(i)=fDHHPDO(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + hv = DHHPAO + OH';
k(:,i) = J41.*0.125;
Gstr{i,1} = 'DHDHP';
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)+1; fDHHPAO(i)=fDHHPAO(i)+1;

i=i+1;
Rnames{i} = 'DHDHP + hv = DHHPCO + OH';
k(:,i) = J41.*0.125;
Gstr{i,1} = 'DHDHP';
fDHDHP(i)=fDHDHP(i)-1; fOH(i)=fOH(i)+1; fDHHPCO(i)=fDHHPCO(i)+1;

%%THHP + OH
i=i+1;
Rnames{i} = 'THHP + OH = C57OOH + HO2'; %THIS IS SIMPLIFIED...NEEDS SOME MORE DETAILED CONSIDERATION
k(:,i) = 5e-11.*0.55;
Gstr{i,1} = 'THHP'; Gstr{i,2} = 'OH'; 
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)-1; fC57OOH(i)=fC57OOH(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'THHP + OH = C58OOH + HO2'; %THIS IS SIMPLIFIED...NEEDS SOME MORE DETAILED CONSIDERATION
k(:,i) = 5e-11.*0.2.*(2/3) ;
Gstr{i,1} = 'THHP'; Gstr{i,2} = 'OH'; 
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)-1; fC58OOH(i)=fC58OOH(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'THHP + OH = C57OH + OH'; %THIS IS SIMPLIFIED...NEEDS SOME MORE DETAILED CONSIDERATION
k(:,i) = 5e-11.*0.2.*(1/3);
Gstr{i,1} = 'THHP'; Gstr{i,2} = 'OH'; 
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)-1; fC58OOH(i)=fC58OOH(i)+1; fOH(i)=fOH(i)+1;

i=i+1;
Rnames{i} = 'THHP + OH = THHPO2';
k(:,i) = 5e-11.*0.25;
Gstr{i,1} = 'THHP'; Gstr{i,2} = 'OH'; 
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)-1; fTHHPO2(i)=fTHHPO2(i)+1;


%%THHP + hv
i=i+1;
Rnames{i} = 'THHP + hv = THBC5O + OH'; 
k(:,i) = J41.*0.5;
Gstr{i,1} = 'THHP';
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)+1; fTHBC5O(i)=fTHBC5O(i)+1; 

i=i+1;
Rnames{i} = 'THHP + hv = THACDC5O + OH'; 
k(:,i) = J41.*0.5;
Gstr{i,1} = 'THHP';
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)+1; fTHACDC5O(i)=fTHACDC5O(i)+1; 

i=i+1;
Rnames{i} = 'THBC5O = C57OH + HO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THBC5O';
fTHBC5O(i)=fTHBC5O(i)-1; fC57OH(i)=fC57OH(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'THBC5O = HO12CO3C4 + HCHO + HO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THBC5O';
fTHBC5O(i)=fTHBC5O(i)-1; fHCHO(i)=fHCHO(i)+1; fHO12CO3C4(i)=fHO12CO3C4(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'THBC5O = ACETOL + HOCH2CHO + HO2';
k(:,i) = KDEC.*0.5;
Gstr{i,1} = 'THBC5O';
fTHBC5O(i)=fTHBC5O(i)-1; fHO2(i)=fHO2(i)+1; fHOCH2CHO(i)=fHOCH2CHO(i)+1; fACETOL(i)=fACETOL(i)+1; 

i=i+1;
Rnames{i} = 'THACDC5O = MACROH + HCHO + HO2';
k(:,i) = KDEC;
Gstr{i,1} = 'THACDC5O';
fTHACDC5O(i)=fTHACDC5O(i)-1; fHCHO(i)=fHCHO(i)+1; fMACROH(i)=fMACROH(i)+1; fHO2(i)=fHO2(i)+1; 

%%THDHP + hv
i=i+1;
Rnames{i} = 'THDHP + hv = THHPO + OH'; 
k(:,i) = J41.*0.5;
Gstr{i,1} = 'THHP';
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)+1; fTHBC5O(i)=fTHBC5O(i)+1; 

i=i+1;
Rnames{i} = 'THDHP + hv = THHPBO + OH'; 
k(:,i) = J41.*0.5;
Gstr{i,1} = 'THHP';
fTHHP(i)=fTHHP(i)-1; fOH(i)=fOH(i)+1; fTHHPBO(i)=fTHHPBO(i)+1; 

%%THHPBO

i=i+1;
Rnames{i} = 'THHPBO = MVKOHAOH + HCHO + OH';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHPBO';
fTHHPBO(i)=fTHHPBO(i)-1; fMVKOHAOH(i)=fMVKOHAOH(i)+1; fHCHO(i) = fHCHO(i) + 1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'THHPBO = HOCH2CHO + HYPERACETOL + HO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHPBO'; 
fTHHPBO(i)=fTHHPBO(i)-1; fHOCH2CHO(i)=fHOCH2CHO(i)+1; fHYPERACETOL(i)=fHYPERACETOL(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'THHPBO = C5H10O6 + HO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHPBO'; 
fTHHPBO(i)=fTHHPBO(i)-1; fC5H10O6(i)=fC5H10O6(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'THHPBO = HMVKBOOH + HCHO + HO2';
k(:,i) = KDEC.*0.25;
Gstr{i,1} = 'THHPBO'; 
fTHHPBO(i)=fTHHPBO(i)-1; fHMVKBOOH(i)=fHMVKBOOH(i)+1; fHCHO(i) = fHCHO(i)+1; fHO2(i)=fHO2(i)+1;

%%HYPERACETOL
i=i+1;
Rnames{i} = 'HYPERACETOL + hv = 2HCHO + HO2 + OH'; 
k(:,i) = J41.*0.5;
Gstr{i,1} = 'HYPERACETOL';
fHYPERACETOL(i)=fHYPERACETOL(i)-1; fOH(i)=fOH(i)+1; fHCHO(i)=fHCHO(i)+2; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'HYPERACETOL + hv = HOCH2COCHO + HO2 + OH'; 
k(:,i) = J41.*0.5;
Gstr{i,1} = 'HYPERACETOL';
fHYPERACETOL(i)=fHYPERACETOL(i)-1; fHOCH2COCHO(i)=fHOCH2COCHO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'HYPERACETOL + OH = HOCH2COCHO + HO2 '; 
k(:,i) = 5e-11.*0.5;
Gstr{i,1} = 'HYPERACETOL';Gstr{i,1} = 'OH';
fHYPERACETOL(i)=fHYPERACETOL(i)-1; fOH(i)=fOH(i)-1; fHOCH2COCHO(i)=fHOCH2COCHO(i)+1; fHO2(i)=fHO2(i)+1;

i=i+1;
Rnames{i} = 'HYPERACETOL + OH = ALCOCH2OOH + OH '; 
k(:,i) = 5e-11.*0.5;
Gstr{i,1} = 'HYPERACETOL';Gstr{i,1} = 'OH';
fHYPERACETOL(i)=fHYPERACETOL(i)-1; fOH(i)=fOH(i)-0; fHOCH2COCHO(i)=fHOCH2COCHO(i)+1; fHO2(i)=fHO2(i)+1; 


%% DHHEPOX
i=i+1;
Rnames{i} = 'DHHEPOX + OH = C5H8O4epox + OH '; %di-hydroxy di-epoxide 
k(:,i) = 5e-11.*0.1;
Gstr{i,1} = 'DHHEPOX';Gstr{i,1} = 'OH';
fDHHEPOX(i)=fDHHEPOX(i)-1; fOH(i)=fOH(i)-0; fC5H8O4epox(i)=fC5H8O4epox(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHHEPOX + OH = C5H8O5'; %hydroxy hydroperoxy epoxy aldehyde
k(:,i) = 5e-11.*0.1;
Gstr{i,1} = 'DHHEPOX';Gstr{i,1} = 'OH';
fDHHEPOX(i)=fDHHEPOX(i)-1; fOH(i)=fOH(i)-0; fC5H8O5(i)=fC5H8O5(i)+1; 

i=i+1;
Rnames{i} = 'DHHEPOX + OH = C5H8O4ald + OH '; %di-hydroxy epoxy ketone 
k(:,i) = 5e-11.*0.8;
Gstr{i,1} = 'DHHEPOX';Gstr{i,1} = 'OH';
fDHHEPOX(i)=fDHHEPOX(i)-1; fOH(i)=fOH(i)-0; fC5H8O4ald(i)=fC5H8O4ald(i)+1; fOH(i)=fOH(i)+1;

%% HDHPald
i=i+1;
Rnames{i} = 'HDHPald + OH = DHPDA + HO2 '; %di-hydroperoxy di-aldehyde 
k(:,i) = 5e-11.*0.25;
Gstr{i,1} = 'HDHPald';Gstr{i,1} = 'OH';
fHDHPald(i)=fHDHPald(i)-1; fOH(i)=fOH(i)-0; fDHPDA(i)=fDHPDA(i)+1; fHO2(i)=fHO2(i)+1; 

i=i+1;
Rnames{i} = 'HDHPald + OH = HHPDc'; %hydroxy hydroperoxide di-carbonyl (ketone + aldehyde)
k(:,i) = 5e-11.*0.25;
Gstr{i,1} = 'HDHPald';Gstr{i,1} = 'OH';
fHDHPald(i)=fHDHPald(i)-1; fOH(i)=fOH(i)-0; fHHPDc(i)=fHHPDc(i)+1; 

i=i+1;
Rnames{i} = 'HDHPald + OH = CO + OH + HMVKBOOH'; %decomposes
k(:,i) = 5e-11.*0.5;
Gstr{i,1} = 'HDHPald';Gstr{i,1} = 'OH';
fHDHPald(i)=fHDHPald(i)-1; fOH(i)=fOH(i)-0; fHMVKBOOH(i)=fHMVKBOOH(i)+1; fOH(i)=fOH(i)+1; fCO(i)=fCO(i)+1; 

%% DHDHPket
i=i+1;
Rnames{i} = 'DHDHPket + OH = HHPcarb + OH '; %hydroxy hydroperoxy ketone carboxylic acid
k(:,i) = 5e-11.*0.5;
Gstr{i,1} = 'DHDHPket';Gstr{i,1} = 'OH';
fDHDHPket(i)=fDHDHPket(i)-1; fOH(i)=fOH(i)-0; fHHPcarb(i)=fHHPcarb(i)+1; fOH(i)=fOH(i)+1; 

i=i+1;
Rnames{i} = 'DHDHPket + OH = HDHPDc + HO2'; %hydroxy di-hydroperoxy di-carbonyl (ketone + aldehyde)
k(:,i) = 5e-11.*0.5;
Gstr{i,1} = 'DHDHPket';Gstr{i,1} = 'OH';
fDHDHPket(i)=fDHDHPket(i)-1; fOH(i)=fOH(i)-0; fHDHPDc(i)=fHDHPDc(i)+1; fHO2(i)=fHO2(i)+1;
