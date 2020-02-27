## Copy only the relevant values from a multiplexed immunoassay data output (EMIC) into a new spreadsheet

# Open  data spreadsheet (.csv version). Delete experiment information from upper left cell or move to the same row as the column headers.
# Delete spaces from column header names.
# Scroll down to the last line of the script, and in the parentheses, input the file path of the original file in quotes
#     and the path for where you want to save the new file in quotes, being sure to include the name of the new file.csv at the end
# After you have put in your specific information, run the entire script from the beginning

copyMesoData <- function(filepath, filepath2){
  df <- read.csv(filepath)
  df2 <- df[c("Sample", "Assay", "Calc.Conc.Mean", "DetectionRange")]
  df3 <- df2[c(T,F),]
  df4 <- df3[!grepl("S", df3$Sample),]
  write.csv(df4, filepath2)
}

copyMesoData("filepath", "filepath2")