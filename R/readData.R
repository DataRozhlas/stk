readData <- function(
  file=character()
) {
  require(readxl)
  require(stringr)
  assign(str_sub(str_extract(file, "^.+\\."), 1, -2), read_excel(paste0("data/", file), skip=7, col_names=c("id_stanice", "prohlidky_celkem", "docasne_zpusoblile_pocet", "docasne_zpusobile_pct", "nezpusobile_pocet", "nezpusobile_pct", "zpusobile_pocet", "zpusobile_pct", "blank", "prum_poc_zavad_lehke", "prum_poc_zavad_vazne", "prum_poc_zavad_nebezpecne")), pos=1)
  clenaData(str_sub(str_extract(file, "^.+\\."), 1, -2))
}