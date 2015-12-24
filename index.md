---
title       : Price Explorer
subtitle    : European and Asian Options
author      : Andareiro
job         : Coursera Data Science Student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---




## Options Price Explorer: Rationale

*Challenge:* Students of finance and financial engineering face a daunting challenge in understanding the array of options contracts in use today. In particular, students must grapple with how the value of an option changes in response to changes in the market environment. Different options respond in different ways.

*Solution:* The Options Price Explorer! This tool presents an interactive visualization to allow students to explore how two different options respond differently to changes in the market environment, specifically: volatility, underlying price, and tenor.

[Price Explorer](https://andareiro.shinyapps.io/app_one) on [ShinyApps.io](http://www.shinyapps.io/)

[Project code]() on [GitHub](https://github.com/)

--- .class #id 

## Conventional Approach

### How would a student normally compare the behavior of two options?

A common approach is for a student to use a "scenario table," where the price of the option is compared as two variables change; in this case, the price of the underlying and volatility:

*Change in value of a European option as price of the underlying and volatility change; strike of 400, maturity of 1 year held constant.*
*Columns headings: volatility; rows: underyling price.*

```
##     0.15  0.2 0.25  0.3 0.35
## 395 26.0 33.8 41.5 49.3 57.0
## 396 26.6 34.3 42.1 49.9 57.6
## 397 27.1 34.9 42.7 50.4 58.2
## 398 27.7 35.5 43.3 51.0 58.8
## 399 28.3 36.1 43.8 51.6 59.4
## 400 28.9 36.7 44.4 52.2 60.0
## 401 29.5 37.2 45.0 52.8 60.6
## 402 30.1 37.8 45.6 53.4 61.2
## 403 30.7 38.4 46.2 54.0 61.8
## 404 31.3 39.0 46.8 54.6 62.4
## 405 31.9 39.7 47.4 55.2 63.0
```

--- .class #id

## Visualization

Converting this table to a vizualization makes it easier to present a much more data-dense view. It is apparent that the value of the European option is higher than the Asian option, and how this difference changes as the price of the underlying moves away from the strike price of 400.

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

Our Price Explorer tool goes one step further - and makes this visualization interactive!

--- .class #id 
## Building blocks
We can build interactive vizualizations with the powerful tools at our disposal in the R programming ecosystem.

* _RQuantLib:_ Pricing models to calculate option values and greeks
* _Shiny:_ Interactive vizualitions on an open platform
* _GitHub:_ Publish our code and collect contributions from other quant finance developers


--- .class #id 

## Further Development
We can extend the capabilities of the Price Explorer with further support:

1. Manipulate the axes to represent additional variables
2. Move to the third dimension! Volatility x Underyling Price x Value, and beyond
3. Vizualize the "greeks" - values that describe an option's behavior in a changing market environment

### How can you help?
Contribute to [our Shiny app code]() on GitHub and expand the capabilities! The tool will become more useful the more contributors join in.

--- .class #id 
