library(shiny)
library(ggplot2)
library(factoextra)

data <- iris
sepal_width<-iris$Sepal.Width
sepal_length<-iris$Sepal.Length
petal_width<-iris$Petal.Width
petal_length<-iris$Petal.Length

# take the copy of original data
  data_norm <- data
 
  normal_func <- function(dataset, column) {
    norm_col <- (dataset[,column] - mean(dataset[,column])) / sd(dataset[,column])
	return(norm_col)
	}
			
# Normalize all features
data_norm$Sepal.Length.Norm = normal_func(data_norm, 1)
data_norm$Sepal.Width.Norm = normal_func(data_norm, 2)
data_norm$Petal.Length.Norm = normal_func(data_norm, 3)
data_norm$Petal.Width.Norm = normal_func(data_norm, 4)

dataFinal = data_norm[,6:9]

shinyServer(function(input, output) {
   
  output$RawData <- DT::renderDataTable(
    DT::datatable({
      data
    },
    options = list(lengthMenu=list(c(5,15,20),c('5','15','20')),pageLength=10,
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'moccasin', 'color': '1c1b1b'});",
                     "}"),
                   columnDefs=list(list(className='dt-center',targets="_all"))
                   ),
    filter = "top",
    selection = 'multiple',
    style = 'bootstrap',
    class = 'cell-border stripe',
    rownames = FALSE,
    colnames = c("Sepal Length","Sepal Width","Petal Length","Petal Width","Species")
    ))
	
	output$distPlot <- renderPlot({
    variable <- switch(input$variable,
                sepal_width = sepal_width,
                sepal_length = sepal_length,
                petal_width = petal_width,
                petal_length = petal_length)

	name <- input$variable			
    plt1 <- ggplot(iris, aes(x=variable)) + geom_density()
	plt1 + labs(x = name)
  })
  
	
	# Display the dataset including normalize values
	output$NormData <- DT::renderDataTable(
    DT::datatable({
      data_norm
    },
    options = list(lengthMenu=list(c(5,15,20),c('5','15','20')),pageLength=10,
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'moccasin', 'color': '1c1b1b'});",
                     "}"),
                   columnDefs=list(list(className='dt-center',targets="_all"))
                   ),
    filter = "top",
    selection = 'multiple',
    style = 'bootstrap',
    class = 'cell-border stripe',
    rownames = FALSE,
    colnames = c("Sepal Length","Sepal Width","Petal Length","Petal Width","Species", "Sepal Length Norm","Sepal Width Norm","Petal Length Norm","Petal Width Norm")
    ))


	output$resultPlot <- renderPlot({
		center <- input$kInput
		k2 <- kmeans(dataFinal, center, nstart = 10)
		fviz_cluster(k2, dataFinal, ellipse.type = "norm") 
	 
  })
	
	
	    
  
}
)

