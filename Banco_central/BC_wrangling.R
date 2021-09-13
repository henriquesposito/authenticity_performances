# Banco Central em Discursos Presidenciais

library(dplyr)
library(stringr)

# count
banco_central <- stringr::str_count(BR_oral$text, "banco central|Banco Central|^BC$")
sum(banco_central)
# sentence level dataframe
bc <- data.frame(BR_oral[grep("banco central|Banco Central|^BC$", BR_oral$text, ignore.case = TRUE),])
bc <- bc %>% select(date, presid, party, length, text)
bc[50,]
bce <- bc
# 3 sentences
text <- gsub(".*?(([^.]+\\.){1}[^.]+(banco central|Banco Central|banco Central|Banco central).*?\\.(.*?\\.){1}).*",
                 "\\1", bce$text, ignore.case = TRUE)
summary(as.factor(bce$presid))
bce$text

bca <-head(bc)
t <- stringr::str_extract_all(bca$text, ".*?(([^.]+\\.){1}[^.]+(banco central|Banco Central|banco Central|Banco central).*?\\.(.*?\\.){1}).*")
