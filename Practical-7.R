#set working directory and import dataset
setwd("C:/Users/maths/Desktop/230957070 Rijul/TSA/4")
loan_data <- scan("bank_case.txt")
loan_data

#converting data to time series object
loan_ts <- ts(loan_data,start = c(2000,1), frequency = 12)
loan_ts

#plotting the data and decomposing to find dominant component
plot(loan_ts, 
     main="Commercial Bank Transaction Loans",
     xlab="Year",
     ylab="Loans (in billions)",
     col="hotpink",
     lwd= 3)

decomp <- decompose(loan_ts)
plot(decomp)

#checking stationary or not using ACF and PACF
par(mfrow=c(1,2))
acf(loan_ts,main="ACF of Original Time Series")
pacf(loan_ts,main="PACF of Original Time Series")

#check stationary or not using adf test
library(tseries)
adf.test(loan_ts)

#make the data stationary
current_series <- loan_ts
d <- 0   # differencing order counter
repeat {
  adf_result <- adf.test(current_series)
  p_value <- adf_result$p.value
  
  cat("Differencing order =", d, " | p-value =", p_value, "\n")
  if (p_value < 0.05) {
    cat("Series is stationary at differencing order", d, "\n")
    break
  }
  current_series <- diff(current_series)
  d <- d + 1
  if (d == 5) {
    cat("Series did not become stationary after 5 differences\n")
    break
  }
}
#final stationary series
loan_stationary <- current_series

#automatically selecting model
library(forecast)
auto_model <- auto.arima(loan_ts)
summary(auto_model)

#fitting final model
final_model <- arima(loan_ts, order=c(0,2,1))
summary(final_model)


#goodness of fit
# 1. Residual Plot
ts.plot(residuals(final_model), 
        main = "Residuals of Final Model")
# 2. ACF of Residuals
acf(residuals(final_model), 
    main = "ACF of Residuals")
checkresiduals(final_model)
# 3. Ljung-Box Test
Box.test(residuals(final_model), 
         type = "Ljung-Box")


