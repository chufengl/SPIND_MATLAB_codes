%"sol_filter.m" selects the best four solutions from the solution pool.

function [com_Ori] = sol_filter(solution_pool)


for l=1:size(solution_pool,2)
    if isempty(solution_pool(l).max_match_score)
        solution_pool(l).max_match_score=0;
    end

end

max_match_score_M=[solution_pool.max_match_score].';
max_match_score_M=max_match_score_M(size(solution_pool,2):-1:1);
[~,ind1]=sort(max_match_score_M,'descend');
ind=11*ones(size(solution_pool,2),1)-ind1;


com_counter=1;
com_success=0;
ind_pair=[ind(1),ind(2);ind(1),ind(3);ind(2),ind(3)];
while (com_counter<=3)&&(com_success==0)
    [com_Ori]=com_compare(solution_pool(ind_pair(com_counter,1)).Ori_matrix,solution_pool(ind_pair(com_counter,2)).Ori_matrix,2);
    if isempty(com_Ori)
        com_counter=com_counter+1;
    else
        com_success=1;
    end
end


end