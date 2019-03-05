%"abc_star_compute.m" takes the index solution structure as input and
%output the abc stars in terms of matrix in a structure.


function [abc_star_out,com_counter] = abc_star_compute(lp,folder)

poolobj=parpool('local',8);
oldfolder1=cd(folder);

%obataint the .mat file name containing the index solutions.
%--------------------
list=dir(['I3C*edge*_',num2str(lp(4)),'.mat']);
name=list.name;
load(name);
%cd(oldfolder1);
%--------------------



A=zeros(3);

%for orthorhombic lattice
%-------------------------------------------
%A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
%A(2,2)=1/lp(2)*sind(lp(6));
%A(3,3)=1/lp(3);
%-------------------------------------------
%for monoclinic lattice
%-------------------------------------------
%aa=[lp(1);0;0];
%bb=[lp(2)*cosd(lp(6));lp(2)*sind(lp(6));0];
%cc=[lp(3)*cosd(lp(5));0;lp(3)*sind(lp(5))];
aa=[lp(1);0;0];
bb=[0;lp(2);0];
cc=[0;lp(3)*cosd(lp(4));lp(3)*sind(lp(4))];
A(:,1)=cross(bb,cc)/dot(aa,cross(bb,cc));
A(:,2)=cross(cc,aa)/dot(aa,cross(bb,cc));
A(:,3)=cross(aa,bb)/dot(aa,cross(bb,cc));
%-------------------------------------------
a_star0=A(:,1);
b_star0=A(:,2);
c_star0=A(:,3);

field5='event_id';
field6='Ori_angle';
field7='Ori_matrix';
field8='M_match_score';
field9='com_success';
field10='pm_list';

value5=cell(1,index_counter);
value6=cell(1,index_counter);
value7=cell(1,index_counter);
value8=cell(1,index_counter);
value9=cell(1,index_counter);
value10=cell(1,index_counter);

abc_star_out=struct(field5,value5,field6,value6,field7,value7,field8,value8,field9,value9,field10,value10);

index_success_M=[all_solution(:).index_success].';
event_id_M=[all_solution(:).event_id].';
M_match_score_M=[all_solution(:).M_match_score].';

[row]=find(index_success_M);
event_id_M=event_id_M(row);
M_match_score_M=M_match_score_M(row);



com_counter=0;




parfor l=1:index_counter
    abc_star_out(l).event_id=event_id_M(l);
    
    abc_star_out(l).M_match_score=M_match_score_M(l);
    [com_Ori] = sol_filter(all_solution(abc_star_out(l).event_id).solution_pool);
    
    if isempty(com_Ori)
        abc_star_out(l).Ori_angle=[];
        abc_star_out(l).com_success=0;
    else 
        abc_star_out(l).Ori_angle=com_Ori(1:min(size(com_Ori,1),4),:);
        abc_star_out(l).com_success=1;
        com_counter=com_counter+1;
    end
    
    %lp=[9.21,15.74,18.82,90,90,90];
%     a_star0=[1/lp(1);0;0];
%     b_star0=[0;1/lp(2);0];
%     c_star0=[0;0;1/lp(3)];


    abc_star_out(l).Ori_matrix=cell(1,size(abc_star_out(l).Ori_angle,1));
    abc_star_out(l).pm_list=cell(1,size(abc_star_out(l).Ori_angle,1));
    for k=1:size(abc_star_out(l).Ori_angle,1)
        a_star=Q_gen(abc_star_out(l).Ori_angle(k,2:4))\a_star0;
        b_star=Q_gen(abc_star_out(l).Ori_angle(k,2:4))\b_star0;
        c_star=Q_gen(abc_star_out(l).Ori_angle(k,2:4))\c_star0;
        abc_star_out(l).Ori_matrix(k)={Q_gen([0,0,180])\Q_gen([90,90,180])\Q_gen([45,90,180])\[a_star,b_star,c_star]};
        %-----------------match_list generating module
        FNAME=['I3C_1C_Zn_edge',num2str(abc_star_out(l).event_id),'.txt'];
        [peak_c_list] = peak_list_conv(FNAME,0.07,110);
        [pm_list,~]=point_match(A,peak_c_list,abc_star_out(l).Ori_angle(k,2:4),0.02);
        abc_star_out(l).pm_list(k)={[pm_list(:,1:6),round(pm_list(:,4:6)),pm_list(:,7:16)]};
        
        
        
        %---------------------------------------------
        
    end
    
    
end

delete(poolobj);
namef=['I3C_1C_Zn_edge',num2str(lp(4)),'filtered.mat'];
%oldfolder1=cd(folder);
save(namef)
cd(oldfolder1);

end
