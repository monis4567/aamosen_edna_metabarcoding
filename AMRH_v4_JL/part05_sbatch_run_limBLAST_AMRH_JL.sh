#!/bin/bash
#SBATCH --account=hologenomics         # Project Account
#SBATCH --partition=hologenomics 
#SBATCH --mem 1G
#SBATCH -c 1
#SBATCH -t 1:00:00
#SBATCH -J dada2_sickle
#SBATCH -o stdout_pa05limblast.txt
#SBATCH -e stderr_pa05limblast.txt


##source activate YOUR_CONDA_ENV
##source /com/extra/R/3.5.0/load.sh
#load modules required
module purge
#module load python/v2.7.12
#module load cutadapt/v1.11
#module load vsearch/v2.8.0


# load the R module 'dada2' package for R requires R v3.4
module load R/v3.4.3
# run the R code
srun part05_limit_BLAST_results_before_taxonomyB_AMRH_JL_01.r