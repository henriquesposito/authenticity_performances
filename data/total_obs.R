#Total count
library(dplyr)

# BR
load("~/Documents/GitHub/authenticity_performances/data/BR_campaign.rda")
BR_Campaign <- filter(BR_Campaign, Date > 1987)
summary(as.factor(BR_Campaign$Date))
# 175
load("~/Documents/GitHub/authenticity_performances/data/BR_debates.rda")
BR_debates <- filter(BR_debates, Date > 1987)
summary(as.factor(BR_debates$Date))
# 29 for 17 debates
load("~/Documents/GitHub/authenticity_performances/data/BR_interviews.rda")
BR_Interviews <- filter(BR_Interviews, Date > 1987)
summary(as.factor(BR_Interviews$Date))
# 258
BR_oral <- readRDS("~/Documents/GitHub/authenticity_performances/data/BR_oral.Rds") %>%
  select(-c(location, party)) %>% 
  rename(Title = date, Speaker = president, Date = year, Text = text, Source = title) %>% 
  filter(Date > 1987)
summary(as.factor(BR_oral$Date))
# 5782
BR_t <- rbind(BR_Campaign, BR_oral, BR_debates, BR_Interviews)
# 6244-12 = 6232

#US
load("~/Documents/GitHub/authenticity_performances/data/US_campaign.rda")
US_campaign <- filter(US_campaign, date > as.Date("1987-12-31"))
#1545
load("~/Documents/GitHub/authenticity_performances/data/US_debates.rda")
US_debates <- US_debates %>%
  mutate(date = lubridate::as_date(Date),
         source_links = "TAPP") %>%
  filter(date > as.Date("1987-12-31")) %>%
  rename(speaker = Speakers) %>%
  select(-Date)
names(US_debates) <- tolower(names(US_debates))
unique(US_debates$date)
#51 for 24
load("~/Documents/GitHub/authenticity_performances/data/US_interviews.rda")
US_interviews <- filter(US_interviews, date > as.Date("1987-12-31"))
# 829
load("~/Documents/GitHub/authenticity_performances/data/US_oral.rda")
US_oral <- filter(US_oral,date > as.Date("1987-12-31"))
# 12866
US_t <- rbind(US_campaign, US_debates, US_interviews, US_oral)
# 15291 - 27 = 15264
# Total: 6232 + 15264 = 21496 
