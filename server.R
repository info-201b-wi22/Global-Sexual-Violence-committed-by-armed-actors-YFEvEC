library(ggplot2)
library(plotly)
library(dplyr)

dataset <- read.csv("https://github.com/info-201b-wi22/final-project-YFEvEC/blob/main/data.csv")



unique_year <- sort(unique(dataset$year), decreasing = FALSE)

unique_country <- sort(unique(dataset$location))

server <- function(input, output) {
  
  output$piePlot <- renderPlotly({
    
    dataset <- dataset %>%
      filter(year %in% input$selectyear)
    
    cases_region <- dataset %>%
      count(region)
    region_name <- c("Europe", "Middle East", "Asia", "Africa", "Americas")
    pct <- round(cases_region$n/sum(cases_region$n) * 100)
    labs <- paste(pct, "%", sep = "")
    df <- data.frame(pct, labs, region_name = factor(region_name, levels = region_name))
    plot_ly(df, values = pct, labels = factor(region_name), type = "pie")
  })
  
  output$linePlot <- renderPlotly({
    dataset <- dataset %>% 
      filter(location %in% input$select_country)
    
    cases_location <- dataset %>% 
      group_by(year) %>% 
      count(location) %>% 
      rename(Cases = n) %>% 
      ungroup()
    
    plot_ly(cases_location,
            x = ~year,
            y = ~Cases,
            type = 'scatter',
            mode = 'lines')
    
  })
  
  
  output$mapPlot <- renderPlotly({
    
    cases <- dataset %>%
      filter(year %in% input$year) %>% 
      replace(is.na(.), 0) %>% 
      group_by(location) %>% 
      count(year) %>% 
      rename(cases = n)
    
    mapdata <- map_data("world")
    mapdata <- rename(mapdata, location = region)
    
    mapdata <- left_join(mapdata, cases, by="location")
    
    
    mapdata <- map_data("world")
    mapdata <- rename(mapdata, location = region)
    
    mapdata <- left_join(mapdata, cases, by="location")
    
    
    mapdata1 <- mapdata %>% 
      filter(!is.na(mapdata$n))
    map_setup <- ggplot( mapdata1, aes(x = long, y = lat, group=group)) +
      geom_polygon(aes(fill = n), color = "black")
    
    ggplotly(map_setup)
    
  })
  
}

