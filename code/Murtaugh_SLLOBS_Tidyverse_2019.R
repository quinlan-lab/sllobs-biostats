library(tidyverse)  # functions for tidy data manipulation
library(cowplot)    # pretty-looking graphs
rm(list=ls())  # clear the decks
options(stringsAsFactors = FALSE)  # useful option for non-Tidyverse work

### Data import ###
data_wide <- read_tsv('Incucyte_all.txt') %>% print()


### Data tidying ###
# convert wide data to narrow/tidy format
data_narrow <- gather(data_wide, key='treatment_group', value='confluence', EGFP_untreated_1:Ptf1a_DOX_3) %>%
  print()

# split treatment_group variable into separate variables for overexpressed gene, treatment, and replicate
data_narrow <- separate(data_narrow, treatment_group, c('gene', 'treatment', 'rep')) %>% print()


### Using "mutate" to create/change data columns - a toy example ###
# create toy data
temp_df <- bind_cols(sample=c(1,2,3), temp=c(-40, 32, 98.6)) %>% print()

# use "mutate" to create new column with temperature in Celsius
temp_df <- mutate(temp_df, tempC=(temp-32)*5/9) %>% print()

# create toy data, again
temp_df <- bind_cols(time=c(1,2,3), temp=c(-40, 32, 98.6))

# now let's add both Celsius and Kelvin temperatures in one command
temp_df <- mutate(temp_df, tempC=(temp-32)*5/9, tempK=tempC+273.15) %>%
  rename(tempF = temp) %>%  # and also rename original variable "temp" to "tempF"
  print()


### Using "mutate" on our proliferation data ###
# change treatment to ordered factor
data_narrow <- mutate(data_narrow, 
                      treatment=factor(treatment, levels=c('untreated', 'DOX'))) %>% 
  print()


### Comparing the Tidyverse approach to base R ###
# for comparison to base R approach, read in original data via "read.delim" function
data_baseR <- read.delim('Incucyte_all.txt', sep='\t')

# note that the only easy way to convert a wide data frame to narrow, outside of the Tidyverse, is using
# the "melt" command from the "reshape" package - which is something Hadley Wickham developed before he
# came up with the extended Tidyverse
data_narrow_baseR <- reshape::melt.data.frame(data_baseR, id.vars=c('Line', 'Elapsed', 'Date', 'Experiment'),
                                            variable_name='treatment_group')
# note that "melt" doesn't let you specify the name of the variable column, it just calls it "value"
#   by default - so we have to manually rename it as 'confluence'
colnames(data_narrow_baseR)[colnames(data_narrow_baseR)=='value'] <- 'confluence'

# now, let's split up the "treatment_group" variable
# first, though, we need to convert "treatment_group" from a factor variable (the dumb default behavior
#   of melt) to character
data_narrow_baseR$treatment_group <- as.character(data_narrow_baseR$treatment_group)
# then we split treatment_group into a list, aka the most unintuitive data type in R
l <- strsplit(data_narrow_baseR$treatment_group, '_')  
# then we convert the list into a matrix, with three columns
m <- matrix(unlist(l), nrow=length(l), ncol=3, byrow=T)  
# convert the matrix into a data frame
df <- data.frame(m)
colnames(df) <- c('gene', 'treatment', 'rep')  # and give the columns of the data frame the names we want

# finally, reassemble our original data frame with our new columns replacing the original "treatment_group"
data_narrow_baseR <- cbind(data_narrow_baseR[c('Line', 'Elapsed', 'Date', 'Experiment')], df,
                         data_narrow_baseR['confluence'])

# let's compare base R data frame to the original Tidyverse one
print(head(data_narrow_baseR))
print(head(data_narrow))

# are all elements the same between the data frames?
table(data_narrow == data_narrow_baseR)
# yes - and it only took all this insanely opaque code to get here!


### Plotting raw confluence data (Figure 1) ###
fig1 <- ggplot(data_narrow,
               aes(x=Elapsed, y=confluence,
                   group=interaction(Experiment, gene, treatment, rep),
                   color=interaction(gene, treatment))) +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.7) +
  scale_color_manual(values=c('greenyellow', 'orange', 'green4', 'orangered3')) +
  theme(aspect.ratio=1, 
        legend.position='top',
        legend.title = element_blank(),
        legend.text = element_text(size=10)) +
  facet_wrap(facets=vars(Line), scales='free')

fig1


### Using "summarize" to operate across groups of data - a toy example ###
data(mpg)  # mileage data from 1999-2008
print(mpg)  # just to check what the data look like

# first we need to group the cars
mpg_by_cyl <- group_by(mpg, cyl) %>% print()
# this has created a new tibble, but we can easily confirm that all elements of the data frame itself
#   are preserved from the original:
table(mpg_by_cyl==mpg)

# identify and summarize car models within each cylinder group
mpg_cyl_summarize <- summarize(mpg_by_cyl,
                               n=n(), hwy_mean=mean(hwy), hwy_sd=sd(hwy), 
                               displ_mean=mean(displ), displ_sd=sd(displ))
print(mpg_cyl_summarize)

# first, without creating a new data frame, we will call "group_by" on the original data,
#   then pipe it to "summarize"
group_by(mpg, cyl) %>% 
  summarize(n=n(), hwy_mean=mean(hwy), hwy_sd=sd(hwy), displ_mean=mean(displ), displ_sd=sd(displ))


### Using "summarize" to combine technical replicates in our proliferation data ###
print(data_narrow)  # just to remind ourselves what the data look like

# calculate mean confluence across technical replicates
data_mean <- group_by(data_narrow, Line, Experiment, Date, Elapsed, gene, treatment) %>%
  summarize(conf_mean=mean(confluence), conf_sd=sd(confluence)) %>% print()
data_mean <- ungroup(data_mean)  # this will be necessary later. and is a good idea generally

# the new data frame should be 1/3 the length of the original, since the triple replicates have been
#   collapsed down to one each - let's confirm
nrow(data_mean) == nrow(data_narrow)/3

# first, add CV as a column to our data frame
data_mean <- mutate(data_mean, conf_cv=conf_sd/conf_mean)


### Data inspection ###
# create base plot
p <- ggplot(data_mean, aes(x=conf_mean, y=conf_cv))

# plot with various color coding schemes
p_line <- p + geom_point(aes(color=factor(Line)), alpha=0.5, size=1)
p_gene <- p + geom_point(aes(color=gene), alpha=0.5, size=1)
p_treatment <- p + geom_point(aes(color=treatment), alpha=0.5, size=1)

plot_grid(p_line, p_gene, p_treatment, align='h')


### Plot mean proliferation data for each experiment (Figure 2) ###
fig2 <- ggplot(data_mean, aes(x=Elapsed, y=conf_mean, 
                              group=interaction(Experiment, gene, treatment),
                              color=interaction(gene, treatment))) +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.7) +
  geom_errorbar(aes(ymin=conf_mean-conf_sd, ymax=conf_mean+conf_sd)) +
  scale_color_manual(values=c('greenyellow', 'orange', 'green4', 'orangered3')) +
  expand_limits(y=0) +
  theme(aspect.ratio=1, 
        legend.position='top',
        legend.title = element_blank(),
        legend.text = element_text(size=10)) +
  facet_wrap(facets=vars(Line), scales='free')

fig2


### Using "filter" to examine subsets of data - a toy example ###
# filter mpg data for top 25% highest highway mileage of automatic transmission cars, and graph
#   the number of models per manufacturer
filter(mpg, str_detect(trans, 'auto')) %>% 
  filter(hwy > quantile(hwy, 0.75)) %>%
  count(manufacturer) %>% 
  ggplot(aes(x=reorder(manufacturer, -n), y=n)) +
    geom_bar(stat='identity') +
    xlab('manufacturer') +
    ylab('number of models')

# doing the same thing with multiple steps
mpg_auto <- filter(mpg, str_detect(trans, 'auto')) %>% print()
mpg_auto_best <- filter(mpg_auto, hwy > quantile(hwy, 0.75)) %>% print()
mpg_auto_best_who <- count(mpg_auto_best, manufacturer) %>% print()
ggplot(mpg_auto_best_who, aes(x=reorder(manufacturer, -n), y=n)) +
  geom_bar(stat='identity') +
  xlab('manufacturer') +
  ylab('number of models')


### Using "filter" to explore our proliferation data ###
# take a quick look at our data in its current form
fig2

# filter for start and end of experiment, and graph mean confluence
filter(data_mean, Elapsed == min(Elapsed)| Elapsed==max(Elapsed))

filter(data_mean, Elapsed == min(Elapsed)| Elapsed==max(Elapsed)) %>% 
  ggplot(aes(x=Elapsed, y=conf_mean, 
             group=interaction(Experiment, gene, treatment),
             color=interaction(gene, treatment))) +
    geom_point() +
    geom_line() +
    scale_color_manual(values=c('greenyellow', 'orange', 'green4', 'orangered3')) +
    expand_limits(y=0) +
    theme(aspect.ratio=1, 
        legend.position='top',
        legend.title = element_blank(),
        legend.text = element_text(size=10)) +
  facet_wrap(facets=vars(Line), scales='free')


### Transforming our data by normalization to t=0 ###
# create new data frame for initial confluence values, get rid of extraneous columns
baseline <- filter(data_mean, Elapsed==0) %>% 
  rename(initial=conf_mean) %>%
  select(-Elapsed, -conf_sd, -conf_cv) %>% print()

# create new data set 'data_fold' by adding initial confluence variable to data_mean
# inner_join will re-use same 'initial' variables across all timepoints
data_fold <- inner_join(data_mean, baseline) %>% print()

# create new variable for fold-change over initial confluence (also standard deviation)
data_fold <- mutate(data_fold, fold=conf_mean/initial, fold_sd=conf_sd/initial) %>% print()

# plot fold-change (with SD) for each cell line/experiment (Figure 3)
fig3 <- ggplot(data_fold, aes(x=Elapsed, y=fold, 
                              group=interaction(Experiment, gene, treatment),
                              color=interaction(gene, treatment))) +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.7) +
  geom_errorbar(aes(ymin=fold-fold_sd, ymax=fold+fold_sd)) +
  scale_color_manual(values=c('greenyellow', 'orange', 'green4', 'orangered3')) +
  expand_limits(y=0) +
  theme(aspect.ratio=1) +
  ylab('net growth') +
  theme(aspect.ratio=1, 
        legend.position='top',
        legend.title = element_blank(),
        legend.text = element_text(size=10)) +
  facet_wrap(facets=vars(Line), scales='free')

fig3

### Summarizing across experiments ###
# calculate mean fold-change (and SD) across experiments
data_fold_mean <- group_by(data_fold, Line, Elapsed, gene, treatment) %>% 
  summarize(fold_mean=mean(fold), fold_mean_sd=sd(fold)) %>% print()
ungroup(data_fold_mean)

# plot mean fold-change (with SD) for each cell line (Figure 4)
fig4 <- ggplot(data_fold_mean, aes(x=Elapsed, y=fold_mean, 
                                   group=interaction(gene, treatment),
                                   color=interaction(gene, treatment))) +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.7) +
  geom_errorbar(aes(ymin=fold_mean-fold_mean_sd, ymax=fold_mean+fold_mean_sd)) +
  scale_color_manual(values=c('greenyellow', 'orange', 'green4', 'orangered3')) +
  expand_limits(y=0) +
  theme(aspect.ratio=1) +
  ylab('net growth') +
  theme(aspect.ratio=1, 
        legend.position='top',
        legend.title = element_blank(),
        legend.text = element_text(size=10)) +
  facet_wrap(facets=vars(Line), scales='free')

fig4

# calculate maximum mean fold change within each cell line, add half-max value to graphs
max_mean <- group_by(data_fold_mean, Line) %>% summarize(max=max(fold_mean)) %>% print()

fig4 <- fig4 + geom_hline(data=max_mean, aes(yintercept=max/2), col='darkgray', lty='dashed')

fig4


### Plot all our data from raw to transformed ###
plot_grid(fig1 + theme(legend.position = "none"),
          fig2 + theme(legend.position = "none"),
          fig3 + theme(legend.position = "none"),
          fig4 + theme(legend.position = "none"),
          labels=c('Fig1', 'Fig2', 'Fig3', 'Fig4'),
          label_size=12)
