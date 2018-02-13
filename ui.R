## ui.R ##

library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)

dashboardPage(
        dashboardHeader(title = "SaniPath Dashboard"),
        dashboardSidebar(sidebarMenu(
                menuItem("Map", tabName = "tabmap", icon = icon("map-marker")),
                menuItem("Samples", tabName = "tabcol", icon = icon("bar-chart")),
                menuItem("Surveys", tabName = "tabsurv", icon = icon("bar-chart")),
                menuItem("Drinking Water", tabName = "tabboil", icon = icon("pie-chart")),
                menuItem("Latrines", tabName = "tablatrine", icon = icon("pie-chart"))
        )
        ),
        dashboardBody(
                tabItems(
# **************************************************************************************************
                        # Tab 1 map
                        tabItem(tabName = "tabmap",
                                HTML('<center><img src="sanipath_logo3.jpg" width="300" ></center>'),
                                h2("Overview"),
                                p("Here is an overview of the most recent SaniPath deployments."),
                                p("MAP goes here")
                                ),
# **************************************************************************************************                        
                        # Tab 2 sample collection
                        tabItem(tabName = "tabcol",
                                h2("Information about samples goes here"),
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
# **************************************************************************************************                        
                        # Tab 3 suvey
                        tabItem(tabName = "tabsurv",
                                h2("Information about surveys goes here")
                                ),
# **************************************************************************************************                        
                        # Tab 4 suvey
                        tabItem(tabName = "tabboil",
                                h2("Information about boiling drinking water goes here")
                        ), 
# **************************************************************************************************                        
                        # Tab 5 suvey
                        tabItem(tabName = "tablatrine",
                                h2("Information about private latrine goes here")
                        )
        ))
)

