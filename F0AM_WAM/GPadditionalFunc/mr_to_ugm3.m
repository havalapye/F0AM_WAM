function ugm3 = mr_to_ugm3(mr,mw,ptot,T)
%mr is mixing ratio in mol/mol units,e.g. 1 pptv = 1e-12 mol/mol
%mw is molecular weight in g/mol
%ptot is total pressure in atm
%T is temperature in K
%ptot and T are option inputs, default assumes 1 atm and 288 K.

if length(mr)>length(mw);
    mw = repmat(mw,1,length(mr));
    if size(mr,1)==size(mw,2)
        mr = mr';
    end
end

if nargin==2
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

totmol_m3 = 1e6.*M_calc(ptot*760,T)./6.023e23;
mc = NaN(size(mr));
for i=1:length(MW)
    
mc(:,i) = 1e6.*(mr(:,i).*totmol_m3).*MW(i);
end
ugm3 = mc;