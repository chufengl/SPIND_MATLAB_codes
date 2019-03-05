%%"tab_index.m" tabulates the Length ratio and angles between any pair of
%%vectors in 3-D reciprocal space within a designated resolution limit and
%%search for a pair that matches a designated length ratio and angle.

function  [sf_list,TAB] = tab_index(lp,res,TAB_size,sf_opt,m_start,m_end)

%sf_opt is a string option indicating if the searching process for match is
%based on the structure factor list or not. 
%the value of sf_opt can be either one of 'sf' and 'nsf'.
%global sf_list;
switch sf_opt
    case 'sf'
        %import the structure factor list within resolution limit of 20A
        
        
        [sf_list] = sf_ext('i3c_crystalstructure.pdb.hkl',res,lp);

        
    case 'nsf'
        %generate complete structure factor list disregarding the
        %forbidden rules(no intensity information incorporated).
        limit_up=30;%upper limit of Miller indices.
        sf_list=zeros((limit_up+1)^3,3);
        sf_counter=1;
        for h=0:limit_up
            for k=0:limit_up
                for l=0:limit_up
                    sf_list(sf_counter,:)=[h,k,l];
                    sf_counter=sf_counter+1;
                end
            end
        end
        
        
        
    otherwise
        error('sf_opt must be one of "sf" and "nsf".')
end

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
bb=[lp(2)*cosd(lp(6));lp(2)*sind(lp(6));0];
cc=[lp(3)*cosd(lp(5));0;lp(3)*sind(lp(5))];

A(:,1)=cross(bb,cc)/dot(aa,cross(bb,cc));
A(:,2)=cross(cc,aa)/dot(aa,cross(bb,cc));
A(:,3)=cross(aa,bb)/dot(aa,cross(bb,cc));
%-------------------------------------------


%-----------------------------------------


TAB=zeros(TAB_size,10);
%-----------------------------------------
%
TAB_row_counter=1;

    m=m_start;
    while (m<=(size(sf_list,1)-1))&&(m<=m_end)
        HKL1=sf_list(m,1:3).';
%         XYZ1=A*HKL1;
%         if XYZ1.'*XYZ1<(1/res)^2
            n=m+1;
            %             n=1;
            while n<=size(sf_list,1)&& (TAB_row_counter<=TAB_size)
%                 tic
                HKL2=sf_list(n,1:3).';
%                 XYZ2=A*HKL2;
%                 if XYZ2.'*XYZ2<(1/res)^2
                    
                    %HKL2_1=[HKL2(1);HKL2(2);HKL2(3)];
%                     HKL2_2=[HKL2(1);HKL2(2);-HKL2(3)];
%                     HKL2_3=[HKL2(1);-HKL2(2);HKL2(3)];
%                     HKL2_4=[-HKL2(1);HKL2(2);HKL2(3)];
%                     HKL2_5=[HKL2(1);-HKL2(2);-HKL2(3)];
%                     HKL2_6=[-HKL2(1);HKL2(2);-HKL2(3)];
%                     HKL2_7=[-HKL2(1);-HKL2(2);HKL2(3)];
%                     HKL2_8=[-HKL2(1);-HKL2(2);-HKL2(3)];
                    
                    [L1,L2,LR,Ang]=LRA(A,HKL1,HKL2);
                    TAB(TAB_row_counter,1:3)=HKL1.';
                    TAB(TAB_row_counter,4:6)=HKL2.';
                    TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
                    TAB_row_counter=TAB_row_counter+1;
                    
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_2,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_2.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
%                     
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_3,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_3.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
%                     
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_4,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_4.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
%                     
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_5,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_5.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
%                     
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_6,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_6.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
%                     
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_7,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_7.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
%                     
%                     [L1,L2,LR,Ang]=LRA(E_ph,A,HKL1,HKL2_8,clen);
%                     TAB(TAB_row_counter,1:3)=HKL1.';
%                     TAB(TAB_row_counter,4:6)=HKL2_8.';
%                     TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%                     TAB_row_counter=TAB_row_counter+1;
                    
%                 else
%                     
%                 end
                n=n+1;
%                 toc
            end
%         else
%             
%         end
        m=m+1;
    end

TAB=TAB((1:TAB_row_counter-1),:);

NAME_file=['TAB',num2str(m_start),'-',num2str(m_end),'.mat'];
save(NAME_file,'TAB');


end