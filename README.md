# ont_cnv_confirmation_pub

This repository contains code for Greer, et al. *"Implementation of Nanopore sequencing as a pragmatic workflow for copy number variant confirmation in the clinic"*

*Background:* Diagnosis of rare genetic diseases can be a long, expensive and complex process, involving an array of tests in the hope of obtaining an actionable result. Long-read sequencing platforms offer the opportunity to make definitive molecular diagnoses using a single assay capable of detecting variants, characterizing methylation patterns, resolving complex rearrangements, and assigning findings to long-range haplotypes. Here, we demonstrate the clinical utility of Nanopore long-read sequencing by validating a confirmatory test for copy number variants (CNVs) in neurodevelopmental disorders and illustrate the broader applications of this platform to assess genomic features with significant clinical implications. 

*Methods:* We used adaptive sampling on the Oxford Nanopore platform to sequence 25 genomic DNA samples and 5 blood samples collected from patients with known or false-positive copy number changes originally detected using short-read sequencing. Across the 30 samples (a total of 50 with replicates), we assayed 35 known unique CNVs (a total of 55 with replicates) and one false-positive CNV, ranging in size from 40 kb to 155 Mb, and assessed the presence or absence of suspected CNVs using normalized read depth.

*Results:* Across 50 samples (including replicates) sequenced on individual MinION flow cells, we achieved an average on-target mean depth of 9.5X and an average on-target read length of 4805 bp. Using a custom read depth-based analysis, we successfully confirmed the presence of all 55 known CNVs (including replicates) and the absence of one false-positive CNV. Using the same CNV-targeted data, we compared genotypes of single nucleotide variant loci to verify that no sample mix-ups occurred between assays. For one case, we also used methylation detection and phasing to determine the parental origin of a 15q11.2-q13 duplication with implications for clinical prognosis. 

*Conclusions:* We present an assay that efficiently targets genomic regions to confirm clinically relevant CNVs with a concordance rate of 100%. Furthermore, we demonstrate how integration of genotype, methylation, and phasing data from the Nanopore sequencing platform can potentially simplify and shorten the diagnostic odyssey. 

# Installation
Please install R and the following R packages
- data.table
- ggplot2
- dplyr

# Generating Figures
Code for generating figures in the paper is provided in the figures directory using data available in the data directory

```
 Rscript figures/Fig3A.R
 Rscript figures/Fig3B.R
 Rscript figures/Fig4.R
 Rscript figures/Fig5.R
```