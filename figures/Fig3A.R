library(data.table)
library(dplyr)
library(ggplot2)

df<-fread("./data/sample_cnv_data.txt", sep="\t", header=T)

### exclude failed samples

samples_exclude <- c('SM4628','SM7239','SM4846')
df <- df %>% filter(!sample_id %in% samples_exclude)

df <- df %>% filter(region_type == 'cnv')

df_cut <- df %>% select(sample_id, cutoff_del, cutoff_dup)
df_cut <- df_cut %>% distinct(.keep_all = TRUE)
df_cut_melt <- melt(df_cut, id = 'sample_id')

### plot

ggplot(df_cut_melt, aes(x=variable, y=value, fill=as.factor(variable))) +
  geom_boxplot() +
  theme_bw() + 
  scale_fill_manual(values = c("cutoff_del"="skyblue", "cutoff_dup"= "tomato"), labels = c( "cutoff_del"="Del cutoff", "cutoff_dup"="Dup cutoff")) +
  geom_hline(yintercept=1, color="gray", linetype="dashed", size=1) +
  scale_x_discrete(labels= c("Deletion","Duplication")) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_blank(),
        axis.text.x=element_text(size=16),
        axis.text.y=element_text(size=14),
        axis.title=element_text(size=16),
        legend.position="none",
        axis.title.x=element_blank()) +
  guides(fill=guide_legend(title=NA)) +
  scale_y_continuous(breaks=c(0.4,0.6,0.8,1,1.2,1.4,1.6), limits = c(0.4,1.72)) +
  ylab("Cutoff for CNV mean depth ratio") +
  geom_signif(comparisons = list(c("cutoff_del", "cutoff_dup")), map_signif_level=TRUE, color="black", y_position=1.63)

ggsave("./figures/Fig3A.png",height=4, width=4)
