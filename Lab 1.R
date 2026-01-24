#installing readxl package to read excel file in the same directory as code
install.packages("readxl")
library(readxl) #loading the package

#read excel file and check the data
us_pop <- read_excel("US_Population.xlsx")
us_pop

#calling package for time series analysis
library(stats)

#converting data into time series object
us_pop[[1]] #extract the population column
us_ts <- ts(us_pop[[1]], start = 1790, frequency = 10) #create time series
us_ts #check time series

#plotting the time series
plot(us_ts,
     main = "US Population Growth",
     xlab = "Year",
     ylab = "Population")
