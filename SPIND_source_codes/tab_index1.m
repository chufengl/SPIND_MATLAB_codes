%%"tab_index.m" tabulates the Length ratio and angles between any pair of
%%vectors in 3-D reciprocal space within a designated resolution limit and
%%search for a pair that matches a designated length ratio and angle.
% using for loops instead of while loops.

function  [sf_list,TAB] = tab_index1(lp,res,sf_opt,m_start,m_end)

%sf_opt is a string option indicating if the searching process for match is
%based on the structure factor list or not. 
%the value of sf_opt can be either one of 'sf' and 'nsf'.
%global sf_list;
switch sf_opt
    case 'sf'
        %import the structure factor list within resolution limit of 20A
        
        
        [sf_list] = sf_ext('4ib4.pdb-temp.hkl',res,lp);

        
    case 'nsf'
        %generate complete structure factor list disregarding the
        %forbidden rules(no intensity information incorporated).
        limit_up=10;%upper limit of Miller indices.
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
A(1,1)=1/lp(1);A(1,2)=1/lp(2)*cosd(lp(6));
A(2,2)=1/lp(2)*sind(lp(6));
A(3,3)=1/lp(3);
%-----------------------------------------

TAB_size=size(sf_list,1)*(size(sf_list,1)-1)/2;

TAB=zeros(TAB_size,10);
%-----------------------------------------
%
TAB_row_counter=1;

    m=m_start;
    for m=m_start:m_end
        tic
        HKL1=sf_list(m,1:3).';
        for n=(m+1):size(sf_list,1)
            
            HKL2=sf_list(n,1:3).';
             
             [L1,L2,LR,Ang]=LRA(A,HKL1,HKL2);
                    TAB(TAB_row_counter,1:3)=HKL1.';
                    TAB(TAB_row_counter,4:6)=HKL2.';
                    TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
                    TAB_row_counter=TAB_row_counter+1;
                    
            
        end
        toc
    end
    
   

TAB=TAB((1:TAB_row_counter-1),:);

NAME_file=['TAB',num2str(m_start),'-',num2str(m_end),'.mat'];
save(NAME_file,'TAB');


end