% PNNL_chamber_emissions.m
% To add emission term for continuous flow chamber experiments May 2014
%
% 20140530 JAT


%new chemistry
i=i+1;
Rnames{i} = 'Emis C5H8';
k(:,i) =  1.4259e6.*EF_C5H8; %makes 1 ppb * EF in chamber w/no chemistry
Gstr{i,1} = ''; Gstr{i,2} = ''; 
fC5H8(i)=fC5H8(i)+1;

i=i+1;
Rnames{i} = 'Emis H2O2';
k(:,i) = 1.4259e6.*EF_H2O2;  %makes 1 ppb * EF in chamber w/no chemistry
Gstr{i,1} = ''; Gstr{i,2} = ''; 
fH2O2(i)=fH2O2(i)+1;

i=i+1;
Rnames{i} = 'Emis NO';
k(:,i) = 1.4259e6.*EF_NO;  %makes 1 ppb * EF in chamber w/no chemistry
Gstr{i,1} = ''; Gstr{i,2} = ''; 
fNO(i)=fNO(i)+1;

