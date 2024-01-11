library(BiocGenerics)
library(graph)
library(grid)
library(Rgraphviz)
library(bnlearn)
library(gRbase)
library(gRain)
library(lattice)

dag <- empty.graph(nodes = c("Pins", "End","Res","Stay","Insured","Edu","SES","Illness","Jcond","EnvL",
                             "Burden","SatIns","SatServ","IfHigher","IncRank","AvgCost","InsL","Spent",
                             "Pinc","Pchar","Ploan","Dcost","Streat","Srel","Senv","Sex","Days","MaxIns",
                             "WkYrs","Income","Age"))

dag <- set.arc(dag, from = "Age", to = "WkYrs")
dag <- set.arc(dag, from = "WkYrs", to = "Insured")
dag <- set.arc(dag, from = "Sex", to = "Insured")
dag <- set.arc(dag, from = "WkYrs", to = "Income")
dag <- set.arc(dag, from = "Income", to = "Edu")
dag <- set.arc(dag, from = "Income", to = "SES")
dag <- set.arc(dag, from = "Income", to = "IncRank")
dag <- set.arc(dag, from = "Insured", to = "InsL")
dag <- set.arc(dag, from = "WkYrs", to = "InsL")
dag <- set.arc(dag, from = "InsL", to = "Pins")
dag <- set.arc(dag, from = "WkYrs", to = "Pins")
dag <- set.arc(dag, from = "SES", to = "Pchar")
dag <- set.arc(dag, from = "Income", to = "Jcond")
dag <- set.arc(dag, from = "Pins", to = "Jcond")
dag <- set.arc(dag, from = "Pins", to = "Res")
dag <- set.arc(dag, from = "Jcond", to = "Res")
dag <- set.arc(dag, from = "Res", to = "EnvL")
dag <- set.arc(dag, from = "Pins", to = "EnvL")
dag <- set.arc(dag, from = "Res", to = "SatIns")
dag <- set.arc(dag, from = "InsL", to = "SatIns")
dag <- set.arc(dag, from = "Pins", to = "AvgCost")
dag <- set.arc(dag, from = "Res", to = "AvgCost")
dag <- set.arc(dag, from = "Res", to = "Ploan")
dag <- set.arc(dag, from = "Pins", to = "Ploan")
dag <- set.arc(dag, from = "Res", to = "Burden")
dag <- set.arc(dag, from = "Ploan", to = "Burden")
dag <- set.arc(dag, from = "AvgCost", to = "SatServ")
dag <- set.arc(dag, from = "Pins", to = "SatServ")
dag <- set.arc(dag, from = "Ploan", to = "Pinc")
dag <- set.arc(dag, from = "Pins", to = "Pinc")
dag <- set.arc(dag, from = "AvgCost", to = "Dcost")
dag <- set.arc(dag, from = "AvgCost", to = "Srel")
dag <- set.arc(dag, from = "Pins", to = "Srel")
dag <- set.arc(dag, from = "Pins", to = "Senv")
dag <- set.arc(dag, from = "EnvL", to = "Senv")
dag <- set.arc(dag, from = "SatServ", to = "End")
dag <- set.arc(dag, from = "Res", to = "End")
dag <- set.arc(dag, from = "Burden", to = "IfHigher")
dag <- set.arc(dag, from = "Srel", to = "Streat")
dag <- set.arc(dag, from = "Senv", to = "Streat")
dag <- set.arc(dag, from = "End", to = "Stay")
dag <- set.arc(dag, from = "Stay", to = "Spent")
dag <- set.arc(dag, from = "AvgCost", to = "Spent")
dag <- set.arc(dag, from = "Pins", to = "Days")
dag <- set.arc(dag, from = "Stay", to = "Days")
dag <- set.arc(dag, from = "Insured", to = "Illness")
dag <- set.arc(dag, from = "Days", to = "Illness")
dag <- set.arc(dag, from = "Days", to = "MaxIns")

dag
modelstring(dag)
graphviz.plot(dag)


data_train <- read.csv("data_dis.csv", header = TRUE, colClasses = c("factor"))
dag <- bn.fit(dag, data = data_train, method = "mle")
junction <- compile(as.grain(dag))
jsex <- setEvidence(junction, nodes = c("Res","Pins"), states = c("Yes","1"))
querygrain(jsex, nodes = "SatServ")$SatServ


Evidence <- factor(c(rep("full1",4), rep("con1", 4),
                     rep("full2",4), rep("con2",4)),
                   levels = c("full1", "con1", "full2","con2"))
Burden <- factor(rep(c("A", "B", "C","D"), 4),
                 levels = c("D", "C", "B","A"))
distr <- data.frame(Evidence = Evidence, Travel = Burden,
                    Prob = c(0.1251566, 0.2175788, 0.6572646, 0.0000000,
                             0.1251566, 0.2175788, 0.6572646, 0.0000000, 
                             0.005579210, 0.045881662, 0.939362795, 0.009176332,
                             0.005579210, 0.045881662, 0.939362795, 0.009176332))


barchart(Burden ~ Prob | Evidence, data = distr,
         box.ratio = c(1, 2),
         layout = c(4, 1), xlab = "Conditional probability",
         scales = list(alternating = 1, tck = c(1, 0)),
         strip = strip.custom(factor.levels =
                                c("P(SatServ | Res=Yes, Pins=1)",
                                  "P'(SatServ | Res=Yes, Pins=1)",
                                  "P(SatServ | Res=Yes , Pins=3)",
                                  "P'(SatServ | Res=Yes, Pins=3)"),
         par.strip.text = list(cex = 0.7)),

         
         panel = function(...) {
           panel.barchart(...,col="gray")
           panel.grid(h = 0, v = -1)
         })





