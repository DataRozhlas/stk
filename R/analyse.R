library(tidyverse)

getData("https://www.mdcr.cz/getattachment/Statistiky/Silnicni-doprava/STK/Hodnoceni-zpusobilosti-a-prumerneho-poctu-zavad-vo/Hodnoceni-zpusobilosti-2018.xlsx.aspx?lang=cs-CZ", "vysledky-2018.xlsx")
readData("vysledky-2018.xlsx")

# celkové výsledky
`vysledky-2018` %>%
  summarise(sum(nezpusobile_pocet)/sum(prohlidky_celkem)*100)

# nejvíce způsobilých

`vysledky-2018` %>%
  filter(prohlidky_celkem>1000) %>%
  arrange(desc(zpusobile_pct))
  
# připojit adresy STK

download.file("https://www.mdcr.cz/getattachment/Dokumenty/Silnicni-doprava/STK/STK-Seznam-STK-dle-kraju/Aktualni-data-STK-na-web-(1).xlsx.aspx?lang=cs-CZ", "data/stk_adresy.xlsx")

stk_adresy <- read_excel("data/stk_adresy.xlsx", col_names = c("id_stanice", "druh_stk", "psc", "mesto", "ulice", "provozovatel", "telefon", "email", "orp", "okres", "kraj"), skip = 2)

stk_adresy$id_stanice <- as.numeric(sub("\\.", "", stk_adresy$id_stanice))

vysledky_2018_adresy  <- `vysledky-2018` %>%
  left_join(stk_adresy)

# nespojily se STK 3533, 3717

# top nezpůsobilé okresy
vysledky_2018_adresy %>%
  group_by(okres) %>%
  summarise(pct_nezpus=sum(nezpusobile_pocet)/sum(prohlidky_celkem)*100) %>%
  arrange(pct_nezpus)

# top nezpůsobilé ORP
vysledky_2018_adresy %>%
  group_by(orp) %>%
  summarise(pct_nezpus=sum(nezpusobile_pocet)/sum(prohlidky_celkem)*100) %>%
  arrange(desc(pct_nezpus))

# bej rozdíl v ORP

vysledky_2018_adresy %>%
  filter(prohlidky_celkem>1000) %>%
  group_by(orp) %>%
  summarise(rozdil=(max(zpusobile_pct))-(min(zpusobile_pct))) %>%
  arrange(desc(rozdil))

vysledky_2018_adresy %>%
  filter(orp=="Šumperk")
