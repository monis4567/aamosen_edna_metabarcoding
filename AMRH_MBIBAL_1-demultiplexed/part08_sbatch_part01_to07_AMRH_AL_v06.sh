#!/bin/bash
# -*- coding: utf-8 -*-
echo $BASH_VERSION

# get working directory
WD=$(pwd)
#define the input directory
INP1="AMRH_MBIBAL_1-demultiplexed"
#define output directory
OUTDIR1="AMRH_MBIBAL_1-demultiplexed_v02"
#remove previous output directory
rm -rf "$OUTDIR1"
#
mkdir "$OUTDIR1"

## declare an array variable
declare -a arr=(

"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom0.1" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom0.5" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom0.7" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom1" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom1.2" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom1.5" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom2" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom5" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom10" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom20" 
"p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom50" 

# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.3lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.35lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.4lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.45lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.55lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.6lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.65lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.7lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.75lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.8lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.85lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.9lom2" 
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.95lom2" 


# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs600pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs900pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs1200pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs1500pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs1800pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL65p04mxTs2100pID80p06upm0.5lom2" 

# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL70p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL80p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL85p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL95p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL100p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL105p04mxTs300pID80p06upm0.5lom2" 
# "p02rmPFmxE4miL110p04mxTs300pID80p06upm0.5lom2" 

# "p02rmPFmxE2miL65p04mxTs300pID80p06upm0.5lom2"
# "p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom2"
# "p02rmPFmxE8miL65p04mxTs300pID80p06upm0.5lom2"
# "p02rmPFmxE16miL65p04mxTs300pID80p06upm0.5lom2"
# "p02rmPFmxE32miL65p04mxTs300pID80p06upm0.5lom2"
)
#change to new directory
cd "$OUTDIR1"
# # now loop through the above array
# for i in "${arr[@]}"
# do
#    #echo "$i"
#    #cd "$WD"
#    # or do whatever with individual element of the array
#    NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
#    #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
#    NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
#    #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
#    # copy the original directory recursively
#    #cp -R "$WD"/"AMRH_MBIBAL_1-demultiplexed" .
#    cp -R "${WD}"/"${INP1}" "${WD}"/"$OUTDIR1"/"${NWDIR}"

#    #change directory in to this directory
#    cd "$WD"/"$OUTDIR1"/"$NWDIR"
#    #modify the part02 R code for the maxEE value
#    #cat part02_dada2_sickle_v2_start_swk_AMRH_AL.r | sed "s/mxEEval=4/mxEEval=$NWNM/g" > tmp01.txt
#    cat part02_dada2_sickle_v2_start_swk_AMRH_AL_v02.r | sed "s/fpfml <- 65/fpfml <- $NWNM/g" > tmp01.txt
#    #cat part02_dada2_sickle_v2_start_swk_AMRH_AL_v02.r | sed "s/mxEEval=4/mxEEval=$NWNM/g" > tmp01.txt
#    #rename the file
#    mv tmp01.txt part02_dada2_sickle_v2_start_swk_AMRH_AL_v02.r
#    #modify permission on the copied file
#    chmod 755 part02_dada2_sickle_v2_start_swk_AMRH_AL_v02.r
#    #chmod 755 part02_dada2_sickle_v2_start_swk_AMRH_AL.r
#    #start the slurm submission script
   
#    sbatch part02_run_sickle_sbatch_AMRH_MBIB_AL.sh
#    # change directory
#    cd "$WD"/"$OUTDIR1"/
# done

# #sleep for 15 minutes to wait for the jobs to complete -  it takes around 10 minutes to finish part02
# sleep 20m

## now loop through the above array
for i in "${arr[@]}"
do
   #echo "$i"
   # or do whatever with individual element of the array
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs//g' | sed 's/pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_rmPFmxE${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_mxTs${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm//g' | sed 's/p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/lom2//g')
   NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom//g') # | sed 's/lom2//g')
   NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   
   #copy the original directory recursively
   cp -R "${WD}"/"${INP1}" "${WD}"/"$OUTDIR1"/"${NWDIR}"
   #change directory in to this directory
   cd "$WD"/"$OUTDIR1"/"$NWDIR"


   #echo "$i"
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   #change directory in to this directory
   #cd "$WD"/"$OUTDIR1"/"$NWDIR"
   #sbatch part03_run_DADA2_end_AMRH_AL.sh
   sbatch part03_run_DADA2_end_AMRH_MBIB_AL.sh
   cd "$WD"/"$OUTDIR1"/
done
#sleep for 2 minutes to wait for the jobs to complete -  it takes around 1 minute to finish part03
sleep 2m

## now loop through the above array
for i in "${arr[@]}"
do
      #echo "$i"
   # or do whatever with individual element of the array
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm//g' | sed 's/lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")

   NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom//g') # | sed 's/lom2//g')
   NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   

   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_p02rmPFmxE${NWNM}")
   # #copy the original directory recursively
   # cp -R "${WD}"/"${INP1}" "${WD}"/"$OUTDIR1"/"${NWDIR}"
   #change directory in to this directory
   cd "$WD"/"$OUTDIR1"/"$NWDIR"
 
   #modify the part02 R code for the maxEE value
   #cat part02_dada2_sickle_v2_start_swk_AMRH_AL.r | sed "s/mxEEval=4/mxEEval=$NWNM/g" > tmp01.txt
   #cat part04_run_02blast_global_AMRH_MBIB_AL.sh | sed "s/-perc_identity 80/-perc_identity $NWNM/g" > tmp01.txt
   #cat part04_run_02blast_global_AMRH_MBIB_AL.sh | sed "s/-max_target_seqs 300/-max_target_seqs $NWNM/g" > tmp01.txt
   #rename the file
   #mv tmp01.txt part04_run_02blast_global_AMRH_MBIB_AL.sh
   #modify permission on the copied file
   #chmod 755 part04_run_02blast_global_AMRH_AL.sh
   chmod 755 part04_run_02blast_global_AMRH_MBIB_AL.sh

   sbatch part04_run_02blast_global_AMRH_MBIB_AL.sh
   #pause for 4 minutes before submitting the next request
   sleep 4m
   cd "$WD"/"$OUTDIR1"/
done
#sleep for 20 minutes to wait for the jobs to complete - it takes around 15 minutes to finish part04
sleep 30m

## now loop through the above array
for i in "${arr[@]}"
do
   #echo "$i"
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_p02rmPFmxE${NWNM}")
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs//g' | sed 's/pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_mxTs${NWNM}")
   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")

   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm//g' | sed 's/lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")

   NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom//g') # | sed 's/lom2//g')
   NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   
   #change directory in to this directory
   cd "$WD"/"$OUTDIR1"/"$NWDIR"
   sbatch part05_sbatch_run_limBLAST_AMRH_AL.sh
   cd "$WD"/"$OUTDIR1"/
done
#sleep for 1 minutes to wait for the jobs to complete - it takes less than 1 minute to finish part05
sleep 1m

## now loop through the above array
for i in "${arr[@]}"
do
   #echo "$i"
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs//g' | sed 's/pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_mxTs${NWNM}")
   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")

   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm//g' | sed 's/lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   # #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_p02rmPFmxE${NWNM}")
   NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom//g') # | sed 's/lom2//g')
   NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
      
   # #copy the original directory recursively
   # cp -R "${WD}"/"${INP1}" "${WD}"/"$OUTDIR1"/"${NWDIR}"
   cd "${WD}"/"$OUTDIR1"/"${NWDIR}"
   #cat part06_my_taxonomy_B_AMRH_AL.r | sed "s/upper_margin=0.5,lower_margin=2/upper_margin=${NWNM},lower_margin=2/g" > tmp01.txt
   cat part06_my_taxonomy_B_AMRH_AL.r | sed "s/upper_margin=0.5,lower_margin=2/upper_margin=0.5,lower_margin=${NWNM}/g" > tmp01.txt
   #change the name of the temporary file prepared
   mv tmp01.txt part06_my_taxonomy_B_AMRH_AL.r
   #change directory in to this directory
   cd "$WD"/"$OUTDIR1"/"$NWDIR"
   sbatch part06_run_my_taxonomyB_slurmsubmis_AMRH_AL.sh
   cd "$WD"/"$OUTDIR1"/
	#sleep for 2 minutes to wait for the jobs to complete - it takes less than 1 minute to finish part06
	# set the sleep step inside the loop to avoid making too many requests to NBCI
	sleep 6m

done


## now loop through the above array
for i in "${arr[@]}"
do
   #echo "$i"
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_p02rmPFmxE${NWNM}")
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs//g' | sed 's/pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_mxTs${NWNM}")

   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")

   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm//g' | sed 's/lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   
   NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom//g') # | sed 's/lom2//g')
   NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")
   #change directory in to this directory
   rm part07_outpt_r_plot_stacked_bar_plot02.pdf
   cd "$WD"/"$OUTDIR1"/"$NWDIR"
   sbatch part07_run_stackedbarplot_AMRH_AL.sh

   cd "$WD"/"$OUTDIR1"/
done
#sleep for 2 minutes to wait for the jobs to complete
sleep 2m

## now loop through the above array
for i in "${arr[@]}"
do
   #echo "$i"
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs//g' | sed 's/pID80p06upm0.5lom2//g')
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL//g' | sed 's/p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_miL${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_mxTs${NWNM}")
   
   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID//g' | sed 's/p06upm0.5lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")

   # NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm//g' | sed 's/lom2//g')
   # NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   
   NWNM=$(echo "$i" | sed 's/p02rmPFmxE4miL65p04mxTs300pID80p06upm0.5lom//g') # | sed 's/lom2//g')
   NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_lom${NWNM}")
   
   #NWNM=$(echo "$i" | sed 's/p02rmPFmxE//g' | sed 's/miL65p04mxTs300pID80p06upm0.5lom2//g')
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_pID${NWNM}")
   #NWDIR=$(echo "AMRH_MBIBAL_1-demultiplexed_v02_p02rmPFmxE${NWNM}")
   #change directory in to this directory
   cd "$WD"/"$OUTDIR1"/"$NWDIR"
   #move the output file
   mv part07_outpt_r_plot_stacked_bar_plot02.pdf part07_outpt_r_plot_stacked_bar_plot02."$i".pdf
   #copy the out files
   cp part07_outpt_r_plot_stacked_bar_plot02."$i".pdf "$WD"/"$OUTDIR1"/.
   
   cd "$WD"/"$OUTDIR1"/
done
#change directory
cd "$WD"/"$OUTDIR1"/
#compress all pdfs
tar -zcvf part07_outpt_r_plot_stacked_bar_plot.tar.gz part07_outpt_r_plot_stacked_bar_plot02.*.pdf


