%"ZAP_get.m" calculates the zone axis from two reciprocal vectors.

function [HKL_ZAP] = ZAP_get(A,HKL1,HKL2)

XYZ1=A*HKL1;
XYZ2=A*HKL2;
XYZ_ZAP=cross(XYZ1,XYZ2);
HKL_ZAP=A\XYZ_ZAP;

end