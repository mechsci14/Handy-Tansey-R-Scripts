## Generate a series of grouped (two factor) categorical scatterplots with error bars indicating SEM

# Install and import the necessary packages if you haven't already done so before. This only needs to be done one time on your computer.
install.packages("ggplot2")
install.packages("extrafont")
library(extrafont)
font_import()
loadfonts()
# After creating the graphs using the script below, R will return warnings about the font, but these can be ignored, and the font will work correctly.


# Scroll down to the last line, and in the parentheses, input your file path in quotes,
#   your two factor names in quotes, and the number of the column in your data frame where you want to start graphing (no quotes)
# After you have put in your specific information, run the entire script from the beginning (excluding the package installs if you've already done that once)

twocatscatter <- function(filepath, factor1, factor2, startColNum){
  # Call your data
  df <- read.csv(filepath)
  # Create an object consisting of the names of the columns in your data set
  colnames <- names(df)
  # Ensure that the graphs will keep the same order for x-axis categories as on the original spreadsheet.
  df[[factor1]] <- as.character(df[[factor1]])
  df[[factor1]] <- factor(df[[factor1]], levels=unique(df[[factor1]]))
  df[[factor2]] <- as.character(df[[factor2]])
  df[[factor2]] <- factor(df[[factor2]], levels=unique(df[[factor2]]))
  # Open the graphing package ggplot2
  library(ggplot2)
  # Generate images of each of your graphs. Code can be modified to save each image separately if desired.
  for(cn in startColNum:length(df)){
    print(ggplot(df, aes_string(x=factor1, y=colnames[cn], color=factor2))
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
}

twocatscatter("filepath", "factor1", "factor2", StartColNum)
