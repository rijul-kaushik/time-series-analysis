#LOad dataset
data("nottem")

#Convert to time series
nottem_ts <- ts(nottem, frequency = 12)

#Plotting and decomposition
plot(nottem_ts, main="Nottem Time Series")
nottem_dec <- decompose(nottem_ts)
plot(nottem_dec)

#ALL THE SAME STEPS FOR AIRPASSENGERS DATASET
data(AirPassengers)
ap_ts <- ts(AirPassengers, frequency=12)
plot(ap_ts, main="AirPassengers Time Series")
ap_dec <- decompose(ap_ts)
plot(ap_dec)
