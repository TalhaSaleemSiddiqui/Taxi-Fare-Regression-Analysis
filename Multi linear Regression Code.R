taxi_data <- data.frame(
  Observation_ID = 1:30,
  Fare_USD = c(101.42, 41.34, 45.14, 76.92, 117.7, 96.62, 92.08, 46.66, 91.8, 74.42, 108.09, 79.19, 114.14, 42.02, 98.92, 78.89, 69.33, 64.09, 109, 25.33, 75.25, 107.2, 55.51, 80.99, 79.82, 29.54, 87.81, 65.64, 39.27, 80.87),
  Trip_Distance_km = c(32.1, 4.9, 16.1, 19.5, 39.3, 39.4, 38.7, 16.2, 33, 32.4, 37.6, 32.1, 34.7, 2.3, 34.4, 33.3, 21.6, 20.2, 33.7, 1.3, 28.8, 38.9, 15.9, 32.8, 25.7, 3.7, 27.2, 26.5, 11.8, 24.5),
  Waiting_Time_min = c(62, 66, 13, 68, 78, 14, 1, 21, 16, 3, 45, 8, 77, 80, 60, 9, 42, 46, 66, 40, 27, 44, 32, 9, 47, 28, 61, 3, 16, 65),
  Night_Ride = c(1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0),
  Passenger_Count = c(3, 3, 4, 5, 1, 3, 3, 2, 5, 2, 5, 4, 2, 3, 5, 2, 4, 1, 5, 2, 3, 5, 2, 5, 1, 3, 3, 4, 3, 3)
)
par(mfrow = c(2, 2))
plot(x = taxi_data$Trip_Distance_km, y = taxi_data$Fare_USD,
     main = "Fare vs Trip Distance",
     xlab = "Trip Distance (km) [X1]", 
     ylab = "Fare (USD) [Y]",
     col = "black", pch = 16)
plot(x = taxi_data$Waiting_Time_min, y = taxi_data$Fare_USD,
     main = "Fare vs Waiting Time",
     xlab = "Waiting Time (min) [X2]", 
     ylab = "Fare (USD) [Y]",
     col = "red", pch = 16)
plot(x = taxi_data$Night_Ride, y = taxi_data$Fare_USD,
     main = "Fare vs Night Ride",
     xlab = "Night Ride (0 or 1) [X3]", 
     ylab = "Fare (USD) [Y]",
     col = "darkgreen", pch = 16)
plot(x = taxi_data$Passenger_Count, y = taxi_data$Fare_USD,
     main = "Fare vs Passenger Count",
     xlab = "Passenger Count [X4]", 
     ylab = "Fare (USD) [Y]",
     col = "purple", pch = 16)
par(mfrow = c(1, 1))
cor_X1 <- cor(taxi_data$Fare_USD, taxi_data$Trip_Distance_km)
cat("1. Correlation with Trip Distance (X1):", cor_X1, "\n")
cor_X2 <- cor(taxi_data$Fare_USD, taxi_data$Waiting_Time_min)
cat("2. Correlation with Waiting Time (X2):", cor_X2, "\n")
cor_X3 <- cor(taxi_data$Fare_USD, taxi_data$Night_Ride)
cat("3. Correlation with Night Ride (X3):", cor_X3, "\n")
cor_X4 <- cor(taxi_data$Fare_USD, taxi_data$Passenger_Count)
cat("4. Correlation with Passenger Count (X4):", cor_X4, "\n")
fit <- lm(Fare_USD ~ Trip_Distance_km + Waiting_Time_min + Night_Ride + Passenger_Count, data = taxi_data)
fit
fit$coefficients
summary(fit)
sum(residuals(fit))
adj_r_squared <- summary(fit)$adj.r.squared
cat("Adjusted R-squared:", adj_r_squared, "\n\n")
predicted_y <- predict(fit)
comparison_table <- data.frame(
  Observation = 1:30,
  Actual_Fare = taxi_data$Fare_USD,
  Predicted_Fare = round(predicted_y, 2))
