# sllobs-biostats

![img](https://i0.wp.com/nextgenseek.com/wp-content/uploads/2014/02/Genes-Reflect-Geography.jpg)

Location
===============
HSEB 1730, 9AM on Mondays, Dates Below


Lectures/Slides
===============
Module 1
--------
- [Lecture 1 (Aaron Quinlan, May 20, 2019): Intro to Data Analysis in RStudio](https://docs.google.com/presentation/d/1KAwoHV03d4eZ6StXmT-ihvZDCzuiXVUaH6C9SOySjhA/edit?usp=sharing)
- [Lecture 2 (Aaron Quinlan, June 3, 2019): RMarkDown and Importing Data](https://docs.google.com/presentation/d/12Fq7OaLR7sdfQ4DvS5qEUcQiWteEtc87JNgHJPRtv88/edit#slide=id.p)
- [Lecture 3 (TBD, June 17, 2019): R Packages, Data Types, Functions]()
- [Lecture 4 (Tom Sasani, July 1, 2019): Plotting in R: types of plots and their purpose]()
- [Lecture 5 (Charlie Murtaugh, July 8, 2019): Data Wrangling with "tidyverse"]()

Slack Group
=============
Join the SLLOBS slack group [here](https://join.slack.com/t/saltlakelearn-7qx8407/shared_invite/enQtNjM0NTE3NDU1MDI1LWY1NzE0YWMxYWQ0Nzg0NmY1ZTk2OTgxY2ZkYzY0YzFlMGY0ZDg4Yjk0NGVhYzhjZmY3MmU0ZGRlNjc3OGZhMTI): 

Overview
========
The goal of the ***Salt Lake Learners of Biostats (SLLOBS)*** is to convene folks at all levels that are interested in learning (and teaching) 
basic concepts in data analysis and statistics for biological research. We will meet bi-weekly on Monday mornings at 9AM for one hour. 

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

Grab bag of things to discuss
========
- survival curves
- Monte Carlo simulations
- Gibbs sampling
- MCMC
- MA plots:
    - https://twitter.com/Noncodarnia/status/1124099713291169800

References (incomplete)
=======================
- [RStudio Primers](https://rstudio.cloud/learn/primers)
- https://lindeloev.github.io/tests-as-linear/
- https://www.huber.embl.de/msmb/
- https://datasciencelabs.github.io/pages/lectures.html
- https://towardsdatascience.com/a-guide-to-data-visualisation-in-r-for-beginners-ef6d41a34174
- https://www.datasciencecentral.com/profiles/blogs/3-types-of-regression-in-one-picture-baba-png

Curriculum
==========
Module 1: Intro to Data Analysis in R
-------------------------------------
- Lecture 1: Goals of the group, Intro to R and RStudio
    - Goals and Motivation
    - Meeting frequency
    - Expectations
    - sharing material
    - sharing knowledge
    - What is R?
    - Why R?
    - Installing RStudio
    - RStudio
    - Calculator
    - Lists
- Lecture 2: Basics of R (I)
    - RMarkdown
    - Vectorization
    - Data types
    - Built-in datasets
    - Importing Data
    	- broken data
- Lecture 3: Basics of R (II)
    - Installing packages
    - Basic Data Wrangling
    - tidyverse
- Lecture 4: Intro to plotting and data visualization
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
        - expected value
	- mean
	- median
	- mode
    - Basic Simulations
    	- coin toss
	- importance of sample size
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
- References: 
    - http://blog.yhat.com/posts/r-lm-summary.html
- Lecture 1: Motivation
    - Examples
    - Complexity
    - What is a linear model?
    - Basic correlation
    - Least Squares
- Lecture 2: Intro to Regression
    - Galton: Regression toward the mean
    - Correlation
    	- Pearson
    	- Spearman
    - Anscombe's Quartet
    - Regression Line
    - Stratification
- Lecture 3: Linear Models
    - lm
    - interpretation of coefficients and p-values
    - impact and handling of outliers
    - confidence intervals
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

Module 4: Advanced Plotting
---------------------------
- Lecture 1: ggplot
- Lecture 2: 1D data plots: barplots, boxplots, violin plots, beewswarm plots, density plots
- Lecture 3: 2D data plots: Scatterplots, hexbin
- Lecture 4: more than two dimensions: faceting, interactive graphics, color

Module 5: Models for count data such as high throughput-sequencing
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
    
Module 6: Mixture Models
------------------------
- Lecture 1: Biological data is often multi-modal. How do we handle this?
    - generate mixtures of normal distributions
- Lecture 2: Expectation Maximization (EM) for reverse engineering the mixtures

Module 7: Clustering
--------------------------------------
- Lecture 1: Intro
    - Why do we cluster data?
    - Measuring similarity
    - k-means clustering
- Lecture 2: Clustering examples with flow cytometry data
    - Data preprocessing
    - Density-based clustering
- Lecture 3: Hierarchical clustering
- Lecture 4: Validating and choosing the number of clusters
- Lecture 5: Detecting Batch effects

Module 8: Testing
---------------------------------------
- Lecture 1: Hypothesis testing
    - types of error
    - revisiting the t-test
    - permutation tests
- Lecture 2: P-value hacking
- Lecture 3: Multiple testing
    - Theory, Implications
    - Bonferonni correction
- Lecture 4: False discovery rate (FDR)
    - P-value histogram
    - Benjamini-Hochberg algorithm for limiting FDR
    - Local FDR
- Lecture 5: Other tests?

Module 9: Distributions
---------------------------------------
- Lecture 1: Different distributions
- Lecture 2: Fitting data to distributions, Q-Q plot

Module 10: Dimensionality Reduction (in progress)
------------------------------------------------
- Dimension reduction
- PCA

Module 11: Special Topics (in progress)
------------------------------------------
- Sampling
- Bootstrapping
- 
