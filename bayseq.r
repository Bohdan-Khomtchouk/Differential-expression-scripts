# BaySeq
all = read.delim("file.txt", header = TRUE, sep = "\t")
replicates <- c(1,1,2,2,2)
groups <- list(NDE = c(1,1,1,1,1), DE = c(1,1,2,2,2))
cname <- all[,1]
all <- all[,-1]
all = as.matrix(all)
CD <- new("countData", data = all, replicates = replicates, groups = groups)
libsizes(CD) <- getLibsizes(CD)
CD@annotation <- as.data.frame(cname)
cl <- NULL
CDP.NBML <- getPriors.NB(CD, samplesize = 1000, estimation = "QL", cl = cl)
CDPost.NBML <- getLikelihoods.NB(CDP.NBML, pET = 'BIC', cl = cl)
topCounts(CDPost.NBML, group = 2)
NBML.TPs <- getTPs(CDPost.NBML, group = 2, TPs = 1:100)
bayseq_de = topCounts(CDPost.NBML, group = 2, number = 60000)
write.csv(bayseq_de, file = "file_bayseq_results.csv")