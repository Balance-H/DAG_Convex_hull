library(BiocGenerics)
library(graph)
library(grid)
library(Rgraphviz)
library(bnlearn)
library(gRbase)
library(gRain)

dag <- empty.graph(nodes = c("Pins", "Res","Burden","SatServ","AvgCost","Ploan"))


dag <- set.arc(dag, from = "Pins", to = "Res")
dag <- set.arc(dag, from = "Pins", to = "AvgCost")
dag <- set.arc(dag, from = "Res", to = "AvgCost")
dag <- set.arc(dag, from = "Res", to = "Ploan")
dag <- set.arc(dag, from = "Pins", to = "Ploan")
dag <- set.arc(dag, from = "Res", to = "Burden")
dag <- set.arc(dag, from = "Ploan", to = "Burden")
dag <- set.arc(dag, from = "AvgCost", to = "SatServ")
dag <- set.arc(dag, from = "Pins", to = "SatServ")


dag
modelstring(dag)
graphviz.plot(dag)


data_train <- read.csv("data_con.csv", header = TRUE, colClasses = c("factor"))
dag <- bn.fit(dag, data = data_train, method = "mle")
junction <- compile(as.grain(dag))

#jsex <- setEvidence(junction, nodes = c("Res","Pins"), states = c("Yes","3"))
#querygrain(jsex, nodes = "Burden")$Burden
#querygrain(jsex, nodes = "SatServ")$SatServ

jsex <- setEvidence(junction, nodes = c("Res","Pins"), states = c("No","3"))
querygrain(jsex, nodes = "Burden")$Burden


