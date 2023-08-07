library(dplyr)
library(leaps)
library(MASS)
library(car)
library(lmtest)
library(qpcR)
setwd('C:/Users/ADMIN/Desktop/국민대 3학년1학기/회귀분석/[회귀분석][기말프로젝트][경제학과20200856정가연]')
dat <- read.csv('Hn19_all.csv',header=T)
model <- dat[,c('EQ5D','cfam','L_OUT_FQ','BS3_1','BP1','BP16_1','BP16_2',
                'LF_S4','DI1_2','DI2_2','DJ4_3','BE3_31')]
#데이터 처리전 표본 개수
nrow(model)
#모름,무응답은 결측치로 간주하고 제거
model = model %>% filter(cfam != 9)
model = model %>% filter(L_OUT_FQ != 9)
model = model %>% filter(BS3_1 != 9)
model = model %>% filter(BP1 != 8)
model = model %>% filter(BP1 != 9)
model = model %>% filter(BP16_1 != 88)
model = model %>% filter(BP16_1 != 99)
model = model %>% filter(BP16_2 != 88)
model = model %>% filter(BP16_2 != 99)
model = model %>% filter(LF_S4 != 4)
model = model %>% filter(LF_S4 != 9)
model = model %>% filter(DI1_2 != 9)
model = model %>% filter(DI2_2 != 9)
model = model %>% filter(DJ4_3 != 9)
model = model %>% filter(BE3_31 != 88)
model = model %>% filter(BE3_31 != 99)
#Missing Value(결측치 제거)
model <- na.omit(model)
# 전처리 후 데이터 개수
nrow(model)

#3.탐색적 분석

#3-1) 변수선택 기준

model = model %>% filter(cfam == 1)
nrow(model)
#변수 정의
Y <- model$EQ5D
X1 <- model$L_OUT_FQ 
X2 <- model$BS3_1
X3 <- model$BP1
X4 <- model$BP16_1
X5 <- model$BP16_2
X6 <- model$LF_S4
X7 <- model$DI1_2
X8 <- model$DI2_2
X9 <- model$DJ4_3
X10 <- model$BE3_31
#Full_model
Full_model <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+BP16_1+BP16_2+LF_S4+DI1_2+DI2_2+DJ4_3+BE3_31, data = model)
Full_model <- lm(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9+X10)
summary(Full_model)
#[adj_R2]
model_reg <- model[,c('EQ5D','L_OUT_FQ','BS3_1','BP1','BP16_1','BP16_2',
                      'LF_S4','DI1_2','DI2_2','DJ4_3','BE3_31')]
regfit_sel <- regsubsets(x=EQ5D~.,data=model_reg,method = 'exhaustive',nbest=10)
summary(regfit_sel)
result_regfit <- summary(regfit_sel)
result_regfit$adjr2
#plot of adj_R2
plot(result_regfit$adjr2,ylim=c(0,1),pch=10,cex=2,ylab="adj_R2",xlab="model",type="b")
# final model
final_model_R2 <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+LF_S4+DI2_2+BE3_31, data = model_reg)
summary(final_model_R2)
# comparison with null model using partial-F test
null_model_R2 <- lm(EQ5D ~ 1,data=model_reg)
anova(final_model_R2,null_model_R2)
#[Mallows-cp]
result_regfit$cp
# plot of Mallows-cp
plot(result_regfit$cp,pch=10,cex=2,ylab="Mallows-Cp",xlab="model",type="b")
# final model
final_model_cp <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+BP16_2+LF_S4+DI2_2+DJ4_3+BE3_31, data = model_reg)
summary(final_model_cp)
# comparison with null model using partial-F test
null_model_cp <- lm(EQ5D ~ 1,data=model_reg)
anova(final_model_cp,null_model_R2)
#[BIC]
result_regfit$bic
# plot of BIC
plot(result_regfit$bic,pch=10,cex=2,ylab="BIC",xlab="model",type="b")
# final model
final_model_bic <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+BP16_2+LF_S4+DI2_2+DJ4_3+BE3_31, data = model_reg)
summary(final_model_bic)
# comparison with null model using partial-F test
null_model_bic <- lm(EQ5D ~ 1,data=model_reg)
anova(final_model_bic,null_model_R2)

#3-2) 변수선택 방법

#[stepwise]
null_model <- lm(EQ5D ~ 1,data=model)
step(null_model, scope = ~ L_OUT_FQ+BS3_1+BP1+BP16_1+BP16_2+LF_S4+DI1_2+DI2_2+DJ4_3+BE3_31,direction="both",test="F")
#[forward]
null_model <- lm(EQ5D ~ 1,data=model)
step(null_model, scope = ~ L_OUT_FQ+BS3_1+BP1+BP16_1+BP16_2+LF_S4+DI1_2+DI2_2+DJ4_3+BE3_31,direction="forward",test="F")
#[backward]
Full_model <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+BP16_1+BP16_2+LF_S4+DI1_2+DI2_2+DJ4_3+BE3_31, data = model)
step(Full_model,direction="backward",test="F")

#3) 회귀모형 진단 및 수정

#[부분F검정]
#Full_model
Full_model <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+BP16_1+BP16_2+LF_S4+DI1_2+DI2_2+DJ4_3+BE3_31, data = model)
Full_model <- lm(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9+X10)
Y_hat_F <- predict(Full_model, newdata = data.frame(X1=X1,X2=X2,X3=X3,X4=X4,X5=X5,X6=X6,X7=X7,X8=X8,X9=X9,X10=X10))
SST <- sum((Y-mean(Y))^2);SST
SSR_F <- sum((Y_hat_F-mean(Y))^2);SSR_F
SSE_F <- sum((Y-Y_hat_F)^2);SSE_F
MSR_F <- SSR_F/(11-1);MSR_F
MSE_F <- SSE_F/(676-11);MSE_F
F0_F <- MSR_F/MSE_F;F0_F
pf(F0_F,df1=11-1,df2=676-11,lower.tail=F)
#Reduced_model - X1,X2,X3,X6,X8,X10 유의
Reduced1_model <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+LF_S4+DI2_2+BE3_31, data = model)
Reduced1_model <- lm(Y~X1+X2+X3+X6+X8+X10)
Y_hat_R <- predict(Reduced1_model, newdata = data.frame(X1=X1,X2=X2,X3=X3,X6=X6,X8=X8,X10=X10))
SST <- sum((Y-mean(Y))^2);SST
SSR_R <- sum((Y_hat_R-mean(Y))^2);SSR_R
SSE_R <- sum((Y-Y_hat_R)^2);SSE_R
MSR_R <- SSR_R/(7-1);MSR_R
MSE_R <- SSE_R/(676-7);MSE_R
F0_R <- MSR_R/MSE_R;F0_R
pf(F0_R,df1=7-1,df2=263-7,lower.tail=F)
#Calculation of F0
R_b2b1 <- SSE_R - SSE_F ; R_b2b1
F0 <- (R_b2b1/(11-7))/(SSE_F/(676-11)) ; F0
pf(F0,df1=11-7,df2=676-11,lower.tail=F)
anova(Reduced1_model,Full_model)
#Reduced_model2 - X1,X2,X3,X6,X7,X10 유의
Reduced2_model <- lm(EQ5D~L_OUT_FQ+BS3_1+BP1+LF_S4+DI1_2+BE3_31, data = model)
Reduced2_model <- lm(Y~X1+X2+X3+X6+X7+X10)
summary(Reduced1_model)
Y_hat_R <- predict(Reduced1_model, newdata = data.frame(X1=X1,X2=X2,X3=X3,X6=X6,X7=X7,X10=X10))
SST <- sum((Y-mean(Y))^2);SST
SSR_R <- sum((Y_hat_R-mean(Y))^2);SSR_R
SSE_R <- sum((Y-Y_hat_R)^2);SSE_R
MSR_R <- SSR_R/(7-1);MSR_R
MSE_R <- SSE_R/(676-7);MSE_R
F0_R <- MSR_R/MSE_R;F0_R
pf(F0_R,df1=7-1,df2=263-7,lower.tail=F)
#Calculation of F0
R_b2b1 <- SSE_R - SSE_F ; R_b2b1
F0 <- (R_b2b1/(11-7))/(SSE_F/(676-11)) ; F0
pf(F0,df1=11-7,df2=676-11,lower.tail=F)
anova(Reduced2_model,Full_model)
#[편회귀그림]
#X1의 편회귀그림
model236810 <- lm(Y~X2+X3+X6+X8+X10);model236810
modelX236810 <- lm(X1~X2+X3+X6+X8+X10);modelX236810
y.X2X3X6X8X10 <- resid(model236810)
X1.X2X3X6X8X10 <- resid(modelX236810)
plot(X1.X2X3X6X8X10,y.X2X3X6X8X10,pch=16,cex=2,xlab="X1|X2,X3,X6,X8,X10",ylab="Y|X2,X3,X6,X8,X10")
model_parX1 <- lm(y.X2X3X6X8X10~X1.X2X3X6X8X10) ; model_parX1
abline(model_parX1,col='red',lwd=2)
cor.test(X1.X2X3X6X8X10,y.X2X3X6X8X10)
#X2의 편회귀그림
model136810 <- lm(Y~X1+X3+X6+X8+X10);model136810
modelX136810 <- lm(X2~X1+X3+X6+X8+X10);modelX136810
y.X1X3X6X8X10 <- resid(model136810)
X2.X1X3X6X8X10 <- resid(modelX136810)
plot(X2.X1X3X6X8X10,y.X1X3X6X8X10,pch=16,cex=2,xlab="X2|X1,X3,X6,X8,X10",ylab="Y|X1,X3,X6,X8,X10")
model_parX2 <- lm(y.X1X3X6X8X10~X2.X1X3X6X8X10) ; model_parX2
abline(model_parX2,col='red',lwd=2)
cor.test(X2.X1X3X6X8X10,y.X1X3X6X8X10)
#X3의 편회귀그림
model126810 <- lm(Y~X1+X2+X6+X8+X10);model126810
modelX126810 <- lm(X3~X1+X2+X6+X8+X10);modelX126810
y.X1X2X6X8X10 <- resid(model126810)
X3.X1X2X6X8X10 <- resid(modelX126810)
plot(X3.X1X2X6X8X10,y.X1X2X6X8X10,pch=16,cex=2,xlab="X3|X1,X2,X6,X8,X10",ylab="Y|X1,X2,X6,X8,X10")
model_parX3 <- lm(y.X1X2X6X8X10~X3.X1X2X6X8X10) ; model_parX3
abline(model_parX3,col='red',lwd=2)
cor.test(X3.X1X2X6X8X10,y.X1X2X6X8X10)
#X6의 편회귀그림
model123810 <- lm(Y~X1+X2+X3+X8+X10);model123810
modelX123810 <- lm(X6~X1+X2+X3+X8+X10);modelX123810
y.X1X2X3X8X10 <- resid(model123810)
X6.X1X2X3X8X10 <- resid(modelX123810)
plot(X6.X1X2X3X8X10,y.X1X2X3X8X10,pch=16,cex=2,xlab="X6|X1,X2,X3,X8,X10",ylab="Y|X1,X2,X3,X8,X10")
model_parX6 <- lm(y.X1X2X3X8X10~X6.X1X2X3X8X10) ; model_parX6
abline(model_parX6,col='red',lwd=2)
cor.test(X6.X1X2X3X8X10,y.X1X2X3X8X10)
#X8의 편회귀그림
model123610 <- lm(Y~X1+X2+X3+X6+X10);model123610
modelX123610 <- lm(X8~X1+X2+X3+X6+X10);modelX123610
y.X1X2X3X6X10 <- resid(model123610)
X8.X1X2X3X6X10 <- resid(modelX123610)
plot(X8.X1X2X3X6X10,y.X1X2X3X6X10,pch=16,cex=2,xlab="X8|X1,X2,X3,X6,X10",ylab="Y|X1,X2,X3,X6,X10")
model_parX8 <- lm(y.X1X2X3X6X10~X8.X1X2X3X6X10) ; model_parX8
abline(model_parX8,col='red',lwd=2)
cor.test(X8.X1X2X3X6X10,y.X1X2X3X6X10)
#X10의 편회귀그림
model12368 <- lm(Y~X1+X2+X3+X6+X8);model12368
modelX12368 <- lm(X10~X1+X2+X3+X6+X8);modelX12368
y.X1X2X3X6X8 <- resid(model12368)
X10.X1X2X3X6X8 <- resid(modelX12368)
plot(X10.X1X2X3X6X8,y.X1X2X3X6X8,pch=16,cex=2,xlab="X10|X1,X2,X3,X6,X8",ylab="Y|X1,X2,X3,X6,X8")
model_parX10 <- lm(y.X1X2X3X6X8~X10.X1X2X3X6X8) ; model_parX10
abline(model_parX10,col='red',lwd=2)
cor.test(X10.X1X2X3X6X8,y.X1X2X3X6X8)
#[적합결여검정]
# H0 : E(y) = b0+b1*x1 VS Ha : E(y) != b0+b1*x1 ->적합X
fit.lm1 <- lm(Y ~ X1)
fit.pe1 <- lm(Y ~ factor(X1))
anova(fit.lm1,fit.pe1)
# H0 : E(y) = b0+b2*x2 VS Ha : E(y) != b0+b2*x2 -> 적합O
fit.lm2 <- lm(Y ~ X2)
fit.pe2 <- lm(Y ~ factor(X2))
anova(fit.lm2,fit.pe2)
# H0 : E(y) = b0+b3*x3 VS Ha : E(y) != b0+b3*x3 -> 적합X
fit.lm3 <- lm(Y ~ X3)
fit.pe3 <- lm(Y ~ factor(X3))
anova(fit.lm3,fit.pe3)
# H0 : E(y) = b0+b6*x6 VS Ha : E(y) != b0+b6*x6 -> 적합O
fit.lm6 <- lm(Y ~ X6)
fit.pe6 <- lm(Y ~ factor(X6))
anova(fit.lm6,fit.pe6)
# H0 : E(y) = b0+b8*x8 VS Ha : E(y) != b0+b8*x8 -> 적합O
fit.lm8 <- lm(Y ~ X8)
fit.pe8 <- lm(Y ~ factor(X8))
anova(fit.lm8,fit.pe8)
# H0 : E(y) = b0+b10*x10 VS Ha : E(y) != b0+b10*x10 -> 적합X
fit.lm10 <- lm(Y ~ X10)
fit.pe10 <- lm(Y ~ factor(X10))
anova(fit.lm10,fit.pe10)
#Reduced3_model
Reduced3_model <- lm(Y ~ X2 + X6 + X8)
summary(Reduced3_model)
par(mfrow=c(2,2))
plot(Reduced3_model)
#[변수변환]
# √Y transformation
Y_sqrt <- sqrt(Y)
Reduced3_model_sqrt <- lm(Y_sqrt ~ X2 + X6 + X8)
summary(Reduced3_model_sqrt)
par(mfrow=c(2,2))
plot(Reduced3_model_sqrt)

#4.회귀 모형 선택

#4-1) 모형 검정

#[다중공선성 탐색]
vif(Reduced3_model)
#[영향력 측도]
#Cook's distance
par(mfrow=c(1,1))
cooks.distance(Reduced3_model)
tail(Reduced3_model)
n <- 250
p <- 4
cook_standard <- 3.67 / (n-p) ; cook_standard
plot(cooks.distance(Reduced3_model),pch=16,ylab="cooks distance")
abline(h=cook_standard,col="red",lty=2)
#DFFITS
DFFITS_standard <- 2*sqrt(p/n);DFFITS_standard
plot(dffits(Reduced3_model),pch=19,ylab="DFFITS")
abline(h=DFFITS_standard,col="red",lty=2)
abline(h=-DFFITS_standard,col="red",lty=2)
#COVRATIOS
COVRATIO_standard <- 3*p/n;COVRATIO_standard
plot(abs(covratio(Reduced3_model)-1),pch=19,ylab="|COVRATIO-1|")
abline(h=COVRATIO_standard,col="red",lty=2)
#전체 영향력 측도 확인
options(max.print=1000000)
influence.measures(Reduced3_model)
#이상치 제외한 model
final_model <- model[-c(6, 22, 25, 29, 65, 82, 84, 100, 103, 104, 107, 109, 138, 157, 159, 162, 169, 170,
                           172, 174, 179, 192, 201, 238, 251, 252, 299,300, 308, 310, 312, 317, 320, 331,
                           335, 339, 347, 350, 363, 364, 380, 400, 406, 441, 452, 453, 463, 497, 525, 529, 530,
                           536, 539, 546, 556, 570, 581, 588, 634, 639, 650, 657, 660),]
Final_model <- lm(Y ~ X2 + X6 + X8)
#[더빈-왓슨 검정]
dwtest(Final_model)

#4-2)최종 모형 결정
set.seed(1234)
rn <- sample(x=c(1:613), size = 613, replace=F);rn
final_model$rn <- rn
train_dat <- final_model[final_model$rn>184,]
test_dat <- final_model[final_model$rn<=184,]
dim(train_dat)
dim(test_dat)
#predicted error
train_model <- lm(EQ5D~BS3_1+LF_S4+DI2_2,data=train_dat);summary(train_model)
predict_value <- predict(train_model,newdata = test_dat[,c('BS3_1','LF_S4','DI2_2')])
predict_error <- sum((test_dat$sales-predict_value)^2);predict_error
#PRESS
last_model <- lm(EQ5D~BS3_1+LF_S4+DI2_2,data=final_model)
PRESS_last <- PRESS(last_model)
PRESS_last$stat
#SST, SSE, SSR
SST <- sum((final_model$EQ5D-mean(final_model$EQ5D))^2)
SSE <- sum(resid(last_model)^2)  
SSR <- SST-SSE
#PRESS VS SSE
PRESS_last$stat
SSE
#R2 VS R2_predic
1-(SSE/SST) 
1-(PRESS_last$stat/SST)

#최종모형
plot(x=final_model$BS3_1,y=final_model$EQ5D,xlab='현재흡연 여부',ylab='건강관련 삶의 질 지수')
model2 <- lm(final_model$EQ5D~final_model$BS3_1)
abline(model2, col='red', lwd=2)

plot(x=final_model$LF_S4,y=final_model$EQ5D,xlab='식비가 부족하여 균형잡힌 식사를 할 수 없던 경험',ylab='건강관련 삶의 질 지수')
model2 <- lm(final_model$EQ5D~final_model$LF_S4)
abline(model2, col='red', lwd=2)

plot(x=final_model$DI2_2,y=final_model$EQ5D,xlab='이상지질혈증 약복용',ylab='건강관련 삶의 질 지수')
model2 <- lm(final_model$EQ5D~final_model$DI2_2)
abline(model2, col='red', lwd=2)

