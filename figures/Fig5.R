library(data.table)
library(dplyr)
library(ggplot2)

df<-fread("./data/sample_matching.txt", sep="\t", header=T)

df <- df %>% arrange(desc(ppn_match),desc(lr_study_freq),desc(sr_study_freq),desc(lr_coriell_id),sr_coriell_id)

short_ids <- unique(df$sr_coriell_id)
long_ids <- unique(df$lr_coriell_id)
df$sr_coriell_id = factor(df$sr_coriell_id, levels = short_ids)
df$lr_coriell_id = factor(df$lr_coriell_id, levels = long_ids)

### plot

ggplot(df, aes(sr_coriell_id, lr_coriell_id, fill= ppn_match)) + 
  geom_tile(color="black") +
  scale_fill_continuous(low="white", high="darkgreen", name = "Match\nproportion") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size=10),
        axis.text.y = element_text(size=10),
        axis.title = element_text(size=18),
        legend.title=element_text(size=18),
        legend.text=element_text(size=15),
        legend.key = element_rect(colour = "black", size = 4),
        legend.justification = "top",
        legend.title.align=0.5,
        legend.margin=margin(30, 0, 0, 5)) +
  xlab("Coriell ID (short-read sequencing)") + 
  ylab("Coriell ID (long-read sequencing)") +
  guides(fill = guide_colourbar(barwidth = 2, barheight = 10, frame.colour="black", frame.linewidth=0.5, ticks.colour="black", ticks.linewidth=0.5, title.vjust=2.5))

ggsave("./figures/Fig5.png", height=8, width=8.7)