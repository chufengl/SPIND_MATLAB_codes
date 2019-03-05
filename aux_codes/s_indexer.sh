#!/bin/bash

#SBATCH -—job-name=cxij6916_s_indexing
#SBATCH -p cluster
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 1-12:00
#SBATCH --mem-per-cpu=5000

##SBATCH --array=4,5,10%8

##SBATCH -A chufengl
#SBATCH -o cxij6916_s_indexing_%A_%a.out
#SBATCH -e cxij6916_s_indexing_%A_%a.err
##SBATCH —-mail-user=chufengl@asu.edu
##SBATCH --mail-type=ALL
#SBATCH --mail-type=ALL        # notifications for job done & fail
#SBATCH --mail-user=chufengl@asu.edu # send-to address
module load matlab/2016a


matlab  -nodesktop -nojvm -r “addpath('/home/chufengl/test_folder/sparse indexing source codes','-end');[end_id]=plist_counter(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)]);
[all_solution,index_rate]=run_batch(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)],['cxij6916-r00',num2str($SLURM_ARRAY_TASK_ID),'e'],1,end_id);
[abc_star_out,com_counter] = abc_star_compute(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)]);
stream_out(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)],'/home/chufengl/test_folder');
exit”
