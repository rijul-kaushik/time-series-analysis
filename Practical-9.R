rm(list=ls(all=TRUE))

install.packages("FinTS")
install.packages("tseries")
library(tseries)
library(forecast)
library(readr)
library(lmtest)
library(FinTS)

# Step 1: Data Import
bank_case <- read_csv("C:/Users/maths/Desktop/230957070 Rijul/TSA/5/bank_case.txt",
                      col_names = FALSE)
bank_case <- bank_case$X1
bank_ts <- ts(bank_case, frequency = 12)
bank_ts

# Step 2: Plot
plot(bank_ts,
     main="Commercial Bank Real Estate Loan Data",
     xlab="Time",
     ylab="Loans (Billions)",
     col="blue",
     lwd=2)

# Step 3: Stationarity Check
acf(bank_ts)
pacf(bank_ts)
adf.test(bank_ts)

# Step 4: Differencing
bank_d1 <- diff(bank_ts)
adf.test(bank_d1)

bank_d2 <- diff(bank_d1)
adf.test(bank_d2)

acf(bank_d2)
pacf(bank_d2)

# Step 5: Model Identification
fit1 <- arima(bank_ts, order=c(0,2,0))
fit2 <- arima(bank_ts, order=c(1,2,1))
fit3 <- arima(bank_ts, order=c(0,2,1))
fit4 <- arima(bank_ts, order=c(1,2,0))

AIC(fit1); AIC(fit2); AIC(fit3); AIC(fit4)

# Step 6: Model Estimation
bank_model <- arima(bank_ts, order=c(0,2,1), method="ML")
summary(bank_model)

# Step 7: Diagnostic Checking
res <- residuals(bank_model)

plot(res, type="l")
abline(h=0)

shapiro.test(res)
qqnorm(res); qqline(res, col="red")

Box.test(res, lag=10, type="Ljung-Box")
acf(res); pacf(res)

ArchTest(res)

acf(res^2)
pacf(res^2)

# Step 8: Forecasting
bank_forecast <- forecast(bank_model, h=20)
bank_forecast

plot(bank_forecast,
     main="20-Month Forecast",
     xlab="Time",
     ylab="Loans (Billions)")