#Total count
library(dplyr)

# BR
load("~/Documents/GitHub/authenticity_performances/data/BR_campaign.rda")
BR_Campaign <- dplyr::filter(BR_Campaign, Date > 1987) %>% 
  mutate(setting = "Campaign")
summary(as.factor(BR_Campaign$Date))
# 175
load("~/Documents/GitHub/authenticity_performances/data/BR_debates.rda")
BR_debates <- filter(BR_debates, Date > 1987)  %>% 
  mutate(setting = "Debates", Date = lubridate::year(Date))
summary(as.factor(BR_debates$Date))
# 29 for 17 debates since debates are split by candidates
load("~/Documents/GitHub/authenticity_performances/data/BR_interviews.rda")
BR_Interviews <- filter(BR_Interviews, Date > 1987) %>% 
  mutate(setting = "Interviews")
summary(as.factor(BR_Interviews$Date))
# 258
BR_oral <- readRDS("~/Documents/GitHub/authenticity_performances/data/BR_oral.Rds") %>%
  select(-c(location, party)) %>% 
  rename(Title = date, Speaker = president, Date = year,
         Text = text, Source = title) %>% 
  filter(Date > 1987) %>% 
  mutate(setting = "Speeches")
summary(as.factor(BR_oral$Date))
# 5782
BR_t <- rbind(BR_Campaign, BR_oral, BR_debates, BR_Interviews)
# 6244-12 debates = 6232
BR_t_table <- BR_t %>% group_by(setting, Date) %>% 
  count() %>% 
  mutate(election_cycle = case_when(Date < 1993 ~ "1988-1992",
                                    Date > 1992 & Date < 1997 ~ "1993-1996",
                                    Date > 1996 & Date < 2001 ~ "1997-2000",
                                    Date > 2000 & Date < 2005 ~ "2001-2004",
                                    Date > 2004 & Date < 2009 ~ "2005-2008",
                                    Date > 2008 & Date < 2013 ~ "2009-2012",
                                    Date > 2012 & Date < 2017 ~ "2013-2016",
                                    Date > 2016 ~ "2017-2021"),
         politicians = case_when(Date < 1993 ~ "Collor - Lula",
                                 Date > 1992 & Date < 1997 ~ "Cardoso - Lula",
                                 Date > 1996 & Date < 2001 ~ "Cardoso - Lula",
                                 Date > 2000 & Date < 2005 ~ "Lula - Serra",
                                 Date > 2004 & Date < 2009 ~ "Lula - Alckmin",
                                 Date > 2008 & Date < 2013 ~ "Rousseff - Serra",
                                 Date > 2012 & Date < 2017 ~ "Rousseff - Neves",
                                 Date > 2016 ~ "Bolsonaro - Haddad")) %>%
  group_by(election_cycle, politicians, setting) %>%
  summarise(obs = sum(n))
#saveRDS(BR_t_table, file = "BR_t_table.Rds")

#US
load("~/Documents/GitHub/authenticity_performances/data/US_campaign.rda")
US_campaign <- filter(US_campaign, date > as.Date("1987-12-31")) %>% 
  mutate(date = lubridate::year(lubridate::as_date(date)),
         setting = "Campaign")
#1545
load("~/Documents/GitHub/authenticity_performances/data/US_debates.rda")
US_debates <- US_debates %>%
  mutate(Date = lubridate::year(lubridate::as_date(Date)),
         source_links = "TAPP",
         setting = "Debates") %>%
  filter(Date > 1987) %>%
  rename(speaker = Speakers)
names(US_debates) <- tolower(names(US_debates))
unique(US_debates$date)
#51 for 24 since debates were split by candidate already
load("~/Documents/GitHub/authenticity_performances/data/US_interviews.rda")
US_interviews <- filter(US_interviews, date > as.Date("1987-12-31")) %>% 
  mutate(date = lubridate::year(lubridate::as_date(date)),
         setting = "Interviews")
unique(US_interviews$date)
# 829
load("~/Documents/GitHub/authenticity_performances/data/US_oral.rda")
US_oral <- filter(US_oral,date > as.Date("1987-12-31")) %>% 
  mutate(date = lubridate::year(lubridate::as_date(date)),
         setting = "Speeches")
# 12866
US_t <- rbind(US_campaign, US_debates, US_interviews, US_oral)
# 15291 - 27 debates = 15264
# Total: 6232 + 15264 = 21496
US_t_table <- US_t %>% group_by(setting, date) %>% 
  count() %>% 
  mutate(election_cycle = case_when(date < 1991 ~ "1988-1990",
                                    date > 1990 & date < 1995 ~ "1991-1994",
                                    date > 1994 & date < 1999 ~ "1995-1998",
                                    date > 1998 & date < 2003 ~ "1999-2002",
                                    date > 2002 & date < 2007 ~ "2003-2006",
                                    date > 2006 & date < 2011 ~ "2007-2010",
                                    date > 2010 & date < 2015 ~ "2011-2014",
                                    date > 2014 & date < 2019 ~ "2015-2018", 
                                    date > 2018 ~ "2018-2021"),
         politicians = case_when(date < 1991 ~ "Bush - Dukakis",
                                 date > 1990 & date < 1995 ~ "Clinton - Bush",
                                 date > 1994 & date < 1999 ~ "Clinton - Dole",
                                 date > 1998 & date < 2003 ~ "W. Bush - Gore",
                                 date > 2002 & date < 2007 ~ "W. Bush - Kerry",
                                 date > 2006 & date < 2011 ~ "Obama - McCain",
                                 date > 2010 & date < 2015 ~ "Obama - Romney",
                                 date > 2014 & date < 2019 ~ "Trump - H. Clinton", 
                                 date > 2018 ~ "Biden - Trump")) %>%
  group_by(election_cycle, politicians, setting) %>%
  summarise(obs = sum(n))
#saveRDS(US_t_table, file = "US_t_table.Rds")
