source("server.R",encoding="utf-8")

library(shiny)
library(ggplot2)
library(plotly)
library(bslib)

dataset <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-ayun124/main/data.csv?token=GHSAT0AAAAAABQJR2LQD2M47GUNHWNGWZXUYRSR7OA")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            h1("Global Sexual Violence", align = "center")
  )
)

plot_1_sidebar <- sidebarPanel(
  selectInput(
    inputId = "selectyear",
    label = "Select Year",
    choices = unique_year,
    selected = "2000",
    multiple = TRUE
  )
)

plot_1_main <- mainPanel(
  plotlyOutput(outputId = "piePlot")
)

plot_tab_1 <- tabPanel(
  "Plot 1",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            h1("Cases happening in the regions", align = "center")
  ),
  sidebarLayout(
    plot_1_sidebar,
    plot_1_main
  ),
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            p("In this chart, it shows the percentage of the cases in each of the region for the selected years. It's used to find out the distribution of the Sexual Violence in the world.")
  )
)

plot_2_sidebar <- sidebarPanel(
  selectInput(
    inputId = "select_country",
    label = "Select Country",
    choices = unique_country,
    selected = "Afghanistan"
  )
)

plot_2_main <- mainPanel(
  plotlyOutput(outputId = "linePlot")
)

plot_tab_2 <- tabPanel(
  "Plot 2",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            h1("Cases over time by Country", align = "center")
  ),
  sidebarLayout(
    plot_2_sidebar,
    plot_2_main
  ),
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            p("In this chart, we are showing how much the number of cases in each country changed over time. It is used to see how much sexual violence has increased or decreased in the world.")
            )
)

plot_3_sidebar <- sidebarPanel(
  selectInput(
    inputId = "year",
    label = "Select year",
    choices = unique_year,
    selected = "2000"
  )
)

plot_3_main <- mainPanel(
  plotlyOutput(outputId = "mapPlot")
)

plot_tab_3 <- tabPanel(
  "Plot 3",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            h1("Map representation of the global cases based on user selected year", align = "center")
  ),
  sidebarLayout(
    plot_3_sidebar,
    plot_3_main
  ),
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            p("In this map, it shows the golobal cases for all countries based on the user selected year.")
  )
)

conclusion_tab <- tabPanel(
  "Conclusion",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            h1("Global Sexual Violence", align = "center")
  )
)

ui <- navbarPage(
  "Global Sexual Violence",
  intro_tab,
  plot_tab_1,
  plot_tab_2,
  plot_tab_3,
  conclusion_tab
)
