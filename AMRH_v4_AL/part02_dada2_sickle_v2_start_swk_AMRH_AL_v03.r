#!/usr/bin/env Rscript
# -*- coding: utf-8 -*-

#specify a path to where you have all your packages on your remote node
# NOTICE ! In order to have your packages available on the remote path, you will need to logon to your node, and make a directory 
# called -e.g. : R_packages_for_Rv3_4
# Then load the R module
# module load R/v3.4.3
# Then start R byt typing:
# R
# Once R is started run the lines here below in section 01
#_______________start section 01__________________________________________ 
# replace my library path to your own library path
#lib_path01 <- "/groups/hologenomics/johanms/R_packages_for_Rv3_4"
lib_path01 <- "/groups/hologenomics/phq599/data/R_packages_for_Rv3_4"
Sys.setenv(R_LIBS_USER="lib_path01")
.libPaths("lib_path01")
# change the path to where the packages should be installed from # see this website: https://stackoverflow.com/questions/15170399/change-r-default-library-path-using-libpaths-in-rprofile-site-fails-to-work
.libPaths( c( lib_path01 , .libPaths() ) )
.libPaths()
#_______________end section 01__________________________________________
## You  will need to specify this path again later on when you are to run this R-script
## Before you can start this R-script on the remote server you will need to install the pacakges here

## in section 02 here below 
## installing these packages is commented out, as they are not needed when you are to run this R-script
## But I have left them here in section 02 to be used when you install them the first time in your local 
## path
## Before you can install these package you will need the 'RCurl' pakcage being available for R
## On the HPC UCPH server 'RCurl' is installed here:  "libcurl-devel" on fend05
## Here is a wbepage with guide to get 'RCurl' installed: https://github.com/sagemath/cloud/issues/114
## Users of this R-script on HPC UCPH - Note that this 'RCurl' is already installed. So HPC users can just 
## proceed and run the lines in section 02 here below
 
#_______________start section 02__________________________________________ 

## Run lines below with only 1 # sign. The other lines with 2 # signs are helpful comments.
#install.packages(c("lessR"))
#install.packages(c("readr"))
#install.packages(c("dada2"))
#install.packages(c("dada2", "readr", "dplyr", "taxize", "tidyr"))

## Having difficulties getting the 'dada2' package installed on the remote path
## tried looking for solutions 
## I then looked up the 'dada2' package for R on the internet here:
## https://www.bioconductor.org/packages/release/bioc/html/dada2.html
## and this webpage recommended that I ran these two commands

#if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
#BiocManager::install("dada2")

## This should get your 'dada2' package installed
## Check that R finishes without errors on packages 
## Now quit R 
#_______________end section 02__________________________________________ 
## Now that you have installed all packages in your remote path : "/groups/hologenomics/johanms/R_packages_for_Rv3_4"
## You should now be able to run this present R-script by submitting it with the 'run_sickle_sbatch_swk.sh' script
## Place both this code 'dada2_sickle_v2_swk.r' and the 'run_sickle_sbatch_swk.sh' script in the directory: 
## /groups/hologenomics/johanms/ES_metabarcode_example/Metabarcoding_pipeline/1-demultiplexed-filtered/E16L
## change this directory to match your own directory
## Once these 2 scripts are placed in the directory you can slurm submit the 'run_sickle_sbatch_swk.sh' 
## navigate in to the directory : /groups/hologenomics/johanms/ES_metabarcode_example/Metabarcoding_pipeline/1-demultiplexed-filtered/E16L
## submit the script with
# sbatch run_sickle_sbatch_swk.sh


appendix <- "x"

#the command 'require()''  will get the package and install it, and it will obtain the package from the
# path you have specified in '.libPaths()' above 
require(dada2)
require(readr)
require(dplyr)

pwd <- getwd()
setwd(pwd)
main_path <- pwd

start.time <- Sys.time()

# define path to a local copied version of sickle
local_path_to_sickle <- paste0(main_path,"/sickle-master/sickle")

#set min length for the 'fastqPairedFilter' function
fpfml <- 10
#set length for sickle
lsick <- 10
#set quality for sickle
qsick <- 2
#set maxEE value for the 'fastqPairedFilter' function
mxEEval=2
#Filtering the "Sense"-reads.
path <- file.path(main_path, "DADA2_SS")
fns <- list.files(path)
fastqs <- fns[grepl("fastq$", fns)]
fastqs <- sort(fastqs)
fnFs <- fastqs[grepl("_R1.", fastqs)]
fnRs <- fastqs[grepl("_R2.", fastqs)]
sample.names <- sapply(strsplit(fnFs, "_R1"), `[`, 1)
fnFs <- file.path(path, fnFs)
fnRs <- file.path(path, fnRs)
match_path <- file.path(path, "filtered")
if(!file_test("-d", match_path)) dir.create(match_path)
filtFs <- file.path(match_path, paste0(sample.names, "_F_filtered.fastq"))
filtRs <- file.path(match_path, paste0(sample.names, "_R_filtered.fastq"))
singles <- file.path(match_path, paste0(sample.names, "_singles.fastq"))
print('Block 1 done')

#commandX <- paste0("/faststorage/project/eDNA/Metabarcoding_pipeline/sickle-master/sickle pe -l 50 -q 28 -x -f -t sanger ",file.path(fnFs[i])," -r ",fnRs[i]," -o ",filtFs[i]," -p ",filtRs[i])

for(i in seq_along(fnFs)) {
 if (file.info(fnFs[i])$size == 0) {
  print(paste(fnFs[i], "empty.")) } else {
   print(paste("processing", fnFs[i]))
   #commandX <- paste0("/home/evaes/miniconda3/envs/vandloeb/lib/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnFs[i]," -o ",filtFs[i])
   #commandX <- paste0("/groups/hologenomics/johanms/NGSmetabarcode15112019/metabarcode_pipeline/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnFs[i]," -o ",filtFs[i])
   commandX <- paste0(local_path_to_sickle," se -l ",lsick," -q ",qsick," -x -t sanger -f ",fnFs[i]," -o ",filtFs[i])
   #commandY <- paste0("/home/evaes/miniconda3/envs/vandloeb/lib/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnRs[i]," -o ",filtRs[i])
   #commandY <- paste0("/groups/hologenomics/johanms/NGSmetabarcode15112019/metabarcode_pipeline/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnRs[i]," -o ",filtRs[i])
   commandY <- paste0(local_path_to_sickle," se -l ",lsick," -q ",qsick," -x -t sanger -f ",fnRs[i]," -o ",filtRs[i])
   print(commandX)
   system(commandX)
   print(commandY)
   system(commandY)
  }
}
print('Block 2 done')


#Filtering the "Anti-Sense"-reads.
path <- file.path(main_path, "DADA2_AS")
fns <- list.files(path)
fastqs <- fns[grepl("fastq$", fns)]
fastqs <- sort(fastqs)
fnFs <- fastqs[grepl("_R2.", fastqs)] # Reverse direction compared to above for the "sense reads". In practice the reads are here complement reversed to be in the same orientation as the "sense" reads.
fnRs <- fastqs[grepl("_R1.", fastqs)] # See above
sample.names <- sapply(strsplit(fnFs, "_R2"), `[`, 1)
fnFs <- file.path(path, fnFs)
fnRs <- file.path(path, fnRs)
match_path <- file.path(path, "filtered")
if(!file_test("-d", match_path)) dir.create(match_path)
filtFs <- file.path(match_path, paste0(sample.names, "_F_filtered.fastq"))
filtRs <- file.path(match_path, paste0(sample.names, "_R_filtered.fastq"))
singles <- file.path(match_path, paste0(sample.names, "_singles.fastq"))
for(i in seq_along(fnFs)) {
 if (file.info(fnFs[i])$size == 0) {
  print(paste(fnFs[i], "empty.")) } else {
   print(paste("processing", fnFs[i]))
   #commandX <- paste0("/home/evaes/miniconda3/envs/vandloeb/lib/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnFs[i]," -o ",filtFs[i])
   #commandX <- paste0("/groups/hologenomics/johanms/NGSmetabarcode15112019/metabarcode_pipeline/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnFs[i]," -o ",filtFs[i])
   commandX <- paste0(local_path_to_sickle," se -l ",lsick," -q ",qsick," -x -t sanger -f ",fnFs[i]," -o ",filtFs[i])
   #commandY <- paste0("/home/evaes/miniconda3/envs/vandloeb/lib/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnRs[i]," -o ",filtRs[i])
   #commandY <- paste0("/groups/hologenomics/johanms/NGSmetabarcode15112019/metabarcode_pipeline/sickle-master/sickle se -l 100 -q 28 -x -t sanger -f ",fnRs[i]," -o ",filtRs[i])
   commandY <- paste0(local_path_to_sickle," se -l ",lsick," -q ",qsick,"-x -t sanger -f ",fnRs[i]," -o ",filtRs[i])
   print(commandX)
   system(commandX)
   print(commandY)
   system(commandY)
   }
}
print('Block 3 done')


#Matching the "Sense"-reads.
path <- file.path(main_path, "DADA2_SS/filtered")
fns <- list.files(path)
fastqs <- fns[grepl("fastq$", fns)]
fastqs <- sort(fastqs)
fnFs <- fastqs[grepl("_F_", fastqs)]
fnRs <- fastqs[grepl("_R_", fastqs)]
sample.names <- sapply(strsplit(fnFs, "_F_"), `[`, 1)
fnFs <- file.path(path, fnFs)
fnRs <- file.path(path, fnRs)
match_path <- file.path(path, "matched")
if(!file_test("-d", match_path)) dir.create(match_path)
filtFs <- file.path(match_path, paste0(sample.names, "_F_matched.fastq.gz"))
filtRs <- file.path(match_path, paste0(sample.names, "_R_matched.fastq.gz"))
for(i in seq_along(fnFs)) {
 if (file.info(fnFs[i])$size == 0) {
  print(paste(fnFs[i], "empty.")) } else {
   print(paste("processing", fnFs[i]))
   fastqPairedFilter(c(fnFs[i], fnRs[i]), c(filtFs[i], filtRs[i]), minLen=fpfml, maxN=0, maxEE=mxEEval, truncQ=2,
                     matchIDs=TRUE)
  }
}
print('Block 4 done')


#Matching the "Anti-Sense"-reads.
path <- file.path(main_path, "DADA2_AS/filtered")
fns <- list.files(path)
fastqs <- fns[grepl("fastq$", fns)]
fastqs <- sort(fastqs)
fnFs <- fastqs[grepl("_F_", fastqs)] # Reverse direction compared to above for the "sense reads". In practice the reads are here complement reversed to be in the same orientation as the "sense" reads.
fnRs <- fastqs[grepl("_R_", fastqs)] # See above
sample.names <- sapply(strsplit(fnFs, "_F_"), `[`, 1)
fnFs <- file.path(path, fnFs)
fnRs <- file.path(path, fnRs)
match_path <- file.path(path, "matched")
if(!file_test("-d", match_path)) dir.create(match_path)
filtFs <- file.path(match_path, paste0(sample.names, "_F_matched.fastq.gz"))
filtRs <- file.path(match_path, paste0(sample.names, "_R_matched.fastq.gz"))
for(i in seq_along(fnFs)) {
 if (file.info(fnFs[i])$size == 0) {
  print(paste(fnFs[i], "empty.")) } else {
   print(paste("processing", fnFs[i]))
   fastqPairedFilter(c(fnFs[i], fnRs[i]), c(filtFs[i], filtRs[i]),minLen=fpfml, maxN=0, maxEE=mxEEval, truncQ=2,
                     matchIDs=TRUE)
  }
}
print('Block 5 done')


#Processing the set of files containing the forward primer in the R1 reads (the sense reads):
filt_path <- file.path(main_path, "DADA2_SS/filtered/matched") 
fns <- list.files(filt_path)
fastqs <- fns[grepl(".fastq.gz", fns)]
fastqs <- sort(fastqs)
fnFs <- fastqs[grepl("_F_", fastqs)]
fnRs <- fastqs[grepl("_R_", fastqs)]
SSsample.names <- sapply(strsplit(fnFs, "_F_"), `[`, 1)
filtFs <- file.path(filt_path, fnFs)
filtRs <- file.path(filt_path, fnRs)
errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)
derepFs <- derepFastq(filtFs, verbose=TRUE)
derepRs <- derepFastq(filtRs, verbose=TRUE)
names(derepFs) <- SSsample.names
names(derepRs) <- SSsample.names
SSdadaFs <- dada(derepFs, err=errF, multithread = TRUE)
SSdadaRs <- dada(derepRs, err=errR, multithread = TRUE)
SSmergers <- mergePairs(SSdadaFs, derepFs, SSdadaRs, derepRs, verbose=TRUE,minOverlap = 5)
seqtab_SS <- makeSequenceTable(SSmergers[names(SSmergers)])
seqtab.nochim_SS <- removeBimeraDenovo(seqtab_SS, verbose=TRUE)
stSS <- file.path(main_path,"seqtab_SS_RDS")
stnsSS <- file.path(main_path,"seqtab.nochim_SS_RDS")
saveRDS(seqtab_SS,stSS)
saveRDS(seqtab.nochim_SS,stnsSS)
print('Block 6 done')


#Then DADA2 processing of "the antisense" reads:
filt_path <- file.path(main_path, "DADA2_AS/filtered/matched") 
fns <- list.files(filt_path)
fastqs <- fns[grepl(".fastq.gz", fns)]
fastqs <- sort(fastqs)
fnFs <- fastqs[grepl("_F_", fastqs)]
fnRs <- fastqs[grepl("_R_", fastqs)]
ASsample.names <- sapply(strsplit(fnFs, "_F_"), `[`, 1)
filtFs <- file.path(filt_path, fnFs)
filtRs <- file.path(filt_path, fnRs)
errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)
derepFs <- derepFastq(filtFs, verbose=TRUE)
derepRs <- derepFastq(filtRs, verbose=TRUE)
names(derepFs) <- ASsample.names
names(derepRs) <- ASsample.names
ASdadaFs <- dada(derepFs, err=errF, multithread = TRUE)
ASdadaRs <- dada(derepRs, err=errR, multithread = TRUE)
ASmergers <- mergePairs(ASdadaFs, derepFs, ASdadaRs, derepRs, verbose=TRUE,minOverlap = 5)
seqtab_AS <- makeSequenceTable(ASmergers[names(ASmergers)])
seqtab.nochim_AS <- removeBimeraDenovo(seqtab_AS, verbose=TRUE)
stAS <- file.path(main_path,"seqtab_AS_RDS")
stnsAS <- file.path(main_path,"seqtab.nochim_AS_RDS")
saveRDS(seqtab_AS,stAS)
saveRDS(seqtab.nochim_AS,stnsAS)
print('Block 7 done')
