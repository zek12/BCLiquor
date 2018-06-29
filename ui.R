# library(shiny)

ui <- fluidPage(
    titlePanel(windowTitle = "BCLiquor",
               div(
                   img(src = "wine-glass.png", height = 50, width = 'auto'),
                   "BC Liquor Store prices"
                   )
               ),
    
    # div("this is blue 2", style = "color: blue;"),
    # navbarPage("App Title",
    #            tabPanel("Plot"),
    #            navbarMenu("More",
    #                       tabPanel("Summary"),
    #                       "----",
    #                       "Section header",
    #                       tabPanel("Table")
    #            )
    # ),
    sidebarLayout(
        sidebarPanel(
            sliderInput("priceInput", "Price", min = 0, max = 100, value = c(25, 40), pre = "$"),
            # radioButtons("typeInput", "Product type",
            #              choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
            #              selected = "WINE"),
            # selectInput("countryInput", "Country",
            #             choices = c("CANADA", "FRANCE", "ITALY")),
            conditionalPanel(
                "input.priceInput[0] >=50",
                "The price entered is >= 50"
            ),
            uiOutput("typeOutput"),
            uiOutput("subtypeOutput"),
            uiOutput("countryOutput")
        ),
        mainPanel(
            # plotOutput("coolplot"),
            # br(), br(),
            # strong(textOutput("results_number")),
            # tableOutput("results")
            tabsetPanel(
                tabPanel("Histogram",
                         br(),
                         plotOutput("coolplot")
                         ),
                tabPanel("Results",
                         br(),
                         strong(textOutput("results_number")),
                         br(),
                         DT::dataTableOutput("results")
                         # tableOutput("results")
                         )
            )
        )
    )
)

# print(ui)

# fluidPage(
#     title = "Hello Shiny!",
#     fluidRow(
#         column(width = 4, "4"),
#         column(width = 3, offset = 2, "3 offset 2")
#     ),
#     fluidRow(
#         column(width = 2,"2"),
#         column(width = 3, offset = 5, "3 offset 5")
#     )
# )