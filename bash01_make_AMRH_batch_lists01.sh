#!/bin/bash
# -*- coding: utf-8 -*-

#prepared in excel
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBA_aa/PRI-QJ3LO-AMRH-2019Nov04-A_S1_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBA_aa/PRI-QJ3LO-AMRH-2019Nov04-A_S1_L001_R2_001.fastq part01_tags_AMRH_AL.txt CCGCCCGTCACCCTCCT GTAYRCTTACCWTGTTACGAC 5
" > batch_file_AMRH_AL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBB_aa/PRI-QJ3LO-AMRH-2019Nov04-B_S2_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBB_aa/PRI-QJ3LO-AMRH-2019Nov04-B_S2_L001_R2_001.fastq part01_tags_AMRH_BL.txt CCGCCCGTCACCCTCCT GTAYRCTTACCWTGTTACGAC 5
" > batch_file_AMRH_BL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBC_aa/PRI-QJ3LO-AMRH-2019Nov04-C_S3_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBC_aa/PRI-QJ3LO-AMRH-2019Nov04-C_S3_L001_R2_001.fastq part01_tags_AMRH_CL.txt CCGCCCGTCACCCTCCT GTAYRCTTACCWTGTTACGAC 5
" > batch_file_AMRH_CL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBD_aa/PRI-QJ3LO-AMRH-2019Nov04-D_S4_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBD_aa/PRI-QJ3LO-AMRH-2019Nov04-D_S4_L001_R2_001.fastq part01_tags_AMRH_DL.txt CCGCCCGTCACCCTCCT GTAYRCTTACCWTGTTACGAC 5
" > batch_file_AMRH_DL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBE_aa/PRI-QJ3LO-AMRH-2019Nov04-E_S5_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBE_aa/PRI-QJ3LO-AMRH-2019Nov04-E_S5_L001_R2_001.fastq part01_tags_AMRH_EL.txt CCGCCCGTCACCCTCCT GTAYRCTTACCWTGTTACGAC 5
" > batch_file_AMRH_EL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBF_aa/PRI-QJ3LO-AMRH-2019Nov04-F_S6_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBF_aa/PRI-QJ3LO-AMRH-2019Nov04-F_S6_L001_R2_001.fastq part01_tags_AMRH_FL.txt CCGCCCGTCACCCTCCT GTAYRCTTACCWTGTTACGAC 5
" > batch_file_AMRH_FL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBG_aa/PRM-BIVLP-AMRH-2019Nov04-G_S1_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBG_aa/PRM-BIVLP-AMRH-2019Nov04-G_S1_L001_R2_001.fastq part01_tags_AMRH_GL.txt GTCGGTAAAACTCGTGCCAGC CATAGTGGGGTATCTAATCCCAGTTTG 5
" > batch_file_AMRH_GL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBH_aa/PRM-BIVLP-AMRH-2019Nov04-H_S2_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBH_aa/PRM-BIVLP-AMRH-2019Nov04-H_S2_L001_R2_001.fastq part01_tags_AMRH_HL.txt GTCGGTAAAACTCGTGCCAGC CATAGTGGGGTATCTAATCCCAGTTTG 5
" > batch_file_AMRH_HL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBI_aa/PRM-BIVLP-AMRH-2019Nov04-I_S3_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBI_aa/PRM-BIVLP-AMRH-2019Nov04-I_S3_L001_R2_001.fastq part01_tags_AMRH_IL.txt GTCGGTAAAACTCGTGCCAGC CATAGTGGGGTATCTAATCCCAGTTTG 5
" > batch_file_AMRH_IL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBJ_aa/PRM-BIVLP-AMRH-2019Nov04-J_S4_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBJ_aa/PRM-BIVLP-AMRH-2019Nov04-J_S4_L001_R2_001.fastq part01_tags_AMRH_JL.txt GTCGGTAAAACTCGTGCCAGC CATAGTGGGGTATCTAATCCCAGTTTG 5
" > batch_file_AMRH_JL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBK_aa/PRM-BIVLP-AMRH-2019Nov04-K_S5_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBK_aa/PRM-BIVLP-AMRH-2019Nov04-K_S5_L001_R2_001.fastq part01_tags_AMRH_KL.txt GTCGGTAAAACTCGTGCCAGC CATAGTGGGGTATCTAATCCCAGTTTG 5
" > batch_file_AMRH_KL.list
echo "/groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBL_aa/PRM-BIVLP-AMRH-2019Nov04-L_S6_L001_R1_001.fastq /groups/hologenomics/marierh/data/AAmosen_data/0-raw-data/MBIBL_aa/PRM-BIVLP-AMRH-2019Nov04-L_S6_L001_R2_001.fastq part01_tags_AMRH_LL.txt GTCGGTAAAACTCGTGCCAGC CATAGTGGGGTATCTAATCCCAGTTTG 5
" > batch_file_AMRH_LL.list

