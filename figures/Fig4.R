library(data.table)
library(dplyr)
library(ggplot2)

df<-fread("./data/sample_cnv_data.txt", sep="\t", header=T)

### exclude failed samples

samples_exclude <- c('SM4628','SM7239','SM4846')
df <- df %>% filter(!sample_id %in% samples_exclude)

df <- df %>% filter(region_type == 'cnv')

df<-df %>% mutate(cn_new = ifelse(sample_sex == "MALE" & cnv_type == "DUP" & (chr == "X" | chr == "Y"), paste(copy_number,sample_sex,"XY",sep="_"), copy_number))

### plot

ggplot(df, aes(x=ctrl_norm_factor, y=ctrl_norm, fill=as.factor(cn_new))) +
  geom_hline(yintercept=0, color="#052F61", linetype="dashed", size=1) +
  geom_hline(yintercept=0.5, color="#A50E82", linetype="dashed", size=1) +
  geom_hline(yintercept=1, color="gray", linetype="dashed", size=1) +
  geom_hline(yintercept=1.5, color="#14967C", linetype="dashed", size=1) +
  geom_hline(yintercept=2, color="#E87D37", linetype="dashed", size=1) +
  geom_point(shape=21, size=5, alpha=0.8) +
  scale_fill_manual(values = c("0"="#052F61", "1"="#A50E82", "2"= "gray", "3"="#14967C", "2_MALE_XY"="#E87D37"), labels = c("2_MALE_XY"="2 (Male XY)")) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_blank(),
        axis.text=element_text(size=14),
        axis.title=element_text(size=16),
        legend.text=element_text(size=14),
        legend.title=element_text(size=16),
        legend.title.align=0.5) +
  guides(fill=guide_legend(title="Expected\ncopy number")) +
  xlab("Mean control depth") +
  ylab("Mean CNV depth ratio")

ggsave("./figures/Fig4.png",height=4, width=8)