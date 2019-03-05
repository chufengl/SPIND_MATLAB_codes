%"star_Ori.m" calculates the orientation of xtal from the a_star, b_star,
%and c_star vectors given by mosflm.

function [Ori_X_star] = star_Ori(lp,a_star0,b_star0,a_star,b_star)

A=zeros(3);
A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
A(2,2)=1/lp(2)*sind(lp(6));
A(3,3)=1/lp(3);
% a_star0=A(:,1);
% b_star0=A(:,2);
% c_star0=A(:,3);

Normal0=cross(a_star0,b_star0);
Normal=cross(a_star,b_star);

rot_axis_v=cross(Normal0,Normal);
if dot(rot_axis_v,rot_axis_v)==0
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
    
    alpha=acosd(dot(Normal,Normal0)/sqrt(Normal.'*Normal)/sqrt(Normal0.'*Normal0));
    
    Ori=[phi,theta,alpha];
end

if dot(cross(Q_gen(Ori)\a_star0,a_star),Normal)>=0
    adj_angle=acosd(a_star.'*(Q_gen(Ori)\a_star0)/sqrt(a_star.'*a_star)/(sqrt(dot(Q_gen(Ori)\a_star0,Q_gen(Ori)\a_star0))));
else
    adj_angle=-acosd(a_star.'*(Q_gen(Ori)\a_star0)/sqrt(a_star.'*a_star)/(sqrt(dot(Q_gen(Ori)\a_star0,Q_gen(Ori)\a_star0))));
end

if Normal==[0;0;0]
    Ori_adj=[0,0,0];
else
    theta=acosd(Normal(3)/sqrt(Normal.'*Normal));
    
    if (Normal(1)>=0)&&(Normal(2)>=0)
        phi=atand(Normal(2)/Normal(1));
    elseif (Normal(1)>=0)&&(Normal(2)<0)
        phi=atand(Normal(2)/Normal(1));
    elseif (Normal(1)<0)&&(Normal(2)>=0)
        phi=atand(Normal(2)/Normal(1))+180;
    else
        phi=atand(Normal(2)/Normal(1))-180;
    end
    
    alpha=adj_angle;
    
    Ori_adj=[phi,theta,alpha];
end

Q=Q_gen(Ori)*Q_gen(Ori_adj);
[v,d]=eig(Q);
        [row,col]=find(d>=1-100*eps);
        theta=acosd(v(3,col));
        if theta==0
            phi=0;
        else
            if (v(1,col)>=0)&(v(2,col)>=0)
                phi=atand(v(2,col)/v(1,col));
            elseif (v(1,col)>=0)&(v(2,col)<0)
                phi=atand(v(2,col)/v(1,col));
            elseif (v(1,col)<0)&(v(2,col)>=0)
                phi=atand(v(2,col)/v(1,col))+180;
            else
                phi=atand(v(2,col)/v(1,col))-180;
            end
            
        end
        
        
        
        
        alpha_v=-180:0.1:180;
        for m=1:3601
            alpha=alpha_v(m);
            Q1=Q_gen([phi,theta,alpha]);
            NOR(m)=norm(Q1-Q);
        end
        %         figure;plot(alpha_v,NOR)
        ind_N=find(NOR==min(NOR));
        alpha=alpha_v(ind_N);
        if alpha<0
            if phi>=0
                phi=phi-180;
            else
                phi=phi+180;
            end
            
                theta=180-theta;
            alpha=-alpha;
        else
        end
        Ori_X_star=[phi,theta,alpha];






end