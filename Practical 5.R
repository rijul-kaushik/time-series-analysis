#Importing data from text and checking
loan_data <- read.table("bank_case.txt", header=TRUE)
head(loan_data)

#Convert to Time Series
loan_ts <- ts(loan_data[,1], start = c(2015, 1), frequency = 12)
loan_ts

# Plotting the time series loan_ts
plot(loan_ts,
    main = "Monthly Commercial Real Estate Loans",
    xlab = "Time",
    ylab = "Loan Volume",
    col = "blue",
    lwd = 2)

# ACF plot
acf(loan_ts, main = "ACF Plot")

# PACF plot
pacf(loan_ts, main = "PACF Plot")

# Load already installed packages
library(tseries)

# ADF test
adf_result <- adf.test(loan_ts)

print(adf_result)
