function dydt = dydt_eval_GP(t,conc,param)
% function dydt = dydt_eval(t,conc,param)
% Evaluates chemical rates.
% Note that, below, nSp = # of species, nRx = # of reactions, nZ = # of boxes.
%
% INPUTS:
% t: current integration time
% conc: matrix of species concentrations in molec/cm3, dim = nZ x nSp
% param: a cell array containing the following parameters:
%   k: matrix of rate constants for reaction/photolysis/deposition/emission, dim = nZ x nRx
%   f: SPARSE matrix of species coefficients for each reaction, dim = nRx x nSp
%   iG: index for species to be multiple for each reaction. dim = nRx x 2.
%   iRO2: index to identify RO2 species
%   kdil: dilution rate constant (/s). If this is 0, dilution is ignored.
%   conc_bkgd: background concentrations, used for dilution
%   iHold: index for species to hold constant.
%   IntTime: total integration time, used to calculate % complete.
%   Verbose: set to 1 to include "% complete" display.
%
% OUTPUTS:
% dydt: matrix of rate of change of species, dim = nZ x nSp
%
% 20080918 GMW
% 20120212 GMW Modified for use with UWCM_v2. See ChangeLog for details.

%%%%%BREAKOUT PARAMETERS%%%%%
k = param{1};
f = param{2};
iG = param{3};
iRO2 = param{4};
iHold = param{5};
kdil = param{6};
conc_bkgd = param{7};
IntTime = param{8};
Verbose = param{9};
NOxinfo = param{10};
iOA = param{11};
kwall_loss = param{12};
iVapor = param{13};
kwall_lossV = param{14};

conc = conc'; %ODE solver feeds this in as 1 row for each species

%calculations for vectorization of dydt
s = size(conc,1);
if s > 1
    o = ones(s,1);
    conc_bkgd = o*conc_bkgd;
    k = o*k;
end

%%%%%CALCULATE RATES%%%%%
conc(:,2) = sum(conc(:,iRO2),2); %calculate sum of RO2 species
if isempty(iOA)==0 && sum(conc(:,iOA),2)==0  && conc(:,3)==0
   conc(:,3) = 1./2e-8; %if OA species are indexed but there isn't any and there isn't any initial OA, put in a small amount 
end
conc(:,4) = 1./conc(:,3); %calculate the inverse of OA conc. which you need for dydt calculations
G = conc(:,iG(:,1)).*conc(:,iG(:,2)); %1 column for each reaction
rates = k.*G; %chemical rates
dydt = rates*f; %multiply rates for each reactant by coefficients and sum up

%dilution
dilrate = -kdil.*(conc - conc_bkgd); %dilution rate
wallLossRateP = -kwall_loss.*(conc(:,iOA)-conc_bkgd(:,iOA)); %particles
wallLossRateV = -kwall_lossV.*(conc(:,iVapor)-conc_bkgd(:,iVapor)); %vapor
dydt = dydt + dilrate;
dydt(:,iOA) = dydt(:,iOA)+wallLossRateP;
dydt(:,iVapor) = dydt(:,iVapor)+wallLossRateV;

% experimental code to fix total NOx
if ~isempty(NOxinfo)
    persistent tlast
    if isempty(tlast) || t==tlast
        tlast = t;
    else
        dt = t - tlast;
        tlast = t;
        
        iNOx     = NOxinfo(1,:); %index
        cNOx     = NOxinfo(2,:); %constraint concentration
        mNOx     = conc(:,iNOx); %model concentration
        nNOx     = sum(cNOx)./sum(mNOx,2)*mNOx; %new NOx concentrations
        dydt(:,iNOx) = (nNOx - mNOx)./dt + dydt(:,iNOx);
    end
    
    if t==IntTime, clear tlast; end %ready for next step
end

dydt(:,iHold) = 0; %no change for held species
% integrate particles
if ~isempty(iOA)
	dydt(:,3) = -(kdil+kwall_loss).*(conc(:,3)-sum(conc(:,iOA)))+sum(dydt(:,iOA)); %updated by HOT Pye, 9/11/2017
	%dydt(:,3) = sum(dydt(:,iOA)); %sum up OA species
end

dydt = dydt';

if Verbose>=3, meter(IntTime,t,10); end



