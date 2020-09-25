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
                            					
					sidebarPanel(
							 radioButtons("variable", "Feature Distribution:",
							             c("sepal width" = "sepal_width",
							               "sepal length" = "sepal_length",
							               "petal width" = "petal_width",
										   "petal length" = "petal_length")),
								),
					mainPanel(			
							column(plotOutput("distPlot"), width=8, height=8)
							), 
					br(),
					br(),
					br(),
					br(),
					mainPanel(
					hr(style="height:2px;border-width:0;color:gray;background-color:gray"),
                        #column(
						tags$style(".fa-database {color:#E87722}"),
                        h3(p(em("Normalize dataset "),icon("database",lib = "font-awesome"),style="color:black;text-align:center")),
                            fluidRow(column(DT::dataTableOutput("NormData"), width = 12)),
											width = 12
							)
				),				
		tabPanel("Step 2",
					p("Create the Model ",style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                            					
					sidebarPanel( 
						sliderInput("kInput", "Select number of K:", 
						min=2, max=10, value=2),	
					),
					
					mainPanel(		
					column(plotOutput("resultPlot"), width=10, height=10)	
					),
					br(),
					br(),
					br(),
					br(),
					br(),
					hr(style="height:2px;border-width:0;color:gray;background-color:gray"),
					
					sidebarPanel(
						p("Optimize clustering methods ",style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
						selectInput("methods", "Choose a Method:", 
							choices = c("Elbow", "Silhouette", "Gap Statistic"))
					),
					
					mainPanel(		
					column(plotOutput("methodPlot"), width=10, height=10)	
					)
			)	
		)	
	)
)	
		
