#!/bin/bash
#SBATCH --account=hologenomics         # Project Account
#SBATCH --partition=hologenomics 
#SBATCH --mem 4G
#SBATCH -c 1
#SBATCH --hint nomultithread
#SBATCH -t 1:00:00
#SBATCH -J pa02_dada2_sickle
#SBATCH -o stdout_pa02_dada2_sickle.txt
#SBATCH -e stderr_pa02_dada2_sickle.txt

#get present working directory and put it in a variable
WD=$(pwd)
#change directory to where previously attempted filtered files have been saved
cd DADA2_AS
#remove any previous output directories generated by the r-script you are about to run
rm -rf filtered
#change back to the working directory
cd "$WD"
#change directory to where previously attempted filtered files have been saved
cd DADA2_SS
#remove any previous output directories generated by the r-script you are about to run
rm -rf filtered
#change back to the working directory
cd "$WD"
#remove any previous versions of sickle
rm -rf sickle*
#copy sickle master
cp /groups/hologenomics/phq599/data/ES_metabarcode_example/Metabarcoding_pipeline/sickle-master.tar.gz .
#uncompress the tar.gz file
tar -zxf sickle-master.tar.gz

cd sickle-master
chmod 755 sickle

cd "$WD"
##source activate YOUR_CONDA_ENV
##source /com/extra/R/3.5.0/load.sh
#load modules required
module purge
module load python/v2.7.12
module load cutadapt/v1.11
module load vsearch/v2.8.0

# the 'dada2' package for R requires R v3.4
module load R/v3.4.3

#srun part02_dada2_sickle_v2_AMRH_AL_v02.r
srun part02_dada2_sickle_v2_start_swk_AMRH_FL_v03.r