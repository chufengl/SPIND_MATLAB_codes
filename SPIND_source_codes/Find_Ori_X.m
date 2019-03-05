%"Find_Ori_X.m" finds the orientation of the Xtal following
%"detc2ES_mapping.m".

function [MATCH,Ori_matrix] = Find_Ori_X(peak_c_list,TAB,row1,row2,lra_error,lp,E_ph,L,SCA,res)


A=zeros(3);
A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
A(2,2)=1/lp(2)*sind(lp(6));
A(3,3)=1/lp(3);

v1=peak_c_list(row1,6:8);
v2=peak_c_list(row2,6:8);
l1=sqrt(v1*v1.');
l2=sqrt(v2*v2.');
Angle_v12=v1*v2.'/l1/l2;
% Angle_v12=acosd(v1*v2.'/l1/l2);
lra=[l1,l2,l1/l2,Angle_v12];

[ind_match,MATCH] =TAB_search(TAB,lra,lra_error);
Ori_matrix=zeros(size(MATCH,1),11);
for l=1:size(MATCH,1)
    Ori_matrix(l,1:6)=MATCH(l,1:6);
    HKL1=MATCH(l,1:3).';
    HKL2=MATCH(l,4:6).';
    
    [HKL_ZAP] = ZAP_get(A,HKL1,HKL2);
    [Ori] = Ori_get(A,HKL_ZAP,v1.',v2.');
    [Ori_X] = adjust_angle(A,HKL_ZAP,HKL1,v1.',v2.',Ori);
    Ori_matrix(l,7:9)=Ori_X;
    
    [Int_p,peak_list2] = dif_sim_CFL(lp,E_ph,50000,10,0,1e12,0.5,110,L,SCA,Q_gen(Ori_X),1);
    [position_match_list,p1,p2] = list_match_position(peak_c_list,peak_list2,8);
    Ori_matrix(l,10:11)=[p1,p2];
    [temp,ind]=sort(Ori_matrix(:,11),'descend');
    Ori_matrix=Ori_matrix(ind,:);
end





end