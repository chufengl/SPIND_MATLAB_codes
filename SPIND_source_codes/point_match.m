%"point_match.m" gives a matching score to each orientation solution using
%shoterned computation time by taking advantage of known spot positions.

function [pm_list,match_score]=point_match(A,peak_c_list,Ori_X,d_thld)

pm_list=zeros(size(peak_c_list,1),16);%point_match list
pm_list(:,1:3)=peak_c_list(:,6:8);

for l=1:size(pm_list,1)
    XYZ=pm_list(l,1:3).';
    HKL=A\(Q_gen(Ori_X)*XYZ);
    H_up=ceil(HKL(1));
    K_up=ceil(HKL(2));
    L_up=ceil(HKL(3));
    H_down=floor(HKL(1));
    K_down=floor(HKL(2));
    L_down=floor(HKL(3));
    HKL1=[H_up;K_up;L_up];
    HKL2=[H_up;K_up;L_down];
    HKL3=[H_up;K_down;L_up];
    HKL4=[H_down;K_up;L_up];
    HKL5=[H_up;K_down;L_down];
    HKL6=[H_down;K_up;L_down];
    HKL7=[H_down;K_down;L_up];
    HKL8=[H_down;K_down;L_down];
    XYZ1=Q_gen(Ori_X)\(A*HKL1);
    XYZ2=Q_gen(Ori_X)\(A*HKL2);
    XYZ3=Q_gen(Ori_X)\(A*HKL3);
    XYZ4=Q_gen(Ori_X)\(A*HKL4);
    XYZ5=Q_gen(Ori_X)\(A*HKL5);
    XYZ6=Q_gen(Ori_X)\(A*HKL6);
    XYZ7=Q_gen(Ori_X)\(A*HKL7);
    XYZ8=Q_gen(Ori_X)\(A*HKL8);
    d1=sqrt(dot(XYZ-XYZ1,XYZ-XYZ1));
    d2=sqrt(dot(XYZ-XYZ2,XYZ-XYZ2));
    d3=sqrt(dot(XYZ-XYZ3,XYZ-XYZ3));
    d4=sqrt(dot(XYZ-XYZ4,XYZ-XYZ4));
    d5=sqrt(dot(XYZ-XYZ5,XYZ-XYZ5));
    d6=sqrt(dot(XYZ-XYZ6,XYZ-XYZ6));
    d7=sqrt(dot(XYZ-XYZ7,XYZ-XYZ7));
    d8=sqrt(dot(XYZ-XYZ8,XYZ-XYZ8));
    
    
    pm_list(l,4:6)=HKL.';
    pm_list(l,7:14)=[d1,d2,d3,d4,d5,d6,d7,d8];
    pm_list(l,15)=min([d1,d2,d3,d4,d5,d6,d7,d8]);
    if pm_list(l,15)<=d_thld
        pm_list(l,16)=1;
    else
    end
    
    
end
match_score=sum(pm_list(:,16))/size(pm_list,1);






end