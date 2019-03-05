%"run_batch.m" does the indexing in batch mode.

function [all_solution,index_rate]=run_batch(lp,TAB_name,folder,Base_name,start_id,end_id)

poolobj=parpool('local',8);
load(['../tables/',TAB_name]);
TAB=TAB;
oldfolder=cd(folder);

field1='event_id';
field2='solution_pool';
field3='M_match_score';
field4='index_success';
value1=cell(1,size(start_id:end_id,2));
value2=cell(1,size(start_id:end_id,2));
value3=cell(1,size(start_id:end_id,2));
value4=cell(1,size(start_id:end_id,2));
all_solution=struct(field1,value1,field2,value2,field3,value3,field4,value4);



index_counter=0;

parfor l=1:size(start_id:end_id,2)
FNAME=[Base_name,num2str(l+start_id-1),'.txt'];
[peak_c_list] = peak_list_conv(FNAME,0.07,110);

[M_match_score,sol_pool] = solution_pool_pm(peak_c_list,TAB,[1:5],2*[0.01,0.01,0.05,0.01],lp);
all_solution(l).solution_pool=sol_pool;
all_solution(l).M_match_score=M_match_score;
all_solution(l).index_success=(M_match_score>=0.9);
all_solution(l).event_id=l+start_id-1;
if M_match_score>=0.9;
index_counter=index_counter+1;
end
disp([num2str(l),'th of',num2str(size(start_id:end_id,2)),'patterns indexed.'])
end
delete(poolobj);

%lp=[9.0214,15.735,18.816,90.00,90.00,90.00];

index_rate=index_counter/size(start_id:end_id,2);
NAME_mat=[Base_name,num2str(start_id),'_',num2str(end_id),'_',num2str(lp(4)),'.mat'];
save(NAME_mat);
cd(oldfolder);

end
