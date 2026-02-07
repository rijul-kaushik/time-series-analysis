#Load the Dataset
data("AirPassengers")

#Convert data to time series object
ap_ts <- ts(AirPassengers, start = c(1949,1), frequency = 12)
ap_ts

#Plotting the data
plot(ap_ts,
     main = "AirPassengers Time Series",
     xlab = "Year",
     ylab = "Passengers",
     col = "blue",
     lwd = 2)

#Decomposing the data
ap_decomp <- decompose(ap_ts)
plot(ap_decomp)

#Check stationary using ACF/PACF
acf(ap_ts, main = "ACF Plot")
pacf(ap_ts, main = "PACF Plot")

#Doing ADF test
install.packages("tseries")
library(tseries)
adf.test(ap_ts)

