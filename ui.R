## ui.R ##

library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)

dashboardPage(
        dashboardHeader(title = "SaniPath Dashboard"),
        dashboardSidebar(sidebarMenu(
                menuItem("Home", tabName = "tabhome", icon = icon("home")),
                menuItem("Map", tabName = "tabmap", icon = icon("map-marker")),
                menuItem("Samples", tabName = "tabcol", icon = icon("bar-chart")),
                menuItem("Surveys", tabName = "tabsurv", icon = icon("bar-chart")),
                menuItem("Drinking Water", tabName = "tabboil", icon = icon("tint")),
                menuItem("Latrines", tabName = "tablatrine", icon = icon("pie-chart"))
        )
        ),
        dashboardBody(
                tabItems(
# **************************************************************************************************
                        # Tab 1 home
                        tabItem(tabName = "tabhome",
                                HTML('<center><img src="sanipath_logo3.jpg" width="300" ></center>'),
                                h2("Overview"),
                                p("Here is an overview of the most recent SaniPath deployments."),
                                
                                column(width = 4,
                                       infoBox("Total Number of Deployments", nrow(meta_deploy),
                                               width = NULL, color = "yellow", icon = icon("list")),
                                
                                       infoBox("Total Samples Collected", sum(data_col_depl$Freq), 
                                               width = NULL, icon = icon("list"))
                                
                                )
                                ),
                        
# **************************************************************************************************
                        # Tab 2 map
                        tabItem(tabName = "tabmap",
                                h2("Map"),
                                p("Previous Sanipath Deployments"),
                                leafletOutput("map")
                                ),
# **************************************************************************************************                        
                        # Tab 3 sample collection
                        tabItem(tabName = "tabcol",
                                h2("Information about samples goes here"),
                                fluidRow(
                                        box(title = "Deployment", status = "info", solidHeader = TRUE, 
                                            radioButtons("deployments", "Deployments",
                                                         choices = "")),
                                        
                                        box(title = "Samples collected per deployment", status = "info", solidHeader = TRUE,
                                            plotlyOutput("testpie", height = 250)
                                        )
                                        
                                ),
                                fluidRow(
                                        box(title = "Histogram", status = "primary", solidHeader = TRUE,
                                            collapsible = FALSE,
                                            plotlyOutput("hist", height = 250)
                                        ),
                                        box(title = "Table", status = "primary", solidHeader = TRUE,
                                            collapsible = FALSE,
                                            tableOutput("table")
                                        )
                                
                                )
                                
                                ),
# **************************************************************************************************                        
                        # Tab 4 suvey
                        tabItem(tabName = "tabsurv",
                                h2("Information about surveys goes here")
                                ),
# **************************************************************************************************                        
                        # Tab 5 suvey
                        tabItem(tabName = "tabboil",
                                h2("Information about boiling drinking water goes here")
                        ), 
# **************************************************************************************************                        
                        # Tab 6 suvey
                        tabItem(tabName = "tablatrine",
                                h2("Information about private latrine goes here")
                        )
        ))
)

