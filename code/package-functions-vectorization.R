###Week 4 R
###Data types, Packages, Functions and Vectorization

##Example of Vectorization (slide 2)

x=c(1,2,3,4,5)
x
##Slow - using a for loop
x = 1
for (i in seq(2,5)){
  x[i] = 1 + i-1
}
x

##DataFrame (Slide 8)

# Create the data frame.
emp.data <- data.frame(
  emp_id = c (1:5), 
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25), 
  
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
                         "2015-03-27")),
  stringsAsFactors = FALSE
)

# Print the data frame.			
print(emp.data) 

# Get the structure of the data frame.
str(emp.data)
summary(emp.data)


### Logical vectors used in mathematical operations
##Slide 9
x = c(seq_along(1:10))
a = x > 5
a

##Conditions using logical operators
#& = and
#| = or
#! = not

##Create condition that outputs logical statements of the queried vector
##In this case the query is:
##are the values in the column emp_id larger than 2 AND smaller than 5?
emp.data$emp_id >2 & emp.data$emp_id <5

##We can then use the condition to extract only the rows that met the 
##condition (TRUE)
suba = emp.data[emp.data$emp_id >2 & emp.data$emp_id <5,]
suba


##Factors (Slide 10)

##Random vector 100 random state names
?state.name
set.seed(5) ## Set seed is useful for creating simulations or random objects that can be reproduced.
dis_loc = sample(state.name, 100, replace = TRUE)

##Convert to Factor
dis_loc = factor(dis_loc)
dis_loc ##How many levels.. 43 levels

##What are the levels (states)??
levels(dis_loc)
##get the frequency of states
sort(table(dis_loc),decreasing = T)

##let's generate 100 random values -- Number of people per sighting
dis_pat_num = sample(100,100) ##100 samples of size 100 each


##put these vectors in a data frame
dis_df = data.frame(dis_loc,dis_pat_num)

str(dis_df)

##What if we want to get the mean number of cases per state?
##This is one example of the use of a member of apply family
?tapply 
##apply function (mean) to each unique combination of levels 
incmeans <- tapply(dis_pat_num, dis_loc, mean)
incmeans

##Quick plots

par(mar = c(7, 4, 2, 2) + 0.2) ##Increase margins of plot
barplot(incmeans,las=2, cex.names = 0.8,xlab ="",
        ylab = ("Sighting counts"))
##Better plot -- more informative
plot(dis_df$dis_pat_num ~ dis_df$dis_loc, las = 2, cex.axis= 0.8,xlab ="",
     ylab = ("Sighting counts"))


####Lists###
##Slide 12

#Create list
Lst <- list(name="Fred", wife="Mary", no.children=3,
            child.ages=c(4,7,9))

##call elements of list
Lst[[1]]
Lst$name
Lst[2,4]

##Add elements to list -- let's create a matrix and add it to the List (slide 13)
Mat = matrix(c(1:10),2,5)
Lst[5] <- list(matrix=Mat)
Lst
str(Lst)

##create a new list with three elements
list1 <- list(1,2,3)
##merge lists
List_f = c(Lst,list1)

##Convert a list to a vector (slide 14)
v1 <- unlist(List_f)
class(v1)


##Arrays (slide 15)
##create vector with 1500 elements
z = runif(1500)
##transform to array by changing the dimensions
dim(z) <- c(3,5,100)
z

z[,,40] 

##Create array using the function array (slide 16)
vec= runif(24) 
##runif is an important function to random sample from the
##Uniform distribution
Arr = array(vec, dim=c(3,4,2))
Arr

##Available Packages in R from CRAN (slide 19)

a <- available.packages() 
head(rownames(a), 3) 
head(a)

### Install packages in R
##remove.packages("ggplot2")
install.packages("ggplot2")
library(ggplot2)

install.packages(c("e1071", "ggplot2"))

###Install Bioconductor (Slide 24)
##the next if statement is needed only once to install bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

##Install one or multiple bioconductor packages
BiocManager::install(c("GenomicFeatures", "AnnotationDbi"))

##Add gene names to rnaseq dataset that contains ensembl gene IDS (slide 25)
BiocManager::install("biomaRt")


###Set Directory
###
setwd("/your/directory/here/")

##read document
rnaseq = read.table("airway_scaledcounts.subset.euro.fixed.tsv",header = T, dec = ",")

##subset to only 300 observations, ALL columns
rnaseq_small = rnaseq[c(1:300),]

## call library Biomart
library(biomaRt)

##Create MART object that has the database information
grch37 = useMart(biomart="ENSEMBL_MART_ENSEMBL", 
                 host="grch37.ensembl.org", 
                 path="/biomart/martservice",
                 dataset="hsapiens_gene_ensembl")

##query Mart with a set of values (gene names), to obtain attributes
geneID = getBM(
  filters= "ensembl_gene_id", 
  attributes= c("ensembl_gene_id","external_gene_name","chromosome_name","start_position"),
  values= rnaseq_small$ensgene,
  mart= grch37)

head(geneID)
##Possible filters and attributes for query
filters_37 = listFilters(grch37)
attr_37 = listAttributes(grch37)


###Merge data frames
rnaseq_names = merge(rnaseq_small,geneID,by.x = "ensgene", by.y = "ensembl_gene_id")

##reshuffle columns to make it more organized
rnaseq_names = rnaseq_names[,c(1,6,7,8,2:5)]


##Functions

##For loop (Slide 31)

for(i in seq_along(1:10)){
  print(log(i))
}

#Vectorized
a = c(1:10)
log(a)


##while loops (slide 32)
a = 0; b =1
print(a)
while (b < 50) { 
  print(b) 
  temp <- a + b 
  a <- b 
  b <- temp 
  }


##If loop (slide 33)
##this if statement was not explained in class but it is a good example
##of how to deal with time and dates in R

##How long do I have left for the class??
##Create a variable that stores the time for the end of the class
time2 = strptime(c("10:00"), format= "%H:%M")

##How long before the end of the class?
time2 - Sys.time()

##if there is no time left add message if there is time left tell me how much is left
if (time2 - Sys.time() < 0 ){
  print("Time's up")
}else{
  print(paste("we have",time2 - Sys.time(),"hours to how"))
}

##Writing functions (slide 35)
doubleVal = function(n){
  doub = 2 * n
  return(doub)
  }

doubleVal(c(5,6,4,5,6))

##Vectorized form
f <- function(x = 1) x * 2

f(c(5,6,4,5,6))

## functions (slide 37)
fahrenheit_to_kelvin <- function(temp_F) {
  temp_K <- ((temp_F - 32) * (5 / 9)) + 273.15
  return(temp_K)
}

#(slide 38)
kelvin_to_celsius <- function(temp_K) { 
  temp_C <- temp_K - 273.15 
  return(temp_C) 
}

kelvin_to_celsius(0)


fahrenheit_to_celsius <- function(temp_F) {
  temp_K <- fahrenheit_to_kelvin(temp_F)
  temp_C <- kelvin_to_celsius(temp_K)
  return(temp_C)
}

fahrenheit_to_celsius(32.0)

##Nested functions (slide 39)
kelvin_to_celsius(fahrenheit_to_kelvin(32.0))

f <- function(x = 1) x * 2
f(4)

##Random Walk (slide 43)
##First function that contains for loops

rw2d1A =
  function(n) {
    xpos = numeric(n)
    truefalse = c(TRUE, FALSE)
    plusminus1 = c(1, -1)
    for(i in 2:n)
      # Decide whether we are moving horizontally
      # or vertically.
      if (sample(truefalse, 1)) {
        xpos[i] = xpos[i-1] + sample(plusminus1, 1)
      }
    else {
      xpos[i] = xpos[i-1] - sample(plusminus1, 1)
    }
    #rw1Plot = plot(seq_along(1:n),xpos)
    list(x = xpos)
  }

system.time(rw2d1A(100000))
plot(seq_along(1:100),rw2d1A(100)[[1]])

##Vectorized form that initializes the vector and uses the cumsum function to expand
##the vector
rw2d5A =
  # Sample from 4 directions, not horizontally and verticallly
  # separately.
  function(n = 100000) {
    xsteps = c(-1,  1,  0,  0)
    dir = sample(1:4, n - 1, replace = TRUE)
    xpos = c(0, cumsum(xsteps[dir]))
    list(x = xpos)
  }

system.time(rw2d5A(100000))
plot(seq_along(1:100),rw2d5A(100)[[1]])



####Apply Family (slide 45)

apply(rnaseq_names[,c(4:7)], 2, mean,na.rm=TRUE)


###Homework answers
##Two dimensional Random Walk multiple versions, version 5 is ultra vectorized.
##Example taken from https://www.stat.auckland.ac.nz/~ihaka/downloads/Taupo-handouts.pdf

rw2d1 =
  function(n) {
    xpos = ypos = numeric(n)
    truefalse = c(TRUE, FALSE)
    plusminus1 = c(1, -1)
    for(i in 2:n)
      # Decide whether we are moving horizontally
      # or vertically.
      if (sample(truefalse, 1)) {
        xpos[i] = xpos[i-1] + sample(plusminus1, 1)
        ypos[i] = ypos[i-1]
      }
    else {
      xpos[i] = xpos[i-1]
      ypos[i] = ypos[i-1] + sample(plusminus1, 1)
    }
    list(x = xpos, y = ypos)
  }



rw2d2 =
  # Replace sample with runif()
  function(n) {
    xpos = ypos = numeric(n)
    for(i in 2:n) {
      if (runif(1) > .5) {
        xpos[i] = xpos[i-1] + 2 * (runif(1) > .5) - 1
        ypos[i] = ypos[i-1]
      }
      else {
        xpos[i] = xpos[i-1]
        ypos[i] = ypos[i-1] + 2 * (runif(1) > .5) - 1
      }
    }
    list(x = xpos, y = ypos)
  }

rw2d2.5 =
  # Vectorize the runif() to generate all n in one go.
  function(n)
  {
    xpos = ypos = numeric(n)
    horOrVert = runif(n) > .5
    delta = 2 * (runif(n) > .5) - 1
    for(i in 2:n) {
      if (horOrVert[i]) {
        xpos[i] = xpos[i-1] + delta[i]
        ypos[i] = ypos[i-1]
      }
      else {
        xpos[i] = xpos[i-1]
        ypos[i] = ypos[i-1] + delta[i]
      }
    }
    list(x = xpos, y = ypos)  
  }

rw2d3 =
  # 
  # Here we get rid of the loop.
  # We generate a collection of +1 and -1 values at random
  # Then we generate a collection of TRUE and FALSE values
  # indicating whether this is a horizontal or vertical move.
  # And we get rid of the loop by using the function cumsum()
  # But we can't just cumsum the values in steps. We have to
  # do this conditional on xdir.  But this is where the vectorized
  # function ifelse() is very powerful.
  function(n) {
    steps = 2 * (runif(n - 1) >  .5) - 1
    xdir = runif(n - 1) >  .5
    xpos = c(0, cumsum(ifelse(xdir, steps, 0)))
    ypos = c(0, cumsum(ifelse(xdir, 0, steps)))
    list(x = xpos, y = ypos)
  }

rw2d4 =
  # Bring sample back!
  function(n) {
    steps = sample(c(-1, 1), n - 1,
                   replace = TRUE)
    xdir = sample(c(TRUE, FALSE), n - 1,
                  replace = TRUE)
    xpos = c(0, cumsum(ifelse(xdir, steps, 0)))
    ypos = c(0, cumsum(ifelse(xdir, 0, steps)))
    list(x = xpos, y = ypos)
  }

n=10

rw2d5 =
  # Sample from 4 directions, not horizontally and verticallly
  # separately.
  function(n) {
    xsteps = c(-1,  1,  0,  0)
    ysteps = c( 0,  0, -1,  1)
    dir = sample(1:4, n - 1, replace = TRUE)
    xpos = c(0, cumsum(xsteps[dir]))
    ypos = c(0, cumsum(ysteps[dir]))
    list(x = xpos, y = ypos)
  }


system.time(rw2d1(100000))
system.time(rw2d2(100000))
system.time(rw2d2.5(100000))
system.time(rw2d3(100000))
system.time(rw2d4(100000))
system.time(rw2d5(100000))




