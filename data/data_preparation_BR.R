# Data Preparation Brazil
# Henrique Sposito

# The data is scraped from the presidential library and covers all official presidential speeches
# and remarks from January 1985 to December 2021.
# For more information on how the dataset was updated please check the 
# amazon_def repository in GitHub owned by this author.
load("~/GitHub/Poldis/data/BR_oral.rda")
summary(BR_oral)

# For debates, campaign remarks and interviews cleaning for speakers and time range was done at collection portion.
# For more details about collection, please see the Codebook.
