%%"LRA.m"(length ratio and angle) gives the length ratio and angle between
%%two designated reciprocal lattice vectors.

function [L1,L2,LR,Ang] = LRA(A,HKL1,HKL2)
%---------------------------
%calculate parameters
% lamda=12.4/E_ph;



%---------------------------
%calculate the reciprocal lattice vector from Miller indices
XYZ1=A*HKL1;
XYZ2=A*HKL2;

%---------------------------
%calculate the length(in um) and length ratio
L1=sqrt(XYZ1.'*XYZ1);
L2=sqrt(XYZ2.'*XYZ2);
LR=L1/L2;

%---------------------------
%calculate the angle between the two vectors based on inner product.
Ang=(XYZ1.'*XYZ2)/(L1*L2);
% Ang=acosd((XYZ1.'*XYZ2)/(L1*L2));

end