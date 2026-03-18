rm(list=ls(all=TRUE))

library(tseries)
library(forecast)

# Step 1: Data
data("AirPassengers")
ap_ts <- ts(AirPassengers, start=c(1949,1), frequency=12)

plot(ap_ts,
     main="Monthly Airline Passenger Data",
     ylab="Passengers",
     col="blue",
     lwd=2)

# Step 2: Decomposition
ap_dec <- decompose(ap_ts, type="multiplicative")
plot(ap_dec)

# Step 3: Stationarity Check
acf(ap_ts)
pacf(ap_ts)
kpss.test(ap_ts)

# Step 4: Log Transformation
ap_log <- log(ap_ts)
plot(ap_log)

# Step 5: Holt-Winters Models
hw_double <- HoltWinters(ap_log, gamma=FALSE)
hw_double$SSE

hw_triple <- HoltWinters(ap_log)
hw_triple$SSE
plot(hw_triple)

# Step 6: Forecasting
ap_forecast <- forecast(hw_triple, h=12)
ap_forecast

plot(ap_forecast,
     main="12-Month Forecast")

forecast_original <- exp(ap_forecast$mean)
forecast_original