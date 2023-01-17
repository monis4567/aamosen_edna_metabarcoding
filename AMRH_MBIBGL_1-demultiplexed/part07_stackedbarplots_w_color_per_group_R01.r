#


my_wd <- "/home/hal9000/metabarcode_example/AMRH_MBIBCL_1-demultiplexed"
#set working directory
setwd(my_wd)
#prints current working directory to screen
getwd()
# define the input file names
inp_fn1 <- "part03_output_DADA2_nochim.table.AMRH_MBIB_CL.txt"
#inp_fn2 <- "part05_output_my_classified_otus_AMRH_MBIB_CL.results.01.txt"
inp_fn2 <- "part05_my_classified_otus_AMRH_MBIB_CL.results.01.txt"
inp_fn2 <- "part05_my_classified_otus_AMRH_MBIB_CL.results.02.txt"
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



#https://stackoverflow.com/questions/15282580/how-to-generate-a-number-of-most-distinctive-colors-in-r
library(randomcoloR)
#make a color palette for the unique elements
pal01 <- distinctColorPalette(ll01)
#see the colors in a pie
pie(rep(1,ll01), col=sample(pal01, ll01))
#assign color to coloumn in df matching the columns the colors were based on
e01_df$cg01 <- c(pal01)[e01_df$a12]
#install.packages("viridis")
library(viridis)
pal02<-viridis_pal(option = "D")(ll01)
#see the colors in a pie
pie(rep(1,ll01), col=sample(pal02, ll01))
#assign color to coloumn in df matching the columns the colors were based on
e01_df$cg01 <- c(pal02)[e01_df$a12]
#make fractions for each category based the table, divide with the total number per category
fr01 <- seq(1:((table(e01_df$a12)[1])+1))/(table(e01_df$a12)[1]+1)
fr02 <- seq(1:((table(e01_df$a12)[2])+1))/(table(e01_df$a12)[2]+1)
fr03 <- seq(1:((table(e01_df$a12)[3])+1))/(table(e01_df$a12)[3]+1)
fr04 <- seq(1:((table(e01_df$a12)[4])+1))/(table(e01_df$a12)[4]+1)
fr05 <- seq(1:((table(e01_df$a12)[5])+1))/(table(e01_df$a12)[5]+1)
#remove the last element from the list
fr01 <-  fr01[seq(1:(length(fr01)-1))]
fr02 <-  fr01[seq(1:(length(fr02)-1))]
fr03 <-  fr01[seq(1:(length(fr03)-1))]
fr04 <-  fr01[seq(1:(length(fr04)-1))]
fr05 <-  fr01[seq(1:(length(fr05)-1))]
#append back to dataframe
e01_df$frcol<- c(fr01,fr02,fr03,fr04,fr05)
#get color for each category
cA <- unique(e01_df$cg01)[unique(e01_df$a12)[1]]
cB <- unique(e01_df$cg01)[unique(e01_df$a12)[2]]
cC <- unique(e01_df$cg01)[unique(e01_df$a12)[3]]
cD <- unique(e01_df$cg01)[unique(e01_df$a12)[4]]
cE <- unique(e01_df$cg01)[unique(e01_df$a12)[5]]
#https://stackoverflow.com/questions/22255465/assign-colors-to-a-range-of-values
## Use n equally spaced breaks to assign each value to n-1 equal sized bins
# set max to 1 to avoid getting a black  colour in the last colour step
iiA <- cut(fr01, breaks = seq(min(fr01), max(1), len = 100),
           include.lowest = TRUE)
iiB <- cut(fr02, breaks = seq(min(fr02), max(1), len = 100),
           include.lowest = TRUE)
iiC <- cut(fr03, breaks = seq(min(fr03), max(1), len = 100),
           include.lowest = TRUE)
iiD <- cut(fr04, breaks = seq(min(fr04), max(1), len = 100),
           include.lowest = TRUE)
iiE <- cut(fr05, breaks = seq(min(fr05), max(1), len = 100),
           include.lowest = TRUE)
## Use bin indices, ii, to select color from vector of n-1 equally
## spaced colors
cA2 <- colorRampPalette(c(cA,"white"))(99)[iiA]
cB2 <- colorRampPalette(c(cB,"black"))(99)[iiB]
cC2 <- colorRampPalette(c(cC,"black"))(99)[iiC]
cD2 <- colorRampPalette(c(cD,"black"))(99)[iiD]
cE2 <- colorRampPalette(c(cE,"black"))(99)[iiE]
#append back to dataframe
e01_df$c2col<- c(cA2,cB2,cC2,cD2,cE2)
e01_df
########################################################################
pie(rep(1,length(unique(fr01))), col=sample(cA2, length(unique(fr01))))
#http://hughjonesd.github.io/tweaking-colours-with-the-shades-package.html
########################################################################
#define the columns to keep
keeps <- c("a11",
           "a09",
           "a10")
#keep only selected columns
e02_df <- e01_df[keeps]
#define the columns to keep
keeps <- c("a11",
           "a12",
           "sp01",
           "cg01",
           "frcol",
           "c2col")
#keep only selected columns
e03_df <- e01_df[keeps]
########################################################################
if(!require(cowplot)){
  install.packages("cowplot")
  library(cowplot)
}
library(cowplot)

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
#nochim_table <- read.table(file=inp_fn1,sep='\t',header=T)

#read in the result from the taxonomyB_R code
#df_blast_result <- read.table(file=inp_fn2,sep='\t',header=T)
# see the first 4 header lines
#head(df_blast_result,3)
##see what the columns are named
#colnames(df_blast_result)
#assign some of the columns to objects
#blast_r_seqID <- df_blast_result$qseqid
#blast_r_class <- df_blast_result[,11] #class
#blast_r_order <- df_blast_result[,12] #order
#blast_r_fam <- df_blast_result[,13] #family
#blast_r_genus <- df_blast_result[,14] #genus
#blast_r_genus_species <- df_blast_result[,15] #genus_species

nochim_table <- e02_df
#convert data frame from a "wide" format to a "long" format
nochim_table_melt <- melt(nochim_table, id = c("a11"))

head(nochim_table_melt,4)
#match between data frames
nochim_table_melt$a12 <- e03_df[,2][match(nochim_table_melt$a11,e03_df$a11)]
nochim_table_melt$sp01 <- e03_df[,3][match(nochim_table_melt$a11,e03_df$a11)]
nochim_table_melt$cg01 <- e03_df[,4][match(nochim_table_melt$a11,e03_df$a11)]
nochim_table_melt$frcol <- e03_df[,5][match(nochim_table_melt$a11,e03_df$a11)]
nochim_table_melt$c2col <- e03_df[,6][match(nochim_table_melt$a11,e03_df$a11)]
#nochim_table_melt$blast_r_order <- df_blast_result[,12][match(nochim_table_melt$X,df_blast_result$qseqid)]
#nochim_table_melt$blast_r_fam <- df_blast_result[,13][match(nochim_table_melt$X,df_blast_result$qseqid)]
#nochim_table_melt$blast_r_genus <- df_blast_result[,14][match(nochim_table_melt$X,df_blast_result$qseqid)]
#nochim_table_melt$blast_r_genus_species <- df_blast_result[,15][match(nochim_table_melt$X,df_blast_result$qseqid)]
#keep the order of your samples the same as in the table. Otherwise, R will order variables alphabetically.
nochim_table_melt$a11 <- factor(nochim_table_melt$a11,levels=unique(nochim_table_melt$a11))

nochim_table_melt$gsp01 <- paste(nochim_table_melt$a12,nochim_table_melt$sp01, sep="_")
nochim_table_melt$value<- as.numeric(nochim_table_melt$value)
#create 100% stacked bar plot with sample on the x-axis
Stacked_bar_plot_per_seq <- ggplot(data = nochim_table_melt,
                                   aes(x = variable, y = value, fill = gsp01)) +
  #geom_bar(position="fill", stat="identity", color=nochim_table_melt$c2col) +
  geom_bar(position="fill", stat="identity") + #, fill=nochim_table_melt$c2col) +
  #fill=nochim_table_melt$c2col) +
  #Get same result with
  #geom_col(position="fill", color=nochim_table_melt$c2col, fill=nochim_table_melt$c2col) + #
  #scale_color_manual(values=c(nochim_table_melt$c2col)) +
  #theme(legend.position="right") +
  labs(x = "Sample", y = "Proportion of reads/sequence", fill = "Sequences") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + #,
  
  # legend.position = c(.95, .95),
  # legend.justification = c("right", "top"),
  # legend.box.just = "right",
  # legend.margin = margin(6, 6, 6, 6)) + #uncomment to angle x-axis labels 90 degrees
  scale_fill_manual(values=nochim_table_melt$c2col)
print(Stacked_bar_plot_per_seq)





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
figure <- ggpubr::ggarrange(Stacked_bar_plot_per_seq,
                            Stacked_bar_plot_per_seq,
                            Stacked_bar_plot_per_seq,
                            Stacked_bar_plot_per_seq,
                            labels = c(subfiglt),
                            ncol = 2, nrow = 2)
figure <- Stacked_bar_plot_per_seq
wd="/Users/steenknudsen/Documents/Documents/intro_til_metabarcoding"
setwd(wd)
getwd
#substitute on the input file name
filn01 <- gsub("part05_output_","",inp_fn2)
filn02 <- gsub("01.txt","",filn01)

filn02 <-"r_plot_stacked_bar_plot"
#paste together a new filename
plot.nm3 <- paste("part06_output_plot_on_",filn02,"02", sep="")
#print the plot in a pdf - open a pdf file
pdf(c(paste(plot.nm3,".pdf",  sep = ""))
    #set size of plot
    ,width=(1*8.2677),height=(3*2.9232))
#add the plot to the pdf
print(figure)
#close the pdf file again
dev.off()


#


#######