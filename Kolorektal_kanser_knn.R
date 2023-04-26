library(GEOquery)
gds=getGEO("GDS4382")
eset=GDS2eSet(gds,do.log2 = TRUE)
dim(eset)
kayip=nrow(which(is.na(exprs(eset)),arr.ind = TRUE))
show(kayip)
veri=t(exprs(eset))
which(is.na(veri),arr.ind = TRUE)
veri[15,3090]
#knn algoritmasını kullanılarak yazılmıştır.
#knn algoritmasını kullanmak için impute
#paketini çağırmam gerekmektedir.
library(impute)
yeni_veri<-impute.knn(as.matrix(veri))
veri=yeni_veri$data
veri[15,3090]
durum=pData(eset)$diseae.state
library(randomForest)
set.seed(1)
aykırı=randomForest(veri,durum, proximity = TRUE)
order(outlier(aykırı),decreasing = TRUE)[1:5]
