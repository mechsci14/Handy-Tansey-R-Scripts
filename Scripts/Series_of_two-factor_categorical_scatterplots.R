## Generate a series of grouped (two factor) categorical scatterplots with error bars indicating SEM

# Note: After running the loop below, R will return warnings about the font, but these can be ignored, and the font will work correctly.

# Call your data
df <- read.csv("C:/Users/mecho/Documents/TANSEY_LAB/RAnalyses/DataFiles/ExampleFiles/FlowDataex.csv", header = TRUE)

# Create an object consisting of the names of the columns in your data set
colnames <- names(df)

# Ensure that the graphs will keep the same order for x-axis categories as on the original spreadsheet.
df$Sex <- as.character(df$Sex)
df$Sex <- factor(df$Sex, levels=unique(df$Sex))
df$Genotype <- as.character(df$Genotype)
df$Genotype <- factor(df$Genotype, levels=unique(df$Genotype))


# If you have not already installed/imported these packages once on your computer, do so:
install.packages("ggplot2")
install.packages("extrafont")
library(extrafont)
font_import()
loadfonts()

# Open the graphing package ggplot2
library(ggplot2)


# Generate images of each of your graphs. Code can be modified to save each image separately if desired.
for(cn in 4:length(df)){
  print(ggplot(df, aes_string(x="Sex", y=colnames[cn], color="Genotype"))
        + geom_jitter(aes(shape=Genotype), position=position_jitterdodge(jitter.width=0.3, dodge.width=0.9), size=3)
        + scale_color_grey() + theme_classic()
        + ylim(0, max(df[,cn]))
        + ggtitle(paste(colnames[cn])) 
        + theme(text=element_text(family="Arial", size=12), plot.title = element_text(hjust=0.5),
                axis.title.x = element_blank(), legend.position="right")
        + stat_summary(
          fun.ymax=function(i) mean(i) + (sd(i)/sqrt(length(i))), 
          fun.ymin=function(i) mean(i) - (sd(i)/sqrt(length(i))),
          geom="errorbar", width=0.2, position=position_dodge(width=0.9)))
}
