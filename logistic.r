library(glmnet)
# to find best alpha
x <- as.matrix(newtrain[,-1])
y <- as.numeric(newtrain$type)

cvfit <- cv.glmnet(x, y, type.measure = "mse", nfolds = 20)
foldid <- sample(1:10,size=length(y),replace=TRUE)

cv1 <- cv.glmnet(x,y,foldid=foldid,alpha=1)
cv.5 <- cv.glmnet(x,y,foldid=foldid,alpha=.5)
cv0 <- cv.glmnet(x,y,foldid=foldid,alpha=0)

par(mfrow=c(2,2))
plot(cv1)
plot(cv.5)
plot(cv0)
plot(log(cv1$lambda),cv1$cvm,pch=19,col="red",xlab="log(Lambda)",ylab=cv1$name)
points(log(cv.5$lambda),cv.5$cvm,pch=19,col="grey")
points(log(cv0$lambda),cv0$cvm,pch=19,col="blue")
legend("topleft",legend=c("alpha = 1","alpha = 0.5","alpha = 0"),pch=19,col=c("red","grey","blue"))

# to find the suitable range of lambda
fit <- cv.glmnet(x, y, family="multinomial", type.multinomial = "grouped", alpha = 1)
plot(fit)
