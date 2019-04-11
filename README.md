# sllobs-biostats

![img](https://i0.wp.com/nextgenseek.com/wp-content/uploads/2014/02/Genes-Reflect-Geography.jpg)

Overview
========
The goal of the ***Salt Lake Lovers of Biostats (SLLOBS)*** is to convene folks at all leves that are interested in learning (and teaching) 
basic concepts in data analysis and statistics for biological research. We will meet ???weekly (bi-weekly?)??? for one hour. 

One or more people will work together to learn and present a topic each week. ***The goal of each lecture is to***:
    - Give an accessible introduction to the topic
    - Provide clear examples and explanations
    - Demonstrate R code that conveys the topic 

This will indeed require effort by the presenter, but the idea is that a large group of interested folks will 
provide a large pool of both teachers and learners. 

The vision is that if we all attend and put our best effort forward, we will all learn together and have a shared 
foundation for future learning and discussion.

Expectations
============
***To be successful, SLLOBS will need to***:
    - attend (most) every meeting
    - read any required material before each lecture
    - make a concerted effort to contribute and present material for the group.
If members follow these expectations, we will have a large corpus of teaching and learning material that will be 
available to refer back to. Furthermore, ***it will be the basis for a formal course in the future***.

Open Questions
==============
1. ***WHERE (EIHG auditorium?)***
2. ***WHEN (I propose Monday mornings)***
3. ***FREQUENCY (I propose weekly or biweekly)***
4. ***Can we get departmental support for coffee, bagels, etc.?***

References (incomplete)
=======================
- https://lindeloev.github.io/tests-as-linear/
- https://www.huber.embl.de/msmb/
- https://datasciencelabs.github.io/pages/lectures.html
- https://towardsdatascience.com/a-guide-to-data-visualisation-in-r-for-beginners-ef6d41a34174

Curriculum
==========
Module 1: Intro to Data Analysis in R
-------------------------------------
- Lecture 1: Goals of the group, Intro to R and RStudio
    - Goals and Motivation
    - Expectations
    - What is R?
    - Why R?
    - Installing RStudio
- Lecture 2: Basics of R (I)
    - Motivation
    - Gentle intro to R programming
    - Installing packages
    - Data types
    - Descriptive Statistics
- Lecture 3: Basics of R (II)
    - Basic Data Wrangling
    - Importing Data
    - Basic Plots
    - Basic Programming
- Lecture 4: Basic Plots
	- Why
    - plot()
        - customizing
    - Scatter Plot
    - Regression Line (details later)
    - Barplot
    - Histograms
    - Boxplots and better versions thereof

Module 2: Intro to Probability and Inference
--------------------------------------------
- Lecture 1: Probability
    - Discrete Random Variables
    	- Bernouli trials
	- Binomial success counts
	- Poisson distributions
    - Continuous Random Variables
    - Descriptive Statistics
    - Basic Simulations
- Lecture 2: Inference (I)
    - Random variable probability distributions
    - Expected Values
    - Standard Error
    - Variance and standard deviation
- Lecture 3: Maximum Likelihood
    - Problem setup
    - Work through an example
- Lecture 4: Inference (II)
    - Estimates
    - Central Limit Theorem
    - Confidence Intervals
- Lecture 5: Inference (III)
    - Developing Models
    - Intro to Bayesian Inference
    - Bayesian Thinking

Module 3: Regression
-------------------------------------
- Lecture 1: Motivation
    - Examples
    - Complexity
    - What is a linear model?
    - Basic correlation
    - Least Squares
- Lecture 2: Intro to Regression
    - Correlation
    	- Pearson
    	- Spearman
    - Anscombe's Quartet
    - Regression Line
    - Stratification
- Lecture 3: Linear Models
    - lm
    - Interpretation with Examples
- Lecture 4: Generalized Linear Models
    - Why?
    - How to design them
    - Example: Sasani et al, DNM counts?

- Lecture 6: Most statistical tests are really just linear models
    - One mean tests: 
        - One sample t-test and Wilcoxon signed-rank
        - One mean tests: Paired samples t-test and Wilcoxon matched pairs
- Lecture 7: Most statistical tests are really just linear models (cont.)
    - Two means tests: 
        - Independent t-test
	- Mann-Whitney U
	- Welch's t-test
- Lecture 8: Most statistical tests are really just linear models (cont.)
     - Three or more means
         - One-way ANOVA and Kruskal-Wallis
	 - Two-way ANOVA
	 - ANCOVA
- Lecture 9: Goodness of fit tests

Module 4: Models for count data such as high throughput-sequencing
-------------------------------------------------------------------
- Lecture 1: Intro
    - Challenges of count data
    - RNA-seq
    - Modeling Count Data
       - Dispersion
       - Normalization
- Lecture 2:
    - Poisson noise
    - Biological signal
    - Biological and technical replicates
- Lecture 3: DeSeq2
    - the method
    - analyses and examples
- Lecture 4: Misc
    - Outliers
    - Count data transformations

Module 5: Clustering
--------------------------------------
Lecture 1: Intro
    - Why do we cluster data?
    - Measureing similarity
    - k-means clustering
Lecture 2: Clustering examples with flow cytometry data
    - Data preprocessing
    - Density-based clustering
Lecture 3: Hierarchical clustering
Lecture 4: Validating and choosing the number of clusters
Lecture 5: Detecting Batch effects
