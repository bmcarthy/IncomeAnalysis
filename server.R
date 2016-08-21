#'A Shiny App used to compare household income with market survey data.
#'
#'This Shiny App allows users to compare their household income with those
#'found in the Market Basket Analysis data from the ElemStatLearn package.
#' @author Blane McCarthy
#' @details
#' The user can specify gender, employment category, education level,
#' and household income.  The app will then show how their income compares
#' with the market basket observations that match the criteria specified.

library(shiny)
data("marketing")

SalaryRating <- function(Salary)
  { if (Salary < 10000) return (1)
    if (Salary >  9999 & Salary < 15000) return (2)
    if (Salary > 14999 & Salary < 20000) return (3)
    if (Salary > 19999 & Salary < 25000) return (4)
    if (Salary > 24999 & Salary < 30000) return (5)
    if (Salary > 29999 & Salary < 40000) return (6)
    if (Salary > 39999 & Salary < 50000) return (7)
    if (Salary > 49999 & Salary < 75000) return (8)
    if (Salary > 75000) return (9)
  }

shinyServer(
  function(input, output) {
    output$inputGender <- renderPrint({input$Gender})
    output$inputOccupation <- renderPrint({input$Occupation})
    output$inputEdLevel <- renderPrint({input$EdLevel})
    output$inputIncome <- renderPrint({input$Income})
    IncRate <- reactive({SalaryRating(input$Income)})
    output$inputIncRate <- renderPrint({IncRate()})

    output$newHist <- renderPlot({
          if(input$Occupation > 0 & input$EdLevel > 0) {
               hist(subset(marketing, Sex == input$Gender & Edu == input$EdLevel & Occupation == input$Occupation)$Income,
                   col='lightblue', xlim=c(0, 10), xlab = " ", sub = '1. < $10000, 2. $10000 - $14999, 3. $15000 - $19999, 4.20000 - $24999,
                   \n5. $25000 - $29999, 6. $30000 - $39999, 7. $40000 - $49999, 8. $50000 - $74999, 9. > $75000',
                     main='Histogram Showing Your Household Income, (Red Bar), \nRelative to Those With Same Gender, Occupation, and Education Level'
                   , breaks = 100, freq = FALSE)
               lines(c(IncRate(), IncRate()), c(0, 1500),col="red",lwd=3)
               mu <- round(mean(subset(marketing, Sex == input$Gender & Edu == input$EdLevel & Occupation == input$Occupation)$Income), 0)
               text(9.7, 1, paste("Average\nIncome  \n Rating = \n", mu))}
             })
   }
)
