## ui.R ##

library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)

dashboardPage(
        dashboardHeader(title = "SaniPath Dashboard"),
        dashboardSidebar(sidebarMenu(
                menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
                menuItem("Samples", tabName = "tabcol", icon = icon("asterisk")),
                menuItem("Lab", tabName = "tablab", icon = icon("asterisk"))
        )
        ),
        dashboardBody(
                tabItems(
                        # Tab 1 content
                        tabItem(tabName = "overview",
                                h2("Overview"),
                                fluidRow(
                                        box(title = "Deployment", status = "info", solidHeader = TRUE, 
                                            radioButtons("deployments", "Deployments",
                                                         choices = "")
                                            ),
                                        box(title = "Histogram", status = "primary", solidHeader = TRUE,
                                            collapsible = FALSE,
                                            plotlyOutput("hist", height = 250)
                                            )
                                        ),
                                fluidRow(
                                        box(title = "Slider", status = "warning", solidHeader = TRUE,
                                            "Box content here", br(), "More box content",
                                            sliderInput("slider", "Slider input:", 1, 100, 50)
                                            ),
                                        
                                        box(title = "Histogram", status = "warning", solidHeader = TRUE,
                                            collapsible = FALSE,
                                            plotOutput("plot3", height = 250)
                                            )
                                        )
                                ),
                        
                        # Tab 2 content
                        tabItem(tabName = "tabcol",
                                h2("Here is the sample content"),
                                fluidRow(
                                        box(title = "Test Pie", status = "info", solidHeader = TRUE,
                                            "Percentage of samples collected per deployment",
                                            plotlyOutput("testpie", height = 250)
                                        ),
                                        box(title = "Table", status = "primary", solidHeader = FALSE,
                                            collapsible = FALSE,
                                            radioButtons("deployments1", "Deployments",
                                                         choices = ""),
                                            tableOutput("table")
                                        )
                                
                                )),
                        
                        # Tab 3 content
                        tabItem(tabName = "tablab",
                                h2("Here is the lab content")
                                )
        ))
)

