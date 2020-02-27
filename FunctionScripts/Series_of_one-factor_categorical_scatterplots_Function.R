## Generate a series of categorical (one factor) scatterplots that resemble the stye of GraphPad Prism - FUNCTION

# Install and import the necessary packages if you haven't already done so before. This only needs to be done one time on your computer.
install.packages("ggplot2")
install.packages("ggpubr")
install.packages("extrafont")
library(extrafont)
font_import()
loadfonts()
# After creating the graph using the script below, R will return warnings about the font, but these can be ignored, and the font will work correctly.

# Scroll down to the last line, and in the parentheses, input your file path in quotes,
#   and the column name where your experimental group annotations are listed (xaxis) in quotes.
# After you have put in your specific information, run the entire script from the beginning (excluding the package installs if you've already done that once)

catscatters <- function(filepath, xaxis){
  # Call your data
  df <- read.csv(filepath)
  # If you care about the order of the groups on your graph, you can do the following:
  # Ensure that the graphs will keep the same order for x-axis categories as on the original spreadsheet.
  df[[xaxis]] <- as.character(df[[xaxis]])
  df[[xaxis]] <- factor(df[[xaxis]], levels=unique(df[[xaxis]]))
  # Open the package ggpubr
  library(ggpubr)
  # The last line of the script below (stat_compare_means()) can be modified to perform the appropriate statistical test, including non-parametric, paired, and one-way ANOVA.
  # Create an object consisting of the names of the columns in your data set
  colnames <- names(df)
  # Open the graphing package ggplot2
  library(ggplot2)
  # Generate images of each of your graphs. Code can be modified to save each image separately if desired.
  for(cn in 2:length(df)){
    print(ggplot(df, aes_string(x=xaxis, y=colnames[cn], color=xaxis))
          + geom_jitter(aes(shape=xaxis), position=position_jitter(width=0.2), size=3) 
          + scale_color_grey() + theme_classic()
          + ylim(0, max(df[,cn]))
          + ggtitle(paste(colnames[cn])) 
          + theme(text=element_text(family="Arial", size=12), plot.title = element_text(hjust=0.5),
                  axis.title.x = element_blank(), legend.position="none")
          + stat_summary(
            fun.ymax=function(i) mean(i) + (sd(i)/sqrt(length(i))), 
            fun.ymin=function(i) mean(i) - (sd(i)/sqrt(length(i))),
            geom="errorbar", width=0.2)
          + stat_compare_means(method="anova", label.x=1.8))
  }
}
catscatters("filepath", "xaxis")