# This updates the scrapped datasets until december 2021
# For more iformation see the US_scraping script in this folder.
# Source: https://www.presidency.ucsb.edu/
library(rvest)
library(dplyr)
library(usethis)
library(stringr)

get_text <- function(source_link) {
  oral_remarks_page = read_html(source_link)
  oral_remarks_text = oral_remarks_page %>% html_nodes(".field-docs-content p") %>% html_text() %>% paste(collapse = ",")
  return(oral_remarks_text)
}
US_Oral_Remarks_c = data.frame()
for (page_result in seq(from = 0, to = 32, by = 1)) {
  link = paste0("https://www.presidency.ucsb.edu/documents/app-categories/presidential/spoken-addresses-and-remarks?page=", page_result)
  page = read_html(link)
  title <- page %>% html_nodes(".field-title a") %>% html_text()
  date <-  page %>% html_nodes(".date-display-single") %>% html_text()
  speaker <- page %>% html_nodes(".margin-top a") %>% html_text()
  source_links <- page %>% html_nodes(".field-title a") %>% html_attr("href") %>% paste0("https://www.presidency.ucsb.edu", . , sep = "")
  text <- sapply(source_links, FUN = get_text, USE.NAMES = FALSE)
  US_Oral_Remarks_c <- rbind(US_Oral_Remarks_c, data.frame(title, date, speaker, source_links, text, stringsAsFactors = FALSE))
  print(paste("Page:", page_result))
}
# Merge and save datasets
US_Oral_Remarks_21 <- rbind(US_Oral_Remarks, US_Oral_Remarks_c)
US_Oral_Remarks_21 <- dplyr::distinct(US_Oral_Remarks_21)
usethis::use_data(US_Oral_Remarks_21, overwrite = TRUE)
# The datasets are moved to data-raw folder.

# Updates other miscelaneous oral remarks
get_text <- function(source_link) {
  oral_mremarks_page = read_html(source_link)
  oral_mremarks_text = oral_mremarks_page %>% html_nodes(".field-docs-content p") %>% html_text() %>% paste(collapse = ",")
  return(oral_mremarks_text)
}
US_M_Remarks_c = data.frame()
for (page_result in seq(from = 0, to = 30, by = 1)) {
  link = paste0("https://www.presidency.ucsb.edu/documents/app-categories/presidential/miscellaneous-remarks?page=", page_result)
  page = read_html(link)
  title <- page %>% html_nodes(".field-title a") %>% html_text()
  date <-  page %>% html_nodes(".date-display-single") %>% html_text()
  speaker <- page %>% html_nodes(".margin-top a") %>% html_text()
  source_links <- page %>% html_nodes(".field-title a") %>% html_attr("href") %>% paste0("https://www.presidency.ucsb.edu", . , sep = "")
  text <- sapply(source_links, FUN = get_text, USE.NAMES = FALSE)
  US_M_Remarks_c <- rbind(US_M_Remarks_c, data.frame(title, date, speaker, source_links, text, stringsAsFactors = FALSE))
  print(paste("Page:", page_result))
}
# Merge and save datasets
US_M_Remarks_21 <- rbind(US_M_Remarks, US_M_Remarks_c)
US_M_Remarks_21 <- dplyr::distinct(US_M_Remarks_21)
usethis::use_data(US_M_Remarks_21, overwrite = TRUE)

# US Presidents' Interviews, debates, and campaign documents are up to date already ...
# Weekly radio anouncements and press confernces were not updated
# since they are not currently being used for analysis.
