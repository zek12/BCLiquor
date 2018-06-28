# library(shiny)

ui <- fluidPage(
    titlePanel("BC Liquor Store prices", windowTitle = "MyApp"),
    div("this is blue", style = "color: blue;"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("priceInput", "Price", min = 0, max = 100, value = c(25, 40), pre = "$"),
            # radioButtons("typeInput", "Product type",
            #              choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
            #              selected = "WINE"),
            # selectInput("countryInput", "Country",
            #             choices = c("CANADA", "FRANCE", "ITALY")),
            uiOutput("typeOutput"),
            uiOutput("subtypeOutput"),
            uiOutput("countryOutput")
        ),
        mainPanel(
            plotOutput("coolplot"),
            br(), br(),
            strong(textOutput("results_number")),
            tableOutput("results")
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