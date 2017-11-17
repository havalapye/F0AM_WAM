function mixratio = ugm3_to_mr(ugm3,mw,ptot,T)
% mixratio in mol/mol units
% mx = molecular weight
% ugm3 = microgram per cubic meter
% ptot = total pressure in atm
% T = ambient temperature in K

if nargin ==2
   ptot = 1;
   T = 298;
end

if iscell(mw)
    MW =[];
    for i=1:length(mw)
        MW(i) = tof_exact_mass(mw{i});
    end
elseif isnumeric(mw)
    MW = mw;
elseif ischar(mw)
    MW = tof_exact_mass(mw);
else
    display('molecular weight must be a number or a cell array containing elemental formula')
end

% if length(ugm3)>length(mw); 
%     MW = repmat(mw,1,length(ugm3));
% end

if size(ugm3,2)>size(ugm3,1)
    ugm3 = ugm3';
end

totmol_m3 = 1e6.*M_calc(ptot*760,T)./6.023e23;
mc = NaN(size(ugm3));

for i=1:length(MW) 
    mc(:,i) = ugm3(:,i)./(1e6.*totmol_m3.*MW(i));
end
mixratio = mc;