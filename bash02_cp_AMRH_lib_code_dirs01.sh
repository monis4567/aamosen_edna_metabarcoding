#!/bin/bash
# -*- coding: utf-8 -*-

# bash code to iterate over a sequence of letters to match AMRH NGS metabarcode libraries
# put the present working directory in a variable
WD=$(pwd)
# remote target directory
RTD="/groups/hologenomics/phq599/data/AMRH_v4"
#iterate over a sequence of letters
for i in {A..L}
do
	# check multiple conditions 'or' with double pipe
    	#https://unix.stackexchange.com/questions/47584/in-a-bash-script-using-the-conditional-or-in-an-if-statement
	# check for A to C
	if [[ "$i" =~ "A" ]] || [[ "$i" =~ "B" ]] || [[ "$i" =~ "C" ]]
        then
        	TAGSFNM="tags_AMRH_A_to_C_mamm01_pcr37.txt"
            # the NGS metabarcode libraries A to C are prepared with the 
            #Mamm01_F_Taberlet_etal_2018
            #Mamm01_R_Taberlet_etal_2018 
            #primerset
            # these primers amplify a fragment around 90 bp long
            # the length for this fragment needs to be shorter
            # the tags file is specific for the pcr
        	LNSICK="lsick <- 10"
        	QUSICK="qsick <- 2"
            FPF_V="fpfml <- 10"
    fi
    # check for D to F
	if [[ "$i" =~ "D" ]] || [[ "$i" =~ "E" ]] || [[ "$i" =~ "F" ]]
        then
            TAGSFNM="tags_AMRH_D_to_F_mamm01_pcr38.txt"
            # the NGS metabarcode libraries D to F are prepared with the 
            #Mamm01_F_Taberlet_etal_2018
            #Mamm01_R_Taberlet_etal_2018 
            #primerset
            # these primers amplify a fragment around 90 bp long
            # the length for this fragment needs to be shorter
            # the tags file is specific for the pcr
            LNSICK="lsick <- 10"
            QUSICK="qsick <- 2"
            FPF_V="fpfml <- 10"
    fi
    # check for G to I
	if [[ "$i" =~ "G" ]] || [[ "$i" =~ "H" ]] || [[ "$i" =~ "I" ]]
        then
            # the NGS metabarcode libraries G to I are prepared with the 
            #MiFiUF12s_Mi
            #MiFiUR12s_Mi 
            #primerset
            #Ref: Miya M, Sato Y, Fukunaga T, Sado T, Poulsen JY, Sato K, Minamoto T, Yamamoto S, Yamanaka H, Araki H, Kondoh M, Iwasaki W. MiFish, a set of universal PCR primers for metabarcoding environmental DNA from fishes: detection of more than 230 subtropical marine species. R Soc Open Sci. 2015 Jul 22;2(7):150088. doi: 10.1098/rsos.150088. eCollection 2015 Jul. PubMed PMID: 26587265; PubMed Central  PMCID: PMC4632578.  
            # these primers amplify a fragment around 218 bp long
            # the length for this fragment needs to be shorter
            # the tags file is specific for the pcr
        	TAGSFNM="tags_AMRH_G_to_I_MifishU_pcr21.txt"
        	LNSICK="lsick <- 50"
        	QUSICK="qsick <- 2"
            FPF_V="fpfml <- 50"
    fi
    # check for J to L
	if [[ "$i" =~ "J" ]] || [[ "$i" =~ "K" ]] || [[ "$i" =~ "L" ]]
        then
            # the NGS metabarcode libraries G to I are prepared with the 
            #MiFiUF12s_Mi
            #MiFiUR12s_Mi 
            #primerset
            #Ref: Miya M, Sato Y, Fukunaga T, Sado T, Poulsen JY, Sato K, Minamoto T, Yamamoto S, Yamanaka H, Araki H, Kondoh M, Iwasaki W. MiFish, a set of universal PCR primers for metabarcoding environmental DNA from fishes: detection of more than 230 subtropical marine species. R Soc Open Sci. 2015 Jul 22;2(7):150088. doi: 10.1098/rsos.150088. eCollection 2015 Jul. PubMed PMID: 26587265; PubMed Central  PMCID: PMC4632578.  
            # these primers amplify a fragment around 218 bp long
            # the length for this fragment needs to be shorter
            # the tags file is specific for the pcr
            TAGSFNM="tags_AMRH_J_to_L_MifishU_pcr22.txt"
            LNSICK="lsick <- 50"
            QUSICK="qsick <- 2"
            FPF_V="fpfml <- 50"
    fi
	#make a variable to use for new directory names
	NWD=$(echo "AMRH_v4_"$i"L")
	# make a variable to get new library names
	NLNM=$(echo "AMRH_"$i"L")
	echo "$NLNM"
	#echo "$NWD"
	# remove any previous versions of the directories
	rm -rf "$NWD"
	rm -rf "$NWD".tar.gz
	# make a new version of the directories
	mkdir "$NWD"
	# change to the directory with the original files
	cd "$WD"/JMS_GL_v2
	# https://www.cyberciti.biz/faq/bash-loop-over-file/
	# loop over files in the "$WD"/JMS_GL_v2 directory
	for f in "$WD"/JMS_GL_v2/*
	do
		#_______________
		#https://stackoverflow.com/questions/48405940/script-to-loop-through-files-except-certain-files
		#if [ "$f" != "*.tar.gz" ]
		#https://stackoverflow.com/questions/18709962/regex-matching-in-a-bash-if-statement/18710850
		#if the file name does not contain 'tar.gz'
		
		if [[ ! $f =~ "tar.gz" ]]
    	then
    	# make a new file name, use semicolons to escape backslashes in variable
    	NF_WP=$(echo $f | sed "s/_JMS_GL/_$NLNM/g" | sed "s;$WD;;g" | sed "s;/JMS_GL_v2/;;g")
    	#echo $NF_WP
    	# write the contents of each file and replace with new library name throughout all files
    	#echo "$f"
        #echo "$NLNM"
    	cat "$f" | 
        # replace in a line with quotation marks, note how the other quotation marks are escaped
        # using backslashes
        sed "s;\"part04_blast_JMS_GL.results.01.txt\";\"part04_blast_$NLNM.results.01.txt\";g" |
        sed "s;JMS_GL;"$NLNM";g" > "$WD"/"$NWD"/"$NF_WP"
        # use the line below to check that the output is changed
        #cat "$WD"/"$NWD"/"$NF_WP" | grep inp_fn1 | grep part04
        fi
    	#_______________
    	#_______________
    	# check two conditions 'or' with double pipe
    	#https://unix.stackexchange.com/questions/47584/in-a-bash-script-using-the-conditional-or-in-an-if-statement
    	if [[ "$f" =~ ".r" ]] || [[ "$f" =~ ".sh" ]]
        then
        	# if condition matches then character modify the file
        	chmod 755 "$WD"/"$NWD"/"$NF_WP"
            #echo""
        #	
    	fi
    	#_______________
    	#_______________
    	# check if the file ends with list, if it does , then copy the batch file  into the new directory
    	if [[  "$f" =~ ".list" ]]
    	then
            #cat "$WD"/batch_file_AMRH_"$i"L.list
# the demltiplex part is extremely sensitive to whether 
            # the batch file is prepared correctly, so all the odd symbols needs to be removed
            # and only single spaces between the elements in the line must be present
            # the batchfile must end with a final unix-end-of-line, giving a total of 2 lines
            # including the line with the elements
            #copy the batch file
            cat "$WD"/batch_file_AMRH_"$i"L.list |
            #replace tabs with spaces, the part01 code cannot handle tabs in the batch file
            sed 's;\t; ;g' |
            # replace the odd characters
            # https://unix.stackexchange.com/questions/381230/how-can-i-remove-the-bom-from-a-utf-8-file
            LC_ALL=C sed 's/\xEF\xBB\xBF//g' |
            # replace the odd characters : https://superuser.com/questions/207207/how-can-i-delete-u200b-zero-width-space-using-sed
            LC_ALL=C sed 's/\xe2\x80\x8b//g' |
            # replace end of line with 3 semicolons
            sed ':a;N;$!ba;s/\n/;;;/g' |
            #replace semi colon with end of line
            sed 's/;;;//g' |
            #replace tabs with spaces, the part01 code cannot handle tabs in the batch file
            sed 's;\t;    ;g' > "$WD"/"$NWD"/"$NF_WP"

    	fi
    	#_______________
    	#_______________
    	# check if the file has tags in  the file name, if it does , then copy the tags file into the new directory
    	if [[  "$f" =~ "tags" ]]
    	then
            #echo "$f"
    		# copy the tags file
    		cp "$WD"/"$TAGSFNM" "$WD"/"$NWD"/"$NF_WP"
    		#echo "tags"
    	fi
    	#_______________
    	#_______________
    	# check if the file  has 'part02_dada2_sickle_v2_start_swk' in  the file names, if it does , 
    	#then modify the file and copy  into the new directory
    	if [[  "$f" =~ "part02_dada2_sickle_v2_start_swk" ]]
    	then
    		#modify the 'part02_dada2_sickle' file for length and quality in sickle
    		# the A to D library with teleo primer set contains smaller fragments and the 'lsick'
    		# lenght needs to be shorter
    		cat "$f" | 
            #replace the seq length for sickle
            sed "s;lsick <- 100;$LNSICK;g" | 
            #replace the seq quality  for sickle
            sed "s;qsick <- 28;$QUSICK;g" |
            #replace the min lenght for the 'fastqPairedFilter' function
            sed "s;fpfml <- 100;$FPF_V;g" > "$WD"/"$NWD"/"$NF_WP"
    	fi
    	#_______________

        #_______________
        # check if the file has 'part03_DADA2_end_190702' in  the file names, if it does , 
        #then modify the file and copy  into the new directory
        if [[  "$f" =~ "part03_DADA2_end_190702" ]]
        then
            #modify the 'part03_DADA2_end_190702' file 
            # to make it call on the correct directory for input files on the remote directory
            cat "$f" | sed "s;JMS_GL_v2;AMRH_v4/AMRH_v4_"$i"L;g" > "$WD"/"$NWD"/"$NF_WP"
        fi
        #_______________
        #_______________
        if [[  "$f" =~ "part05_limit_BLAST_results_before_taxonomyB" ]]
        then
            #modify the '"part05_limit_BLAST_results_before_taxonomyB"' file 
            # to make it call on the correct  input files for delimiting BLAST hits
            cat "$f" | 
            #replace the filename for the blast results -  i.e. comment out the wrong blast results
            sed "s;#inp_fn1 <- \"part04_blast_result_AMRH_AL.results.01.txt;inp_fn1 <- \"part04_blast_AMRH_"$i"L.results.01.txt;g" |
            
            #part04_blast_result_AMRH_AL.results.01.txt - filename requested by R code
            #part04_blast_AMRH_AL.results.01.txt - filename in directory after part04
            #replace the filename for the blast results -  i.e. comment out the wrong blast results
            sed "s;inp_fn1 <- \"part04_blast_JMS;#inp_fn1 <- \"part04_blast_JMS;g" |
            #replace outputfiles name
            sed "s;outputfilenm1=\"part05_blast_JMS_GL;outputfilenm1=\"part05_blast_AMRH_"$i"L;g" |
            # use sed to change the line that is a comment
            sed "s;#inp_fn2 <- \"part05_lst_species_of_fish_birds_mammals_in_aamosen_and_mock01.txt\";inp_fn2 <- \"part05_lst_species_of_fish_birds_mammals_in_aamosen_and_mock01.txt\";g" |
            # use sed to change the line that is active, and make it a comment
            sed "s;inp_fn2 <- \"part05_lst_species_of_fish_birds_mammals_in_Kenya_and_mock01.txt\";#inp_fn2 <- \"part05_lst_species_of_fish_birds_mammals_in_Kenya_and_mock01.txt\";g" > "$WD"/"$NWD"/"$NF_WP"
        fi
        #_______________
        if [[ "$f" =~ "part06_my_taxonomy_B" ]]
        then
            cat $f |
            #replace the input file called for in the R code
            sed "s;part05_blast_JMS_GL;part05_blast_AMRH_"$i"L;g" | 
            ##replace the input file name called for
            sed "s;IDtable <- read.csv(file = inputfilenm1,;IDtable <- read.csv(file = inputfilenm2,;g" |
            #replace output file name
            sed "s;part06_my_classified_otus_JMS_GL.01.unfilt_BLAST_results.txt;part06_my_classified_otus_AMRH_"$i"L.01.unfilt_BLAST_results.txt;g" |
            sed "s;part06_my_classified_otus_JMS_GL.02.filt_BLAST_results.txt;part06_my_classified_otus_AMRH_"$i"L.02.filt_BLAST_results.txt;g" > "$WD"/"$NWD"/"$NF_WP"
            #part06_my_classified_otus_JMS_GL.02.filt_BLAST_results.txt
            #part06_my_classified_otus_AMRH_BL.01.unfilt_BLAST_results.txt
            
        fi
        #_______________
        
    done
    cd "$WD"/"$NWD"
    #compress files for individual code parts
    #tar -zcf part01_"$NLNM".tar.gz part01_*
    #tar -zcf part02_"$NLNM".tar.gz part02_*
    #tar -zcf part03_"$NLNM".tar.gz part03_*
    #tar -zcf part05_"$NLNM".tar.gz part05_*
    #tar -zcf part06_"$NLNM".tar.gz part06_*
    #tar -zcf part07_"$NLNM".tar.gz part07_*
    # secure copy the compressed files to the remote target directory
    #scp part01_"$NLNM".tar.gz phq599@fend01.hpc.ku.dk:"$RTD"/.
    cd "$WD"
    #compress files 
    tar zcf "$NWD".tar.gz "$NWD"
    # secure copy the compressed files to the remote target directory
    scp "$NWD".tar.gz phq599@fend01.hpc.ku.dk:"$RTD"/.
done
cd "$WD"
    #also secure copy the bash file needed to start the bash files remotely
    scp bash03_sbatch_in_tmux_part01_to07_AMRH_AL_to_LL_v01.sh phq599@fend01.hpc.ku.dk:"$RTD"/.

cd "$WD"/AMRH_v4_AL
#cd "$WD"
#ls -lh
#cat part05_limit_BLAST_results_before_taxonomyB* | grep inp #| head -100 | cut -c1-100
#echo ""
#cat part03* | grep JMS