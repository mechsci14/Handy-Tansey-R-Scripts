## Copy only the relevant values from a multiplexed immunoassay data output into a new spreadsheet

# Open  data spreadsheet. Delete experiment information from upper left cell or move to the same row as the column headers.

# Delete spaces from column header names.
OrigMesoData <- read.csv("C:/Users/Acer/Documents/TANSEY_LAB/RAnalyses/DataFiles/Meso_plasma_04-05-2018.csv")
TrimMesoData <- OrigMesoData[c("Sample", "Assay", "Calc.Conc.Mean", "DetectionRange")]
MesoData <- TrimMesoData[c(T,F),]
MyMesoData <- MesoData[!grepl("S", MesoData$Sample),]
write.csv(MyMesoData, "C:/Users/Acer/Documents/TANSEY_LAB/RAnalyses/MyMeso_plasma_04-05-2018.csv")