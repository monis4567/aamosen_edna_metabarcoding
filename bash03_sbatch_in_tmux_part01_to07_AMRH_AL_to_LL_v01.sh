#!/bin/bash
# -*- coding: utf-8 -*-
echo $BASH_VERSION

# get working directory
WD=$(pwd)

## declare an array variable
declare -a arr=(
{I..L}
)
# iterate over elements
for i in "${arr[@]}"
do 
   #remove any previous versions of uncompressed directories
   rm -rf "$WD"/AMRH_v4_"$i"L
   #uncompress tar gz files
   tar -zxf AMRH_v4_"$i"L.tar.gz
   #change back to working directory
   cd "$WD"
done
# wait a bit to make sure all compressed folders have been uncompressed
sleep 30s
# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   #start the slurm submission script
   #sbatch part02_run_sickle_sbatch_JMS_"$i"L.sh
   sbatch part01_run_demultiplex_sbatch_AMRH_"$i"L.sh
   #
   echo "submitted part01 for "$i"L"
   cd "$WD"
done

#sleep for 2 hours to wait for the jobs to complete -  it takes around 60 minutes to finish part01
# it takes longer for some of the AMRH libraries
sleep 150m

# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   #start the slurm submission script
   sbatch part02_run_sickle_sbatch_AMRH_"$i"L.sh
   #
   echo "submitted part02 for "$i"L"
   #pause before submitting the next job
   sleep 30m
   cd "$WD"
done

#sleep for 15 minutes to wait for the jobs to complete -  it takes around 15 minutes to finish part02
sleep 2h

# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   #start the slurm submission script
   sbatch part03_run_DADA2_end_AMRH_"$i"L.sh
   #
   echo "submitted part03 for "$i"L"
   cd "$WD"
done
 #sleep for 2 minutes to wait for the jobs to complete -  it takes around 1 minute to finish part03
 sleep 30m

# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   #start the slurm submission script
   sbatch part04_run_02blast_global_AMRH_"$i"L.sh
   echo "submitted part04 for "$i"L"
   #pause for 4 minutes before submitting the next request
   sleep 4m   #
   
   cd "$WD"
done

#sleep for 20 minutes to wait for the jobs to complete - it takes around 15 minutes to finish part04
sleep 40m

# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   #start the slurm submission script
   sbatch part05_sbatch_run_limBLAST_AMRH_"$i"L.sh
   echo "submitted part05 for "$i"L"
   sleep 30m
   cd "$WD"
done
#sleep for 1 minutes to wait for the jobs to complete - it takes less than 1 minute to finish part05
sleep 1h

# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   #start the slurm submission script
   sbatch part06_run_my_taxonomyB_slurmsubmis_AMRH_"$i"L.sh
   echo "submitted part06 for "$i"L"
   #sleep for 2 minutes to wait for the jobs to complete - it takes less than 1 minute to finish part06
   # set the sleep step inside the loop to avoid making too many requests to NBCI
   sleep 10m
   
   cd "$WD"
done

sleep 40m
# iterate over elements
for i in "${arr[@]}"
do 
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L
   # delete any previous versions of pdf plots
   rm *.pdf
   #start the slurm submission script
   sbatch part07_run_stackedbarplot_AMRH_"$i"L.sh
   echo "submitted part07 for "$i"L"
   
   cd "$WD"
done

#sleep for 2 minutes to wait for the jobs to complete
sleep 10m

## now loop through the above array
for i in "${arr[@]}"
do
   # navigate in to uncompressed directories
   cd "$WD"/AMRH_v4_"$i"L

   #move the output file
   # mv part07_JMS_"$i"L_stackedbar_plot02.pdf part07_JMS_EL_stackedbar_plot02."$i".pdf
   # mv part07_JMS_"$i"L_otus_blast.csv part07_JMS_EL_otus_blast."$i".csv 
   # #copy the out files
   cp part07_AMRH_"$i"L_stackedbar_plot02.pdf "$WD"/.
   cp part07_AMRH_"$i"L_otus_blast.csv "$WD"/.
   
   cd "$WD"
done
#change directory
cd "$WD"
#compress all pdfs and csvs
tar -zcvf part07_AMRH_stackedbar_plot02.tar.gz part07_AMRH_*L_stackedbar_plot02.pdf
tar -zcvf part07_AMRH_otus_blast.tar.gz part07_AMRH_*L_otus_blast.csv
#define output file names
OUTF1="AMRH_csv_otus_assembl_A_to_L_w_BLAST_01.txt"
OUTF2="AMRH_csv_otus_assembl_A_to_L_w_BLAST_02.txt"
#make an empty file to put the all the csv files in
touch "$WD"/"$OUTF1"
iconv -f UTF-8 -t UTF-8 "$WD"/"$OUTF1"
#iterate over files with the csv ending
for f in *.csv
do
   # echo the file name to screen
   #echo "$f"
   # see the number of lines in each file
   #wc -l "$f"
   #append to the file prepared above
   cat "$f" >> "$WD"/"$OUTF1"
done
#count all lines in the file
#wc -l "$WD"/"$OUTDIR1"/"$OUTF1"
#concatenate content of first outfile, sort it, return only unique lines
cat "$WD"/"$OUTF1" | sort | uniq > "$WD"/"$OUTF2"

#remove the pdf and csv files
rm *.pdf
rm *.csv

#use this command remotely if you need to cancel multiple slurm jobs
# seqn=$(seq 16618353 16618354);for i in $seqn; do scancel "$i";done