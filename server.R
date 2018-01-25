## server.R ##

library(dplyr)

# data_col <- read.csv("data/data_col.csv", header=T, sep = ",")
data_col <- read.csv("data/merged_col_01_02.csv", header=T, sep = ",")
meta_deploy <- read.csv("data/meta_deployments.csv", header=T, sep = ",", stringsAsFactors = F)
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
        
        output$plot3 <- renderPlot(
                hist(rnorm(input$slider))
        )
        
        output$hist <- renderPlotly({
                
                p <- count(data_col[data_col$deployment_name == input$deployments, ], col_sample_type) %>%
                plot_ly(x = ~col_sample_type, y = ~n, type = 'bar')
                
                # p <- ggplot(data_col[data_col$deployment == input$deployments, ], aes(x=as.factor(col_sample_type))) +
                #         geom_bar(stat="count") +
                #         theme_light()
                
                ggplotly(p) %>% layout(showlegend = F)
                ggplotly(p) %>% config(displayModeBar = F)
          })
        
        output$table <- renderTable(as.data.frame(count(data_col[data_col$deployment_name == input$deployments1, ], 
                                                        sample_type_name)))
        
        output$testpie <- renderPlotly(
                pie <- plot_ly(data_col_depl, values = ~Freq, labels = ~Country, type = "pie")
        )
}