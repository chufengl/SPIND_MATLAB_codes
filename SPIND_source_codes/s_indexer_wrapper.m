%%Matlab sparse indexing wrapper.


addpath('/home/chufengl/test_folder/matlab on saguaro test codes/SPIND_source_codes','-end');
alpha=86;
s=sqrt(1/sind(alpha));
lp=[9.0214,15.735*s,18.816*s,alpha,90.00,90.00];
[end_id]=plist_counter(['/home/chufengl/test_folder/matlab on saguaro test codes/peak_lists/run',num2str(SLURM_ARRAY_TASK_ID)]);
[Base_name_p]=BN_pre(SLURM_ARRAY_TASK_ID);
[all_solution,index_rate]=run_batch(lp,'TAB_86.mat',['/home/chufengl/test_folder/matlab on saguaro test codes/peak_lists/run',num2str(SLURM_ARRAY_TASK_ID)],[Base_name_p],1,end_id);
[abc_star_out,com_counter] = abc_star_compute(lp,['/home/chufengl/test_folder/matlab on saguaro test codes/peak_lists/run',num2str(SLURM_ARRAY_TASK_ID)]);
stream_out(lp,['/home/chufengl/test_folder/matlab on saguaro test codes/peak_lists/run',num2str(SLURM_ARRAY_TASK_ID)],['/home/chufengl/test_folder/matlab on saguaro test codes/stream_files','/run',num2str(SLURM_ARRAY_TASK_ID)]);

