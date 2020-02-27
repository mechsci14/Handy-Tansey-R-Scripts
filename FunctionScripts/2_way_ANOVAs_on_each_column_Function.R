## Perform repeated two-way ANOVAs on each column of a data frame FUNCTION

# Scroll down to the last line, and in the parentheses, input your file path in quotes,
#   your two factor names in quotes, and the number of the column in your data frame where you want to start graphing (no quotes)
# After you have put in your specific information, run the entire script from the beginning (excluding the package install if you've already done it once)

twowayANOVAs <- function(filepath, factor1, factor2, StartColNum){
  # Call your data
  df <- read.csv(filepath)
  # Create an object consisting of the names of the columns in your data set
  colnames <- names(df)
  factor1 <- df[[factor1]]
  factor2 <- df[[factor2]]
  # Run two-way ANOVAs on the data in each column of the data frame
  for(i in StartColNum:length(df)){
    anovadata <- summary(aov(df[,i] ~ factor1 + factor2 + factor1:factor2, df))
    cat(paste("\n", colnames[i], "\n"))
    print(anovadata)
  } 
}

twowayANOVAs("filepath", "factor1", "factor2", StartColNum)
