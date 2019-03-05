%"Ori_get.m" calculates the orientation angles [phi,theta,alpha] from
%XYZ_ZAP.

function [Ori] = Ori_get(A,HKL_ZAP,XYZ1,XYZ2)

XYZ_ZAP=A*HKL_ZAP;
Normal12_v=cross(XYZ1,XYZ2);
rot_axis_v=-cross(Normal12_v,XYZ_ZAP);


if rot_axis_v==[0;0;0]
    Ori=[0,0,0];
else
    theta=acosd(rot_axis_v(3)/sqrt(rot_axis_v.'*rot_axis_v));
    
    if (rot_axis_v(1)>=0)&&(rot_axis_v(2)>=0)
        phi=atand(rot_axis_v(2)/rot_axis_v(1));
    elseif (rot_axis_v(1)>=0)&&(rot_axis_v(2)<0)
        phi=atand(rot_axis_v(2)/rot_axis_v(1));
    elseif (rot_axis_v(1)<0)&&(rot_axis_v(2)>=0)
        phi=atand(rot_axis_v(2)/rot_axis_v(1))+180;
    else
        phi=atand(rot_axis_v(2)/rot_axis_v(1))-180;
    end
    
    alpha=acosd(dot(Normal12_v,XYZ_ZAP)/sqrt((Normal12_v).'*(Normal12_v))/sqrt(XYZ_ZAP.'*XYZ_ZAP));
    
    Ori=[phi,theta,alpha];
end


end