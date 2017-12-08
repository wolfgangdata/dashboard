## server.R ##

data_col <- read.csv("data/data_col.csv", header=T, sep = ",")

server <- function(input, output) {
        
        output$plot3 <- renderPlot(
                hist(rnorm(input$slider))
        )
        
        output$hist <- renderPlot({
                ggplot(data_col[data_col$deployment== input$deployments, ], aes(x=col_sample_type)) +
                        geom_histogram()
        })
}