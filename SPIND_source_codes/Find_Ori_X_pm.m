%"Find_Ori_X_pm.m" finds the orientation of the Xtal following
%"detc2ES_mapping.m".

%no pattern prediction and spot matching included to shorten the
%computation time.
 
function [MATCH,Ori_matrix] = Find_Ori_X_pm(peak_c_list,TAB,row1,row2,lra_error,lp,d_thld)


A=zeros(3);

%for orthorhombic lattice
%-------------------------------------------
%A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
%A(2,2)=1/lp(2)*sind(lp(6));
%A(3,3)=1/lp(3);
%-------------------------------------------
%for monoclinic lattice
%-------------------------------------------

aa=[lp(1);0;0];
bb=[0;lp(2);0];
cc=[0;lp(3)*cosd(lp(4));lp(3)*sind(lp(4))];


A(:,1)=cross(bb,cc)/dot(aa,cross(bb,cc));
A(:,2)=cross(cc,aa)/dot(aa,cross(bb,cc));
A(:,3)=cross(aa,bb)/dot(aa,cross(bb,cc));
%-------------------------------------------

v1=peak_c_list(row1,6:8);
v2=peak_c_list(row2,6:8);
l1=sqrt(v1*v1.');
l2=sqrt(v2*v2.');
Angle_v12=v1*v2.'/l1/l2;
% Angle_v12=acosd(v1*v2.'/l1/l2);
lra=[l1,l2,l1/l2,Angle_v12];

[ind_match,MATCH] =TAB_search(TAB,lra,lra_error);
Ori_matrix=zeros(size(MATCH,1),11);

pm_list=zeros(size(peak_c_list,1),15);%point_match list
pm_list(:,1:3)=peak_c_list(:,6:8);


% M_match_score=0;
for l=1:size(MATCH,1)
    Ori_matrix(l,1:6)=MATCH(l,1:6);
    HKL1=MATCH(l,1:3).';
    HKL2=MATCH(l,4:6).';
    
    [HKL_ZAP] = ZAP_get(A,HKL1,HKL2);
    [Ori] = Ori_get(A,HKL_ZAP,v1.',v2.');
    [Ori_X] = adjust_angle(A,HKL_ZAP,HKL1,v1.',v2.',Ori);
    Ori_matrix(l,7:9)=Ori_X;
    [~,match_score]=point_match(A,peak_c_list,Ori_X,d_thld);
    Ori_matrix(l,11)=match_score;
    
    [~,ind]=sort(Ori_matrix(:,11),'descend');
%     M_match_score=max(M_match_score,match_score);
    Ori_matrix=Ori_matrix(ind,:);
%     [Int_p,peak_list2] = dif_sim_CFL(lp,E_ph,50000,10,0,1e12,0.5,110,L,SCA,Q_gen(Ori_X),1);
%     [position_match_list,p1,p2] = list_match_position(peak_c_list,peak_list2,8);
%     Ori_matrix(l,10:11)=[p1,p2];
%     [temp,ind]=sort(Ori_matrix(:,11),'descend');
%     Ori_matrix=Ori_matrix(ind,:);




end






end
