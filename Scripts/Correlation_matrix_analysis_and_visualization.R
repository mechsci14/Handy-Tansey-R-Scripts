## Run correlation analysis on matrix by column

# Install the necessary packages if you haven't already done so before. This only needs to be done one time on your computer.
install.packages("Hmisc")
install.packages("corrplot")
install.packages("tidyverse")

# These packages are picky, and they only work if you remove any non-numeric values from your data frames.
# So create a .csv file that only contains your data, no additional labels.

# Also, this package operates by correlating data of different kinds within the same sample.
# So if you have blank rows, they need to be removed, and if you have more than one blank cell within a row, the function will not work.
# Code is included to remove rows that have more than one missing value if you want to do it programmatically.

# Replace the first file path with the file path of your data, and the second two with the location and file names where you 
#   want to save the exported r and p value files if you want to save those.

# Call your data
df <- read.csv("C:/Users/mecho/Documents/TANSEY_LAB/RAnalyses/DataFiles/ExampleFiles/CytokineDataex.csv")

# Open the Hmisc package
library(Hmisc)
library(tidyverse)

# Remove rows containing more than one missing value
df <- df %>% mutate(NAsum = rowSums(is.na(df))) %>% filter(NAsum < 2) %>% select(-NAsum)

# Run the correlation matrix
corrmat <- rcorr(as.matrix(df), type = "pearson") # "spearman" is also an option

# Export r values in a .csv file if you want
write.csv(corrmat$r, "C:/Users/Acer/Documents/R/Correlation_Matrix_PlasmavsStool.csv")

# Export p values in a .csv file if you want
write.csv(corrmat$P, "C:/Users/Acer/Documents/R/Correlation_Matrix_PlasmavsStool_ps.csv")

## Visualize correlation matrix data

# Open correlation plot package
library(corrplot)

# Generate image based on correlation matrix data
corrplot(corrmat$r, type="upper", order="alphabet", 
         p.mat = corrmat$P, sig.level = 0.05, insig = "blank")

# The image can be exported and saved if desired.