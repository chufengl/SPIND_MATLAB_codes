%"Q_gen.m" generates rotaion matrix for given rotation angles [phi, theta, alpha]

function [Q]=Q_gen(Ori_v)

% quarternion----------------------------------
Qua=zeros(1,4);
Qua(1)=cos(Ori_v(3)/180*pi/2);
Qua(2)=sin(Ori_v(2)/180*pi)*cos(Ori_v(1)/180*pi)*sin(Ori_v(3)/180*pi/2);
Qua(3)=sin(Ori_v(2)/180*pi)*sin(Ori_v(1)/180*pi)*sin(Ori_v(3)/180*pi/2);
Qua(4)=cos(Ori_v(2)/180*pi)*sin(Ori_v(3)/180*pi/2);

% rotation matrix------------------------------
Q=zeros(3,3);
Q(1,1)=1-2*Qua(3)^2-2*Qua(4)^2;
Q(1,2)=2*Qua(2)*Qua(3)+2*Qua(1)*Qua(4);
Q(1,3)=2*Qua(2)*Qua(4)-2*Qua(1)*Qua(3);
Q(2,1)=2*Qua(2)*Qua(3)-2*Qua(1)*Qua(4);
Q(2,2)=1-2*Qua(2)^2-2*Qua(4)^2;
Q(2,3)=2*Qua(3)*Qua(4)+2*Qua(1)*Qua(2);
Q(3,1)=2*Qua(2)*Qua(4)+2*Qua(1)*Qua(3);
Q(3,2)=2*Qua(3)*Qua(4)-2*Qua(1)*Qua(2);
Q(3,3)=1-2*Qua(2)^2-2*Qua(3)^2;



end