#co2 is a dataset about how Mauna Loa Atmospheric CO2 changed on a monthly basis from 1959 to 1997. It is expressed in parts per million#
#The purpose of this coursework is to move us from the theory to real world application of statistics

install.packages("prophet")

# Load libraries
library(prophet)
library(zoo)

# **co2: Monthly Atmospheric CO2 concentrations at Mauna Loa Observatory**
data(co2)
time_values = time(co2)
co2_dates = as.Date(as.yearmon(time_values))

# **Creating a professional dataframe for Prophet**
co2_dataframe = data.frame(ds = co2_dates, y = as.numeric(co2))

# **Modelling**
co2_model = prophet(co2_dataframe)

# **Forecasting 8 periods ahead**
future_data = make_future_dataframe(co2_model, periods = 8)
forecast_results = predict(co2_model,future_data)

# **Visualisation**
plot(co2_model, forecast_results)

# **Visualising the linear regression trend line over the original data**
co2_linear_model = lm(y ~ ds, data = co2_dataframe)
summary(co2_linear_model)
plot(co2_dataframe$ds, co2_dataframe$y, type = "l",
     main = "CO2 Concentrations with Linear Trend",
     xlab = "Year", ylab = "CO2 (ppm)")
abline(co2_linear_model, col = "red", lwd = 2)






