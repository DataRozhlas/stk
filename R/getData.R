library(readxl)
getData <- function(
  url=character(),
  nazev=character()
) {
  download.file(url, paste0("data/", nazev))
}