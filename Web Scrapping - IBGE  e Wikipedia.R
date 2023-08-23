## Pacotes

pacotes <- c("httr","rvest","jsonlite")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

## Libs

library("httr")
library("rvest")

## Código

# Página: https://en.wikipedia.org/wiki/Web_scraping

## Buscando dados na internet

#função de leitura
#Aqui faz o get
wikipedia <- read_html("https://en.wikipedia.org/wiki/Web_scraping")


#busca nó de título
wikipedia %>% html_elements("title")

#busca nó de heading, mas tira parte do código HTML
wikipedia %>% html_elements("h1") %>% html_text()

#busca nó de parágrafo, mas tira parte do código HTML
data <- wikipedia %>% html_elements("p") %>% html_text()

length(data)

data[2]

## Busca dados específicos

library("rvest")

#função de leitura
wikipedia <- read_html("https://en.wikipedia.org/wiki/Web_scraping")

#Busca específico 
# "FAQ about linking – Are website terms of use binding contracts?".
body_text <- wikipedia %>% html_elements("#cite_note-5") %>% html_text()

?html_elements

substr(body_text, start = 1, stop = 20)

substr(body_text, start = 21, stop = nchar(body_text))


#Busca item listado
techniques <- wikipedia %>% html_elements("#Techniques") %>% html_text()
techniques

## Olhando página web

# Acessar e olhar a página http://www.r-datacollection.com/materials/html/OurFirstHTML.html

library("httr")

# Usa método GET() - PEGA
website <- GET("http://www.r-datacollection.com/materials/html/OurFirstHTML.html")

?GET

# Visualiza como texto
content(website, "text")

## Buscando dados da API do IBGE

library("rvest")
library("httr")
library("jsonlite")
library("data.table")

## API do IBGE
# Link: https://servicodados.ibge.gov.br/api/docs/paises

#Parâmetros
#country = "BR"

#1 - Listagem de Países - mostra na página web

url = "https://servicodados.ibge.gov.br/api/v1/paises/BR"

page_data <- GET(url)

result <- fromJSON(rawToChar(page_data$content))


#2 - Indicadores - mostra na página web

url2 = "https://servicodados.ibge.gov.br/api/v1/paises/BR|US"

page_data2 <- GET(url2)

# Tipo de arquivo
http_type(page_data2)

jsonText <- content(page_data2, "text")
jsonParsed <- content(page_data2, "parsed")
