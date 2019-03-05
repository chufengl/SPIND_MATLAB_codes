#!/bin/bash


#SBATCH -p cluster
#SBATCH -n 36
##SBATCH -N 3
#SBATCH -t 1-12:00
##SBATCH -A chufengl
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
##SBATCH —-mail-user=chufengl@asu.edu
##SBATCH --mail-type=ALL

module load matlab/2015a

#cd /home/chufengl/test_floder/matlab on saguaro test codes

matlab -nodesktop -nojvm <batch_test_1.m

