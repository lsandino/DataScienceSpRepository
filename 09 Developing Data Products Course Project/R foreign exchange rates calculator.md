

R Foreign Exchange Rates Calculator
========================================================
author: Luis A Sandino
date: 12 April 2016
autosize: false
width: 1440
height: 900
transition: rotate
font-family: 'Helvetica'
Summary
========================================================

This application uses current and historical foreign exchange rates published by the *European Central Bank* obtained through **Fixer.io**, a free JSON API for foreign exchange rates and currency conversion.

It performs three basic tasks:

- Informs about the current exchange rate between the base and the desired currency
- Calculates the equivalence in the desired currency of a base value entered by the user
- Displays the evolution of the exchange rate in the last month

For more details on the JSON API and the Exchange Rates please visit:
- <http://http://fixer.io/>
- <http://www.ecb.europa.eu/stats/exchange/eurofxref/html/index.en.html>

How to use 
========================================================

- At initialization (data loading can take a couple minutes, be patient), the application shows the current exchange rate between Euros and US Dollars, and the its evolution during the last month. 

- The user can select from two lists the base and desired currencies. The acronyms for the currencies are in the next slide.

- There is a numeric input to calculate the equivalence of any desired value.

- Results are updated dynamically as the inputs are changed.

How to use (cont.)
========================================================

Available currencies are coded with the following acronyms:

|   Acr.   |       Currency       |   Acr.   |       Currency        |   Acr.   |         Currency          |   Acr.   |        Currency        |
|:--------:|:--------------------:|:--------:|:---------------------:|:--------:|:-------------------------:|:--------:|:----------------------:|
|   USD    |      US dollar       |   RON    |     Romanian leu      |   CAD    |      Canadian dollar      |   NZD    |   New Zealand dollar   |
|   JPY    |     Japanese yen     |   SEK    |     Swedish krona     |   CNY    |   Chinese yuan renminbi   |   PHP    |    Philippine peso     |
|   BGN    |    Bulgarian lev     |   CHF    |      Swiss franc      |   HKD    |     Hong Kong dollar      |   SGD    |    Singapore dollar    |
|   CZK    |     Czech koruna     |   NOK    |    Norwegian krone    |   IDR    |     Indonesian rupiah     |   THB    |       Thai baht        |
|   DKK    |     Danish krone     |   HRK    |     Croatian kuna     |   ILS    |      Israeli shekel       |   ZAR    |   South African rand   |
|   EUR    |         Euro         |   RUB    |    Russian rouble     |   INR    |       Indian rupee        |   ISK    |    Icelandic krona     |
|   GBP    |    Pound sterling    |   TRY    |     Turkish lira      |   KRW    |     South Korean won      |          |                        |
|   HUF    |   Hungarian forint   |   AUD    |   Australian dollar   |   MXN    |       Mexican peso        |          |                        |
|   PLN    |     Polish zloty     |   BRL    |    Brazilian real     |   MYR    |     Malaysian ringgit     |          |                        |


How it works
========================================================

Here is an example of how the data is loaded:

```r
t <- now() 
t <- t %m-% months(1)
t <- as.Date(paste(year(t),month(t),day(t),sep="-"))
base <- "EUR"
desired <- "USD"
url <- paste("http://api.fixer.io/",as.character(t),"?base=",base,sep="")
data <- fromJSON(file=url,method="C")
i <- match(desired,names(data$rates))
paste("1",base,"=",as.character(as.numeric(data$rates[i])),desired,sep=" ")
```

```
[1] "1 EUR = 1.1109 USD"
```
