library(shiny)
library(shinythemes)

data <- iris

shinyUI(fluidPage(theme = shinytheme("cosmo"),

  titlePanel("Step by Step K-Means Clustering with Iris data"),
	navbarPage("",
		tabPanel("Dataset",                                          
                        hr(),
                        tags$style(".fa-database {color:#E87722}"),
                        h3(p(em("Iris dataset "),icon("database",lib = "font-awesome"),style="color:black;text-align:center")),
                            fluidRow(column(DT::dataTableOutput("RawData"),
                                            width = 12))
				),
		tabPanel("Step 1",
					p("Checking the distribution of each features ",style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                            					
					fluidPage(
							 radioButtons("variable", "Feature Distribution:",
							             c("sepal width" = "sepal_width",
							               "sepal length" = "sepal_length",
							               "petal width" = "petal_width",
										   "petal length" = "petal_length")),
										   
							column(plotOutput("distPlot"), width=8)
							),
					br(),
					hr(),
                        tags$style(".fa-database {color:#E87722}"),
                        h3(p(em("Normalize dataset "),icon("database",lib = "font-awesome"),style="color:black;text-align:center")),
                            fluidRow(column(DT::dataTableOutput("NormData"),
                                            width = 12))	
				),
		tabPanel("Step 2",
					p("Create the Model ",style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                            					
					fluidPage(
						sliderInput("kInput", "Select number of K:", 
						min=2, max=5, value=2),	
					br(),	
					column(plotOutput("resultPlot"), width=8)	
				)		
			)	
		)	
	)
)	
		
