library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

source("scripts/utils.R")
source("scripts/plots.R")


# Define Inputs -----------------------------------------------------------

country_selector <- selectizeInput(
  "country",
  "Select Country",
  choices = country_choices,
  selected = c("Canada", "Australia", "Mexico"),
  multiple = TRUE,
  options = list(
    plugins = list("remove_button")
  )
)

baseline_year_input <- numericInput(
  "baseline_year",
  "Select Reference Year:",
  value = 1950,
  min = min_year,
  max = max_year,
  step = 1,
  width = "100%"
)

target_year_input <- numericInput(
  "target_year",
  "Select Target Year:",
  value = 2000,
  min = min_year,
  max = max_year,
  step = 1,
  width = "100%"
)

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  titlePanel("TempTale for R"),
  
  sidebarLayout(
    sidebarPanel(
      country_selector,
      baseline_year_input,
      target_year_input,
      uiOutput("year_validation_ui")
    ),
    
    mainPanel(
      plotOutput("yearly_plot"),
      plotOutput("diff_plot")
      
    )
  )
)

# SERVER ------------------------------------------------------------------

server <- function(input, output, session) {
  
  output$yearly_plot <- renderPlot({
    
    req(input$country)
    req(input$baseline_year < input$target_year)
    
    build_yearly_plot(
      df_yearly,
      input$country,
      input$baseline_year,
      input$target_year
    )
    
  })
  
  
  output$diff_plot <- renderPlot({
    
    req(length(input$country) > 0)
    req(input$baseline_year < input$target_year)
    
    df_monthly_diff <- df_monthly |>
      filter(
        Country %in% input$country,
        year %in% c(input$baseline_year, input$target_year)
      ) |>
      select(Country, month, year, AvgTemp) |>
      tidyr::pivot_wider(
        id_cols = c(Country, month),
        names_from = year,
        values_from = AvgTemp
      ) |>
      mutate(
        AvgTemp_diff =
          .data[[as.character(input$target_year)]] -
          .data[[as.character(input$baseline_year)]]
      ) |>
      select(Country, month, AvgTemp_diff)
    
    validate(
      need(nrow(df_monthly_diff) > 0, "No monthly comparison data available.")
    )
    
    build_diff_plot(df_monthly_diff)
  })
  
}
  

# APP ---------------------------------------------------------------------

shinyApp(ui = ui, server = server)
