library(shiny)
library(tidyverse)
library(shinyjs)
#library(reticulate)
#conda_install("r-reticulate", "pandas")
#conda_install("r-reticulate", "pypinyin")
reticulate::py_install(c('pandas', 'pypinyin'))
reticulate::source_python("code.py")

#reticulate::py_config()
ui <- basicPage(
                 
                          fluidPage(
                            tags$h3("法语化你的名字，获取你中文名纯正的拟音法文转写",
                                    style="width: 50%; font-family:Arial;font-weight:bold;padding-left:0px;text-align: center;"),
                            br(),
                            br(),
                            fluidRow(
                              tags$head(tags$style(HTML(".selectize-input {width: 650px;}"))),
                              div(style = "margin-top: -20px"),
  
                              tags$h5("请输入你的中文名:",
                                      style="width: 50%; font-family:Arial;font-weight:bold;margin-left:0px;"),
                              div(style = "margin-top: -15px"),
                              textInput("txt", "",width='50%'),
                              span(
                              actionButton("button", "开始法语化"),
                              actionButton("rid", "清除")
                              ),
                              br(),
                              br(),
                              p("法语化的名字是："),
                              hidden(
                                div(id='text_div',
                               uiOutput("text")
                                         
                              )
                              )
                             )
                          
                 ################################End of Panel 3##################################
)
)


server<-function(input, output, session) {
  
  observeEvent(input$button, {
    toggle('text_div')
    output$text <- renderUI({ 

      div(style="font-family:Arial;font-size: 30px;font-style: bold;width: 50%;",
          frenchize(input$txt))

  })
  })
    
    
    observeEvent(input$rid, {
      toggle('text_div')
      output$text <-renderText('')
      updateTextInput(session,"txt",value="")
        
      })
observeEvent(input$txt=="",{
  output$text<- renderUI(p(''))
})


}

shinyApp(ui = ui, server = server)


