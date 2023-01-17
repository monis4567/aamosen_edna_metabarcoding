
#################################################################################
#
# Code developed for analysis of metabarcode NGS data
# obtained with NGS
# 
# code prepared by Johan M Sørensen, Anne Marie Rubæk Holm and Steen Wilhelm Knudsen
# in Jan-2020 at the Zoological Museum of Copenhagen

# With the aim of producing stacked bar plots as
# what is presented in these studies:
# Fig. 4 , in Thomsen et al. 2016. PlosOne.   ( https://doi.org/10.1371/journal.pone.0165252)
# Fig. 2 in Li et al., 2019. (DOI: 10.1111/1365-2664.13352.)
# Fig. 4. in Guenther et al. 2018. Sci Reports. (2018) 8:14822 (DOI:10.1038/s41598-018-32917-x.)

# This code has been tested in this version of R:
# > R.Version()
#$platform
#[1] "x86_64-pc-linux-gnu"
#
#$arch
#[1] "x86_64"
#
#$os
#[1] "linux-gnu"
#
#$system
#[1] "x86_64, linux-gnu"
#
#$status
#[1] ""
#
#$major
#[1] "3"
#
#$minor
#[1] "5.2"
#
#$year
#[1] "2018"
#
#$month
#[1] "12"
#
#$day
#[1] "20"
#
#$`svn rev`
#[1] "75870"
#
#$language
#[1] "R"
#
#$version.string
#[1] "R version 3.5.2 (2018-12-20)"
#
#$nickname
#[1] "Eggshell Igloo"


#https://www.r-graph-gallery.com/all-graphs.html


# put directory path in variable
my_wd <- "/home/hal9000/metabarcode_example/AMRH_MBIBGL_1-demultiplexed"
#set working directory
setwd(my_wd)
#prints current working directory to screen
getwd()
# define the input file names
inp_fn1 <- "part03_output_DADA2_nochim.table.AMRH_MBIB_GL.txt"
inp_fn2 <- "part05_output_my_classified_otus_AMRH_MBIB_GL.results.01.txt"

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

#turn .table file with columns seperated by tab into table
nochim_table <- read.table(file=inp_fn1,sep='\t',header=T)

#read in the result from the taxonomyB_R code
df_blast_result <- read.table(file=inp_fn2,sep='\t',header=T)
# see the first 4 header lines
head(df_blast_result,3)
#see what the columns are named
colnames(df_blast_result)
#assign some of the columns to objects
blast_r_seqID <- df_blast_result$qseqid
blast_r_class <- df_blast_result[,11] #class
blast_r_order <- df_blast_result[,12] #order
blast_r_fam <- df_blast_result[,13] #family
blast_r_genus <- df_blast_result[,14] #genus
blast_r_genus_species <- df_blast_result[,15] #genus_species
#convert data frame from a "wide" format to a "long" format
nochim_table_melt <- melt(nochim_table, id = c("X"))

head(nochim_table_melt,4)
#match between data frames
nochim_table_melt$blast_r_class <- df_blast_result[,11][match(nochim_table_melt$X,df_blast_result$qseqid)]
nochim_table_melt$blast_r_order <- df_blast_result[,12][match(nochim_table_melt$X,df_blast_result$qseqid)]
nochim_table_melt$blast_r_fam <- df_blast_result[,13][match(nochim_table_melt$X,df_blast_result$qseqid)]
nochim_table_melt$blast_r_genus <- df_blast_result[,14][match(nochim_table_melt$X,df_blast_result$qseqid)]
nochim_table_melt$blast_r_genus_species <- df_blast_result[,15][match(nochim_table_melt$X,df_blast_result$qseqid)]
#keep the order of your samples the same as in the table. Otherwise, R will order variables alphabetically.
nochim_table_melt$X <- factor(nochim_table_melt$X,levels=unique(nochim_table_melt$X))

#create 100% stacked bar plot with sample on the x-axis
Stacked_bar_plot_per_seq <- ggplot(data = nochim_table_melt, aes(x = variable, y = value, fill = X)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences")
#theme(axis.text.x = element_text(angle = 90, hjust = 1)) #uncomment to angle x-axis labels 90 degrees
print(Stacked_bar_plot_per_seq)


#create 100% stacked bar plot with sample on the x-axis  - divided by genus_species
Stacked_bar_plot_per_genusspecies <- ggplot(data = nochim_table_melt, aes(x = variable, y = value, fill = blast_r_genus_species)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences")
#theme(axis.text.x = element_text(angle = 90, hjust = 1)) #uncomment to angle x-axis labels 90 degrees
print(Stacked_bar_plot_per_genusspecies)

#create 100% stacked bar plot with sample on the x-axis  - divided by genus
Stacked_bar_plot_per_genus <- ggplot(data = nochim_table_melt, aes(x = variable, y = value, fill = blast_r_genus)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences")
#theme(axis.text.x = element_text(angle = 90, hjust = 1)) #uncomment to angle x-axis labels 90 degrees
print(Stacked_bar_plot_per_genus)

#create 100% stacked bar plot with sample on the x-axis  - divided by family
Stacked_bar_plot_per_fam <- ggplot(data = nochim_table_melt, aes(x = variable, y = value, fill = blast_r_fam)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences")
#theme(axis.text.x = element_text(angle = 90, hjust = 1)) #uncomment to angle x-axis labels 90 degrees
print(Stacked_bar_plot_per_fam)

#create 100% stacked bar plot with sample on the x-axis  - divided by order
Stacked_bar_plot_per_order <- ggplot(data = nochim_table_melt, aes(x = variable, y = value, fill = blast_r_order)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences")
#theme(axis.text.x = element_text(angle = 90, hjust = 1)) #uncomment to angle x-axis labels 90 degrees
print(Stacked_bar_plot_per_order)

#create 100% stacked bar plot with sample on the x-axis - divided by class
Stacked_bar_plot_per_class <- ggplot(data = nochim_table_melt, aes(x = variable, y = value, fill = blast_r_class)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences")
#theme(axis.text.x = element_text(angle = 90, hjust = 1)) #uncomment to angle x-axis labels 90 degrees
print(Stacked_bar_plot_per_class)

#turns bar plot horizontal
Stacked_bar_plot <- Stacked_bar_plot + coord_flip()

#create 100% stacked bar plot with seqN on the x-axis
Stacked_bar_plot2 <- ggplot(data = nochim_table_melt, aes(x = X, y = value, fill = variable)) +
  geom_bar(position="fill", stat="identity", color="white") + #Get same result with geom_col(position="fill", color="white") + #
  labs(x = "Sequence", y = "Proportion of reads/sample", fill = "Sequences") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#change color palette
#library(viridis)

tol18rainbow <- c("#771155", "#AA4488", "#CC99BB", "#114477",
                  "#4477AA", "#77AADD", "#117777", "#44AAAA",
                  "#77CCCC", "#777711", "#AAAA44", "#DDDD77",
                  "#774411", "#AA7744", "#DDAA77", "#771122",
                  "#AA4455", "#DD7788")

Stacked_bar_plot2 <- Stacked_bar_plot2 +
  #scale_fill_viridis(discrete = T, option="plasma")
  scale_fill_manual(values=tol18rainbow)

#jeg har prøvet at tilføje værdier skrevet direkte på søjlerne, men når jeg gør det forsvinder søjlerne og kun værdier er tilbage
###Figure1 <- Figure + geom_text(aes(label=value),stat="identity",position=position_dodge(0.5))

##gather bar plots in one figure
figure <- ggarrange(Stacked_bar_plot, Stacked_bar_plot2, labels = c("A", "B"), ncol = 1, nrow = 2)

##print results
#print(Stacked_bar_plot)
#print(Stacked_bar_plot2)
#print(figure)

# make a sequence of capital letters
subfiglt <- LETTERS[seq( from = 1, to = 4 )]
##gather 5 bar plots in one figure
figure <- ggarrange(Stacked_bar_plot_per_genus,
                    Stacked_bar_plot_per_fam,
                    Stacked_bar_plot_per_order,
                    Stacked_bar_plot_per_class,
                    labels = c(subfiglt), 
                    ncol = 2, nrow = 2)

#substitute on the input file name
filn01 <- gsub("part05_output_","",inp_fn2)
filn02 <- gsub("01.txt","",filn01)
#paste together a new filename
plot.nm3 <- paste("part06_output_plot_on_",filn02,"01", sep="")
#print the plot in a pdf - open a pdf file
pdf(c(paste(plot.nm3,".pdf",  sep = ""))
    #set size of plot
    ,width=(1*8.2677),height=(3*2.9232))
#add the plot to the pdf
print(figure)
#close the pdf file again
dev.off()



#

################################################
#Pie charts and more
################################################

#pie_chart <- Stacked_bar_plot2 + coord_polar("x", start=0)

#print(pie_chart)

######
