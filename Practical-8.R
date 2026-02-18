# (f) Load and convert to time series object
data(AirPassengers)
ap_ts <- AirPassengers

# Display basic information
print(class(ap_ts))
print(start(ap_ts))
print(end(ap_ts))
print(frequency(ap_ts))

# (g) Plot the data
plot(ap_ts,
     main = "Monthly Airline Passengers (1949–1960)",
     xlab = "Year",
     ylab = "Passengers",
     col = "blue")

# (h) Decompose the data (Multiplicative)
decomp_ap <- decompose(ap_ts, type = "multiplicative")
plot(decomp_ap)

# (i) ACF and PACF of original series
par(mfrow=c(1,2))
acf(ap_ts, main="ACF of Original Series")
pacf(ap_ts, main="PACF of Original Series")
par(mfrow=c(1,1))

# (j) KPSS Test
if(!require(tseries)) install.packages("tseries")
library(tseries)
print(kpss.test(ap_ts))

# (k) Make data stationary
# Log transformation (variance stabilization)
log_ap <- log(ap_ts)

# Seasonal differencing
diff_seasonal <- diff(log_ap, lag=12)

# First differencing
ap_stationary <- diff(diff_seasonal)

# Plot stationary series
plot(ap_stationary,
     main="Stationary Series after Log + Seasonal + First Differencing")

# Check stationarity again
par(mfrow=c(1,2))
acf(ap_stationary, main="ACF of Stationary Series")
pacf(ap_stationary, main="PACF of Stationary Series")
par(mfrow=c(1,1))

print(kpss.test(ap_stationary))

# (l) Select suitable technique → SARIMA

# (m) Fit model using auto.arima
if(!require(forecast)) install.packages("forecast")
library(forecast)

model_ap <- auto.arima(ap_ts)

# Display model summary
summary(model_ap)

# (n) Goodness of fit

# Residual plot
ts.plot(residuals(model_ap),
        main="Residuals of Fitted Model")

# ACF of residuals
acf(residuals(model_ap),
    main="ACF of Residuals")

# Ljung-Box Test
print(Box.test(residuals(model_ap), type="Ljung-Box"))

# Forecast next 12 months
forecast_ap <- forecast(model_ap, h=12)
plot(forecast_ap