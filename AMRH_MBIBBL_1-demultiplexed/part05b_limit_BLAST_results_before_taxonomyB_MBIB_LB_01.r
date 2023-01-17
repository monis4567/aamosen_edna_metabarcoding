#!/usr/bin/env Rscript
# -*- coding: utf-8 -*-

# Modify BLAST results before using the taxonomy_B R script

# put directory path in variable
my_wd <- "/home/hal9000/metabarcode_example/AMRH_MBIBBL_1-demultiplexed"
#set working directory
setwd(my_wd)
#prints current working directory to screen
getwd()
# define the input file names
# the raw blast results obtained
inp_fn1 <- "part04_blast_result_AMRH_MBIB_BL.results.01.txt"
# the list of species being present in the geographical area, including mock species
inp_fn2 <- "lst_species_of_fish_birds_mammals_in_aamosen_and_mock01.tx"
#define a filename to write out to
outputfilenm1="part05b_blast_result_AMRH_MBIB_BL.results.02.txt"

  ###Get packages
  #install.packages("dplyr")
  #install.packages("cowplot")
  
  #install.packages("ggpubr")
  if(!require(ggpubr)){
    install.packages("ggpubr")
    library(ggpubr)
  }
library(ggpubr)

#install.packages("ggplot2")
#install.packages("reshape2")
library(ggplot2)
library(reshape2)
library(ggpubr)

#Read in file to  columns seperated by tab into data frame
raw_blast_results <- read.table(file=inp_fn1,sep='\t',header=F)
# check the first 4 rows of this data frame
head(raw_blast_results, 4)
#Read in file to  columns seperated by space into data frame
lst_posibl_spc <- read.delim(file=inp_fn2,sep=' ',header=F)
# check the first 4 rows of this data frame
head(lst_posibl_spc, 4)
#change the header of the column names
colnames(lst_posibl_spc) <- c("genus","species")
#merge the two columns and make a new column for this
lst_posibl_spc$genus_species <- paste(lst_posibl_spc$genus, lst_posibl_spc$species)
#rename a single specific column
names(raw_blast_results)[names(raw_blast_results) == 'V17'] <- 'genus_species_nm'
names(raw_blast_results)[names(raw_blast_results) == 'V2'] <- 'acc_no'
names(raw_blast_results)[names(raw_blast_results) == 'V1'] <- 'nochimseq_no'
names(raw_blast_results)[names(raw_blast_results) == 'V11'] <- 'e_val'
names(raw_blast_results)[names(raw_blast_results) == 'V16'] <- 'nt_seq'
head(raw_blast_results, 4)
#get unique species names from column with genus_species_nm
unq_genus_spec_nm <- unique(raw_blast_results$genus_species_nm)
#count the number of elements in this variable
length(unq_genus_spec_nm)
#see the first 3 elements in this list
head(unq_genus_spec_nm,3)
#grep for elements in this list that starts with A
genus_spc_nms_start_w_A <- grep("^A", unq_genus_spec_nm, value=T)
#grep for elements in this list that starts with H
genus_spc_nms_start_w_H <- grep("^H", unq_genus_spec_nm, value=T)
#assign the column from the data frame to a variable
lst_poss_scp <- lst_posibl_spc$genus_species
# remove from the data frame based on a list -  see this website: https://stackoverflow.com/questions/13012509/how-to-delete-rows-from-a-data-frame-based-on-an-external-list-using-r
raw_blast_results02 <- raw_blast_results[  raw_blast_results$genus_species_nm %in% lst_poss_scp, ]
#get unique species names from column with genus_species_nm
unq_genus_spec_nm02 <- unique(raw_blast_results02$genus_species_nm)
#count the number of elements in this variable
length(unq_genus_spec_nm02)
#see header 4 rows of the limited blast results
head(raw_blast_results02,4)
#write a file with possibel species names
write.table(raw_blast_results02, outputfilenm1, 
            quote=F, append = FALSE, sep = "\t", dec = ".",
            row.names = F, col.names = F)



#
