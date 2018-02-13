## server.R ##

library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)

# data_col <- read.csv("data/data_col.csv", header=T, sep = ",")
data_col <- read.csv("data/merged_col_01_02.csv", header=T, sep = ",")
meta_deploy <- read.csv("data/meta_deployments.csv", header=T, sep = ",", stringsAsFactors = F)
meta_deploy <- meta_deploy[-1, ]
meta_col <- read.csv("data/meta_sampleID.csv", header=T, sep = ",", stringsAsFactors = F)

# rename deployments
data_col$deployment_name[data_col$deployment == "1"] <- meta_deploy$Country[meta_deploy$ID == "1"]
data_col$deployment_name[data_col$deployment == "2"] <- meta_deploy$Country[meta_deploy$ID == "2"]

# add sample names and variables
data_col <- left_join(data_col, meta_col, by = c("col_sample_type" = "ID"))

deployments <- sort(unique(as.character(data_col$deployment_name)))
deployments1 <- sort(unique(as.character(data_col$deployment_name)))



server <- function(input, output, session) {
        
        session$onSessionEnded(function() {
                stopApp()
        })
        
        data_col_depl <- data.frame(table(data_col$deployment))
        data_col_depl$Var1 <- as.numeric(as.character(data_col_depl$Var1))
        data_col_depl <- left_join(data_col_depl, meta_deploy[, 1:2], by = c("Var1" = "ID"))
        
        observe({
                updateRadioButtons(session, "deployments", choices=deployments)
        })
        
        observe({
                updateRadioButtons(session, "deployments1", choices=deployments)
        })
        
        
        output$hist <- renderPlotly({
                dfhist <- count(data_col[data_col$deployment_name == input$deployments, ], col_sample_type)

                dfhist2 <- as.data.frame(matrix(nrow = 10, ncol = 0))
                dfhist2$col_sample_type <- 1:10
                dfhist <- left_join(dfhist2, dfhist, by = "col_sample_type")
                dfhist$n[is.na(dfhist$n)] <- 0
                dfhist <- left_join(dfhist, meta_col, by = c("col_sample_type" = "ID"))
                dfhist$sample_type_name <- factor(dfhist$sample_type_name, levels = unique(dfhist$sample_type_name)[order(dfhist$col_sample_type)])
                
                p <- plot_ly(dfhist, x = ~sample_type_name, y = ~n, type = 'bar') %>%
                        layout(showlegend = F,
                               xaxis = list(range = c(0,10),
                                            title = "")) 
                
                # p <- ggplot(data_col[data_col$deployment == input$deployments, ], aes(x=as.factor(col_sample_type))) +
                #         geom_bar(stat="count") +
                #         theme_light()
                
                
          })
        
        output$table <- renderTable(as.data.frame(count(data_col[data_col$deployment_name == input$deployments1, ], 
                                                        sample_type_name)))
        
        output$testpie <- renderPlotly(
                pie <- plot_ly(data_col_depl, values = ~Freq, labels = ~Country, type = "pie")
        )
        
        
        
        
        
        
        
        
}