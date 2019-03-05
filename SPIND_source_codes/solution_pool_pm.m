%"solution_pool_pm.m" tries indexing with different pairs of spots and stores
%solutions in the solution pool list.

%sol_pool is set as a structure.
%To shorten the computation time, point match algorithm is applied here.

function [M_match_score,sol_pool] = solution_pool_pm(peak_c_list,TAB,row_list,lra_error,lp)
tic
%-----------sort the peak_c_list according to resolution
[~,ind]=sort(peak_c_list(:,9),'descend');
peak_c_list=peak_c_list(ind,:);

%-----------

field1='row_id';
field2='Ori_matrix';
field3='max_match_score';
N_pairs=size(row_list,2)*(size(row_list,2)-1)/2;
value1=cell(1,N_pairs);
value2=cell(1,N_pairs);
value3=cell(1,N_pairs);


sol_pool=struct(field1,value1,field2,value2,field3,value3);

%load('TAB1-1185.mat');

M_match_score=0;
pair_counter=1;
for l=1:size(row_list,2)
    row1=row_list(l);
    for m=(l+1):size(row_list,2)
%         tic
        row2=row_list(m);
        sol_pool(pair_counter).row_id=[row1,row2];
        [~,sol_pool(pair_counter).Ori_matrix] = Find_Ori_X_pm(peak_c_list,TAB,row1,row2,lra_error,lp,0.01);
        sol_pool(pair_counter).max_match_score=max(sol_pool(pair_counter).Ori_matrix(:,11));
        if isempty(sol_pool(pair_counter).max_match_score)
        else
            M_match_score=max(M_match_score,sol_pool(pair_counter).max_match_score);
        end
        
        disp([num2str(pair_counter/N_pairs),'has been completed.'])
        pair_counter=pair_counter+1;
%         toc
    end
    
    
end



toc
end
