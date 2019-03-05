%"qua2rotmat.m" converts quaternions to rotation matrices.

function [Q,R] = qua2rotmat(qua)

Q=zeros(3);
R=zeros(3);
%calculate the cross terms of quaternions.
%-----------------------------------------
t01=qua(1)*qua(2);
t02=qua(1)*qua(3);
t03=qua(1)*qua(4);
t11=qua(2)*qua(2);
t12=qua(2)*qua(3);
t13=qua(2)*qua(4);
t22=qua(3)*qua(3);
t23=qua(3)*qua(4);
t33=qua(4)*qua(4);
%-----------------------------------------
%Calculate the rotation matrices Q and R based on Chufeng Li's convention.
%-----------------------------------------
Q(1,:)=[1-2*(t22+t33),2*(t12+t03),2*(t13-t02)];
Q(2,:)=[2*(t12-t03),1-2*(t11+t33),2*(t23+t01)];
Q(3,:)=[2*(t13+t02),2*(t23-t01),1-2*(t11+t22)];

R(1,:)=[1-2*(t22+t33),2*(t12-t03),2*(t13+t02)];
R(2,:)=[2*(t12+t03),1-2*(t11+t33),2*(t23-t01)];
R(3,:)=[2*(t13-t02),2*(t23+t01),1-2*(t11+t22)];

disp(['Based on Li''s convention, Q rotates from final to initial;'...
    ' R rotates from initial to final.'])


%-----------------------------------------
end