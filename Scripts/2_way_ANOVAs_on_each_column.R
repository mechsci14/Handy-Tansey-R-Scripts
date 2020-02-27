## Perform repeated two-way ANOVAs on each column of a data frame

# Call your data
df <- read.csv("C:/Users/mecho/Documents/TANSEY_LAB/RAnalyses/DataFiles/ExampleFiles/FlowDataex.csv")

# Create an object consisting of the names of the columns in your data set
colnames <- names(df)

# Run two-way ANOVAs on the data in each column of the data frame
for(i in 4:length(df)){
  anovadata <- summary(aov(df[,i] ~ Sex + Genotype + Sex:Genotype, df))
  cat(paste("\n", colnames[i], "\n"))
  print(anovadata)
}
