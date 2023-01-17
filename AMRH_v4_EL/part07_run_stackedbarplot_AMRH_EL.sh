#!/bin/bash
#SBATCH --account=hologenomics         # Project Account
#SBATCH --partition=hologenomics 
#SBATCH --mem 1G
#SBATCH -c 1
#SBATCH -t 1:00:00
#SBATCH -J stckbar
#SBATCH -o stdout_pa07_stckbar.txt
#SBATCH -e stderr_pa07_stckbar.txt

##source activate YOUR_CONDA_ENV
##source /com/extra/R/3.5.0/load.sh
#load modules required
module purge
#copy the outs table input file needed for the stacked bar plots
cp DADA2_nochim.table part03_DADA2_nochim.table.AMRH_EL.txt
# the 'ggpubr' package for R requires R/v3.6.1
# you will need to install the 'ggpubr' package  on your remote directory before you can run this R code
module load R/v3.6.1
#chmod 755 part07_stackedbarplots_w_color_per_group_R05.r
#srun part07_stackedbarplots_w_color_per_group_R05.r
srun part07_stackedbarplots_w_color_per_group_AMRH_EL_v01.r
