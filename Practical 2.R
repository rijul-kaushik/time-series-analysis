#Load the library
library(datasets)

#Load the Nottem dataset
data("nottem")

#View dataset
nottem

#View description
?nottem

#Display key characteristics
start(nottem)
end(nottem)
frequency(nottem)
class(nottem)

#Sampling frequency explanation
# Frequency = 12 → Monthly data (12 observations per year)

#Plot the time series
plot(nottem,
     main = "Average Monthly Air Temperatures (Nottingham)",
     xlab = "Year",
     ylab = "Temperature (°F)",
     col = "blue",
     lwd = 2)