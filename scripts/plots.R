library(ggplot2)
library(dplyr)

build_yearly_plot <- function(df_yearly, countries, baseline_year, target_year) {
  
  plot_data <- df_yearly |>
    filter(
      Country %in% countries,
      year >= baseline_year,
      year <= target_year
    ) |>
    group_by(Country) |>
    mutate(
      avg_temp_centered = avg_temp - mean(avg_temp, na.rm = TRUE)
    ) |>
    ungroup()
  
  if (nrow(plot_data) == 0) {
    return(NULL)
  }
  
  ggplot(
    plot_data,
    aes(
      x = year,
      y = avg_temp_centered,
      color = Country,
      group = Country
    )
  ) +
    geom_line() +
    geom_point() +
    labs(
      title = "Centered Yearly Average Temperature",
      x = "Year",
      y = "Centered Avg Temp (°C)",
      color = "Country"
    ) +
    theme_minimal()
}


build_diff_plot <- function(df_monthly_diff) {
  
  ggplot(
    df_monthly_diff,
    aes(
      x = month,
      y = AvgTemp_diff,
      color = Country,
      group = Country
    )
  ) +
    geom_line() +
    geom_point() +
    scale_x_continuous(
      breaks = 1:12,
      labels = month.abb,
      limits = c(1, 12)
    ) +
    labs(
      title = "Difference in Monthly Temperatures between Selected Years",
      x = "Month",
      y = "Monthly Avg Temp Difference (°C)",
      color = "Country"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = -35, hjust = 0)
    )
}