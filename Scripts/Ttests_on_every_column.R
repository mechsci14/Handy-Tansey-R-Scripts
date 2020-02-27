## Run t-tests on matrix by column
install.packages("matrixTests") # this only needs to be installed once
packageVersion("matrixTests")

# Call your data
df <- read.csv("C:/Users/mecho/Documents/TANSEY_LAB/RAnalyses/DataFiles/ExampleFiles/CytokineDataex.csv")

# Open the statistics package matrixTests
library(matrixTests)

# Assign data to your two groups using the appropriate labels from your data set and excluding the first column
Control <- df[df[,1]=="Control", -1]
Patient <- df[df[,1]=="Patient", -1]

# Run the t-tests by column and export the result to a .csv file
result <- col_t_welch(Control, PD)
write.csv(result, "C:/Users/Acer/Documents/R/T-tests_Stool_Plasma_Meso.csv")