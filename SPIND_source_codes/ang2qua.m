% "ang2qua.m" converts rotation angles [phi,theta,alpha] to quaternions.

function [qua] = ang2qua(r_ang)

qua=zeros(1,4);

phi=r_ang(1);
theta=r_ang(2);
alpha=r_ang(3);

%calculate the components of rotation axis.
%-------------------------
ax=cosd(phi)*sind(theta);
ay=sind(phi)*sind(theta);
az=cosd(theta);
%-------------------------

qua(1)=cosd(alpha/2);
qua(2)=ax*sind(alpha/2);
qua(3)=ay*sind(alpha/2);
qua(4)=az*sind(alpha/2);


%calculate the cross terms of quaternions.
%-------------




%-------------


end