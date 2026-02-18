#Import Data as Time Series Object
year <- 1970:1990

population <- c(3929214, 5308483, 7239881, 9638453, 12860702,
                17063353, 23191876, 31443321, 38558371, 50189209,
                62979666, 76212168, 92228496, 106021537, 123202624,
                132164569, 151325798, 179323175, 203302031,
                226542203, 248709873)

# Scale to millions for readability
population_millions <- population / 1e6

us_ts <- ts(population_millions, start = 1970, frequency = 1)

us_ts


#Identify Dominating Component
plot(us_ts,
     main="US Population Time Series",
     xlab="Year",
     ylab="Population (Millions)",
     col="blue",
     lwd=2)

# The series shows continuous upward movement.
# Therefore, Trend is the dominant component.



#Square Root Transformation
us_sqrt <- sqrt(us_ts)

plot(us_sqrt,
     main="Square Root Transformed Series",
     xlab="Year",
     ylab="Sqrt(Population in Millions)")


#Estimate Linear Trend

time_index <- time(us_ts)

trend_model <- lm(us_ts ~ time_index)
summary(trend_model)

trend_values <- fitted(trend_model)

plot(us_ts,
     main="Linear Trend Estimation",
     xlab="Year",
     ylab="Population (Millions)")
lines(trend_values, col="red", lwd=2)


#Remove Linear Trend (Detrending)
detrended <- resid(trend_model)

plot(detrended,
     main="Detrended Series",
     xlab="Year",
     ylab="Detrended Population (Millions)")

detrended