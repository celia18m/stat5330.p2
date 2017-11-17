library(e1071) ## parameter tunning 
library(caret) ## parameter tunning 
library(ranger) ## randomforest

set.seed(21)
train_control <- trainControl(method = "cv", number = 10, repeats = 20, verboseIter = FALSE)

# Random forest
mtryGrid = expand.grid(.mtry = c(3,5), .splitrule="gini", .min.node.size = 1)
rf_model <- train(
  type ~ .,
  tuneLength = 3,
  data = newtrain, 
  method = "ranger", 
  trControl = train_control, # 10-fold cross validation 
  importance = 'impurity',
  tuneGrid = mtryGrid
)
# pred.rf <- predict(rf_model, newtest)
# 
# submission <- data.frame(id, pred.rf)
# colnames(submission) = c('id','type')
# write.csv(submission, 'submission.csv', row.names=FALSE)


# glmnet
glm_model = train(
  type ~ .,
  tuneLength = 3, #  defines the total number of parameter combinations that will be evaluated.
  data = newtrain, 
  method = 'glmnet',
  trControl = train_control, # 10-fold cross  validation 
  tuneGrid = expand.grid(alpha = 1,
                         lambda = runif(50, 0.01, exp(-4)))
)
pred.glm <- predict(glm_model, newtest)

submission <- data.frame(id, pred.glm)
colnames(submission) = c('id','type')
write.csv(submission,'submission.csv',row.names=FALSE)


# library(nnet)
# # logistic
# log_model = train(
#   type ~ ., #  defines the total number of parameter combinations that will be evaluated.
#   data = newtrain, 
#   method = "multinom",
#   trControl = train_control # 10-fold cross  validation 
# )
# pred.log <- predict(log_model, newtest)
# 
# submission <- data.frame(id, pred.log)
# colnames(submission) = c('id','type')
# write.csv(submission,'submission.csv',row.names=FALSE)

# LDA
lda_model <- train(
  type ~ .,
  data = newtrain, 
  method = "lda", 
  trControl = train_control
)
# pred.lda <- predict(lda_model, newtest)
# 
# submission <- data.frame(id, pred.lda)
# colnames(submission) = c('id','type')
# write.csv(submission, 'submission.csv', row.names=FALSE)


library(gbm)
# GBM
gbm_model <- train(
  type ~ .,
  data = newtrain,
  method = "gbm",
  metric = "Accuracy",
  trControl = train_control,
  verbose = FALSE
)
# pred.gbm <- predict(gbm_model, newtest)
# 
# submission <- data.frame(id, pred.gbm)
# colnames(submission) = c('id','type')
# write.csv(submission, 'submission.csv', row.names=FALSE)


# SVM
costGrid = expand.grid(.cost = 2^seq(-6, -4, by = .1))
svm_model <- train(
  type ~ .,
  tuneLength = 3,
  data = newtrain, 
  method = "svmLinear2", 
  trControl = train_control, # 10-fold cross validation 
  tuneGrid = costGrid
)
# pred.svm <- predict(svm_model, newtest)
# 
# submission <- data.frame(id, pred.svm)
# colnames(submission) = c('id','type')
# write.csv(submission, 'submission.csv', row.names=FALSE)


comp <- resamples(list(RandomForest = rf_model, Logistic = glm_model, LDA = lda_model, GBM = gbm_model, SVM = svm_model))
bwplot(comp) 
