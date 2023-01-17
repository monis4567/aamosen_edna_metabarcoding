#!/bin/bash
# -*- coding: utf-8 -*-
#following this protocol: http://www.cbs.dtu.dk/courses/27626/Exercises/denovo_exercise.php
# and this website: https://www.melbournebioinformatics.org.au/tutorials/tutorials/assembly/assembly-protocol/
#read about the fastq format : https://en.wikipedia.org/wiki/FASTQ_format
#read about DNA sequencing : https://en.wikipedia.org/wiki/DNA_sequencing
WD="$(pwd)"

DIR1="ngs_AMRH_libs_fastqc_reports_2020jan17"

#rm -rf "${DIR1}"
#make a new directory
#mkdir "${DIR1}"
#change in to this new directory
cd "${DIR1}"
#copy the fastq.gz files to your new directory -  this way you still have the original fastq.gz files to return to
#cd /groups/hologenomics/marierh/data/ngs_seq_mifishU_2019nov11/
#for FILE in *.fastq.gz 
#	do
#		chmod 755 "${FILE}"
#	done

#cp /groups/hologenomics/marierh/data/ngs_seq_mamm01_2019dec09/* .
#cp /groups/hologenomics/phq599/data/NGS_data_SKW2019mar/* .
cd "${WD}"/"${DIR1}"
#remove previous versions of directory
rm -rf fastqc
#make the new directory again
mkdir fastqc
#load required modules on server
module load java/v1.8.0_131 #fastqc requires java to be loaded first
module load fastqc/v0.11.8a

#xsbatch -c 1 --mem-per-cpu 32768 -o slurm.output.Gm.Actinop.ecopcr.txt -e slurm-%j.err -- 
xsbatch -c 1 --mem-per-cpu 32768 -o slurm-%j.out -e slurm-%j.err -- fastqc -o fastqc *.fastq

#firefox fastqc/Vchol-001_6_1_sequence_fastqc.html fastqc/Vchol-001_6_2_sequence_fastqc.html &

