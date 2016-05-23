# DESeq
pasillaCountTable = read.table(“file.txt”, header = TRUE, row.names = 1)
pasillaDesign = data.frame(row.names = colnames(pasillaCountTable), 
                           condition = c("untreated", "untreated", "treated", "treated", "treated"), 
                           libType = c("paired-end", "paired-end", "paired-end", "paired-end", "paired-end"))
pairedSamples = pasillaDesign$libType == "paired-end"
countTable = pasillaCountTable[, pairedSamples]
condition = pasillaDesign$condition[pairedSamples]
condition = factor(c("untreated", "untreated", "treated", "treated", "treated"))
cds = newCountDataSet(countTable, condition)
cds = estimateSizeFactors(cds)
cds = estimateDispersions(cds)
res = nbinomTest(cds, "untreated", "treated")
write.csv(res, file = "file_deseq_results.csv")
