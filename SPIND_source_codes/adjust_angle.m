%?adjust_angle.m?

function [Ori_X] = adjust_angle(A,HKL_ZAP,HKL1,XYZ1,XYZ2,Ori)


l1=sqrt(XYZ1.'*XYZ1);

XYZ_ZAP=A*HKL_ZAP;
Normal12_v=cross(XYZ1,XYZ2);

if dot(cross(Q_gen(Ori)\(A*HKL1),XYZ1),Normal12_v)>=0
    adj_angle=acosd(XYZ1.'*(Q_gen(Ori)\(A*HKL1))/(l1)/(sqrt(dot(Q_gen(Ori)\(A*HKL1),Q_gen(Ori)\(A*HKL1)))));
else
    adj_angle=-acosd(XYZ1.'*(Q_gen(Ori)\(A*HKL1))/(l1)/(sqrt(dot(Q_gen(Ori)\(A*HKL1),Q_gen(Ori)\(A*HKL1)))));
end


if Normal12_v==[0;0;0]
    Ori_adj=[0,0,0];
else
    theta=acosd(Normal12_v(3)/sqrt(Normal12_v.'*Normal12_v));
    
    if (Normal12_v(1)>=0)&&(Normal12_v(2)>=0)
        phi=atand(Normal12_v(2)/Normal12_v(1));
    elseif (Normal12_v(1)>=0)&&(Normal12_v(2)<0)
        phi=atand(Normal12_v(2)/Normal12_v(1));
    elseif (Normal12_v(1)<0)&&(Normal12_v(2)>=0)
        phi=atand(Normal12_v(2)/Normal12_v(1))+180;
    else
        phi=atand(Normal12_v(2)/Normal12_v(1))-180;
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
        Ori_X=[phi,theta,alpha];

end