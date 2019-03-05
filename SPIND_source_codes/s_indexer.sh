#!/bin/bash

#SBATCH --job-name=sim_s_indexing
#SBATCH -p serial
#SBATCH -n 8
#SBATCH -N 1
#SBATCH -t 1-12:00
#SBATCH --mem-per-cpu=8000    
#SBATCH --array=7%8

##SBATCH -A chufengl
#SBATCH -o sim_s_indexing_%A_%a.out
#SBATCH -e sim_s_indexing_%A_%a.err
##SBATCH --mail-type=ALL
#SBATCH --mail-type=ALL        # notifications for job done & fail
#SBATCH --mail-user=chufengl@asu.edu # send-to address

module load matlab/2016a


matlab -nodesktop  -r "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID; s_indexer_wrapper;exit"
