# library(shiny)
# if (!require("DT")) install.packages('DT')
library(ggplot2)
library(dplyr)
library(DT)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
# print(head(bcl))

server <- function(input, output) {
    
    # observe({ print(input$priceInput) })
    # 
    # priceDiff <- reactive({
    #     diff(input$priceInput)
    # })
    # observe({ print(priceDiff()) })
    
    output$typeOutput <- renderUI({
        radioButtons("typeInput", "Product type",
                     choices = bcl$Type %>% unique() %>% sort(),
                     selected = "WINE")
    })
    
    output$subtypeOutput <- renderUI({
        if (is.null(input$typeInput)) {
            return(NULL)
        }
        
        selectInput("subtypeInput", "Product subtype",
                     choices = bcl %>% filter(Type == input$typeInput) %>% 
                         .$Subtype %>% unique() %>% sort() %>% c("ALL", .),
                    selected = "ALL"
                     )
    })
    
    output$countryOutput <- renderUI({
        selectInput("countryInput", "Country",
                    choices = bcl$Country %>% unique() %>% sort() %>% c("ALL", .),
                    selected = "ALL"
                    )
    })
    
    filtered <- reactive({
        if (is.null(input$countryInput) | is.null(input$typeInput) | is.null(input$subtypeInput)) {
            return(NULL)
        }
        
        if (input$subtypeInput == "ALL") {
            subtype_selected <- bcl %>% filter(Type == input$typeInput) %>% .$Subtype %>% unique()
        } else {
            subtype_selected <- input$subtypeInput
        }
        
        if (input$countryInput == "ALL") {
            country_selected <- bcl$Country %>% unique()
        } else {
            country_selected <- input$countryInput
        }


        # bcl %>%
        #     filter(Price >= input$priceInput[1],
        #            Price <= input$priceInput[2],
        #            Type == input$typeInput,
        #            Subtype == input$subtypeInput,
        #            Country == input$countryInput
        #     )
        bcl %>%
            filter(Price >= input$priceInput[1],
                   Price <= input$priceInput[2],
                   Type == input$typeInput,
                   Subtype %in% c(subtype_selected),
                   Country %in% c(country_selected)
            )

    })
    
    output$coolplot <- renderPlot({
        # print(input$priceInput)
        if (is.null(filtered())) {
            return()
        }
        ggplot(filtered(), aes(Alcohol_Content)) +
            geom_histogram(binwidth = 0.1)
    })
    
    output$results_number <- renderText({
        if (!is.null(filtered())) {
            paste0("Number of results: ", nrow(filtered()))
        }
    })
    
    # output$results <- renderTable({
    #     filtered()
    # })
    
    output$results <- DT::renderDataTable({
        datatable(filtered(),
                  options = list(
                      columnDefs = list(list(searchable = FALSE, targets = c(2,3))) 
                      # 2,3 means columns 2,3 from table, which are Subtype and Country
                  ),
                  filter = 'top')
    })

}
