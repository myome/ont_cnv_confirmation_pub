library(data.table)
library(dplyr)
library(ggplot2)

df<-fread("./data/sample_cnv_data.txt", sep="\t", header=T)

### exclude failed samples

samples_exclude <- c('SM4628','SM7239','SM4846')
df <- df %>% filter(!sample_id %in% samples_exclude)

df <- df %>% filter(region_type == 'cnv')

df<-df %>% mutate(abs_diff = ifelse(cnv_type == "DEL", cutoff_del-ctrl_norm,ctrl_norm-cutoff_dup))
df$abs_diff

### plot

ggplot(df, aes(x=ctrl_norm_factor, y=abs_diff, fill=as.factor(cnv_type))) +
  theme_bw() + 
  geom_hline(yintercept=0, color="red", linetype="dashed", size=1) +
  geom_point(shape=21, size=5, alpha=0.8) +
  scale_fill_manual(values = c("DEL"="skyblue", "DUP"="tomato", "CONTROL"= "gray"), labels = c("DEL"="Deletion", "DUP" = "Duplication","CONTROL"="Control")) +
  xlab("Mean control depth") +
  ylab("Depth ratio \u0394 between CNV and cutoff") +
  guides(fill=guide_legend(title="CNV type")) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_blank(),
        axis.text=element_text(size=14),
        axis.title.x=element_text(size=16),
        axis.title.y=element_text(size=14),
        legend.title.align=0.5,
        legend.text=element_text(size=14),
        legend.title=element_text(size=16),
        legend.justification = "top",
        legend.margin = margin(50,0,0,0),
        legend.key.size = unit(0.7, "cm"))

ggsave("./figures/Fig3B.png",height=4, width=8)