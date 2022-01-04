# Data Preparation Brazil
# Henrique Sposito

# For Brazil, Cesar's 2020 dataset on oral remarks was updated by this author.
# The data is scraped from the presidential library and covers all official presidential speeches
# and remarks from January 1985 to December 2021.
# For more information on how the dataset was updated please check the 
# amazon_def repository in GitHub ownened by this author.
load("~/GitHub/Poldis/data/BR_oral.rda")
summary(BR_oral)

# Please cite:
# Fagundes Cezar, Rodrigo, 2020, "Brazilian Presidential Speeches from 1985 to July 2020",
# https://doi.org/10.7910/DVN/M9UU09, Harvard Dataverse, V1, DEACCESSIONED VERSION

# For debates, campaign remarks and interviews cleaning for speakers and time range was done at collection portion.
# For more details about collection, please see the Codebook.
