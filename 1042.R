library(BiocGenerics)
library(graph)
library(grid)
library(Rgraphviz)
library(bnlearn)

data <- read.csv("data_dis.csv", header = TRUE, colClasses = c("factor"))
black <- data.frame(from = c("Pins", "End","Res","Stay","Insured","Edu","SES","Illness","Jcond","EnvL",
                             "Burden","SatIns","SatServ","IfHigher","IncRank","AvgCost","InsL","Spent",
                             "Pinc","Pchar","Ploan","Dcost","Streat","Srel","Senv","Sex","Days","MaxIns",
                             "WkYrs","Income", "Pins","End","Res","Stay","Insured","Edu","SES",
                             "Illness","Jcond","EnvL","Burden", "SatIns","SatServ","IfHigher","IncRank",
                             "AvgCost","InsL","Spent","Pinc","Pchar","Ploan","Dcost", "Streat","Srel",
                             "Senv","Age","Days","MaxIns","WkYrs","Income",
                             "Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden",
                             "Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden",
                             "Burden","Burden","Burden","Burden","Burden","Burden","Burden","Burden",
                             "IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher",
                             "IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher",
                             "IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher","IfHigher",
                             "IfHigher"), 
                    to = c("Age","Age","Age","Age","Age","Age","Age","Age","Age","Age",
                          "Age","Age","Age","Age","Age","Age","Age","Age","Age","Age",
                          "Age","Age","Age","Age","Age","Age","Age","Age","Age","Age","Age",
                          "Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex",
                          "Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex",
                          "Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex","Sex",
                          "Pins", "End","Res","Stay","Insured","Edu","SES","Illness","Jcond","EnvL",
                          "SatIns","SatServ","IncRank","AvgCost","InsL","Spent",
                          "Pinc","Pchar","Ploan","Dcost","Streat","Srel","Senv","Days","MaxIns",
                          "WkYrs","Income",
                          "Pins","End","Res","Stay","Insured","Edu","SES",
                          "Illness","Jcond","EnvL", "SatIns","SatServ","IncRank",
                          "AvgCost","InsL","Spent","Pinc","Pchar","Ploan","Dcost", "Streat","Srel",
                          "Senv","Days","MaxIns","WkYrs","Income"))
dag <- hc(data, blacklist = black)
modelstring(dag)
graphviz.plot(dag)
?hc
