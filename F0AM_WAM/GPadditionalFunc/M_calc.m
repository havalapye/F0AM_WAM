%M_calc calculates the total number density in molec/cm3 with
%the inputs, T (K) and P (torr).
function k=M_calc(Press,temp)
k=2.46e19.*(Press./760).*(298./temp);