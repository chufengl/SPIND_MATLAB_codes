%"solution_pool_np.m" tries indexing with different pairs of spots and stores
%solutions in the solution pool list.

%sol_pool is set as a structure.

% does not compute predicted diffraction pattern for spot match.

function [sol_pool,com_Ori] = solution_pool_np(peak_c_list,TAB,row_list,lra_error,lp,E_ph,L,SCA,deg_thld)

global sf_list

field1='row_id';
field2='Ori_matrix';
N_pairs=size(row_list,2)*(size(row_list,2)-1)/2;
value1=cell(1,N_pairs);
value2=cell(1,N_pairs);

N_sol_found=zeros(1,N_pairs);

sol_pool=struct(field1,value1,field2,value2);

load('TAB1-1185.mat');


pair_counter=1;
for l=1:size(row_list,2)
    row1=row_list(l);
    for m=(l+1):size(row_list,2)
        tic
        row2=row_list(m);
        sol_pool(pair_counter).row_id=[row1,row2];
        [~,sol_pool(pair_counter).Ori_matrix] = Find_Ori_X_np(peak_c_list,TAB,row1,row2,lra_error,lp,E_ph,L,SCA);
        N_sol_found(pair_counter)=size(sol_pool(pair_counter).Ori_matrix,1);
        disp([num2str(pair_counter/N_pairs),'has been completed.'])
        pair_counter=pair_counter+1;
        toc
    end
    

    
end

[~,ind]=sort(N_sol_found,'descend');
[com_Ori]=com_compare(sol_pool(ind(1)).Ori_matrix,sol_pool(ind(2)).Ori_matrix,deg_thld);
tic
for n=1:size(com_Ori,1)
    Ori_X=com_Ori(n,2:4);
    [peak_list2] = dif_sim_CFL_fast(lp,E_ph,50000,10,0,1e12,0.5,110,L,SCA,Q_gen(Ori_X),1);
    [~,p1,p2] = list_match_position(peak_c_list,peak_list2,8);
    com_Ori(n,9:10)=[p1,p2];
    [~,ind1]=sort(com_Ori(:,10),'descend');
    com_Ori=com_Ori(ind1,:);
end
toc

end