# imports ----------------------------------------------------------------

library(dplyr)
library(readr)
library(lubridate)

# Processing function ----------------------------------------------------

process_and_save_data <- function(
    raw_path = "data/GlobalLandTemperaturesByCountry.csv",
    output_dir = "data"
) {
  
  # Ensure output directory exists
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  
  # Read raw data
  df <- read_csv(raw_path)
  
  # Convert date column
  df$dt <- as.Date(df$dt)
  
  # Extract year and month
  df <- df |>
    mutate(
      year = year(dt),
      month = month(dt)
    )
  
  # Filter timeframe
  df <- df |>
    filter(year >= 1860)
  
  # Standardize column names
  df_processed <- df |>
    rename(
      AvgTemp = AverageTemperature,
      AvgUncertain = AverageTemperatureUncertainty,
      country = Country
    ) |>
    mutate(
      season = case_when(
        month %in% c(12, 1, 2) ~ "Winter",
        month %in% c(3, 4, 5) ~ "Spring",
        month %in% c(6, 7, 8) ~ "Summer",
        TRUE ~ "Fall"
      )
    ) |>
    select(year, month, country, AvgTemp, AvgUncertain, season)
  
  cat("Saving processed data...\n")
  
  # Save as RDS
  saveRDS(df_processed, file.path(output_dir, "df_processed.rds"))
}

# Run script -------------------------------------------------------------

process_and_save_data()