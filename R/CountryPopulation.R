#' A function that uses the WorldPopulation dataframe
#' to generate a graph of any country in the WorldPopulation dataframe.
#'
#' @param Country_name Name of the country
#' @param title title for the garph
#' @return return the graph of the country
#' @examples
#' CountryPopulation("Brazil")
#' CountryPopulation("Brazil",'Graph of Brazil population over time')
#' @export
CountryPopulation <- function(country_name,title=NULL){
  country_data <- WorldPopulation %>%
    filter(Country_Name==country_name) %>%
    pivot_longer(`1950`:`2020`,
                 names_to = 'Year',
                 values_to = 'Population')

    if(nrow(country_data)==0){
      stop('Not a member of the UN Organisation')
    }

  country_data <- country_data %>% ggplot(aes(x=as.integer(Year),y=Population))+
    labs(x="Year",y="Total Population(thousands)",title =ifelse(is.null(title),paste("Population Curve for",country_name),title))+
    geom_line()+theme_linedraw()

  return(country_data)
}
