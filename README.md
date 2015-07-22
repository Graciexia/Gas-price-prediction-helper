Gas Helper
----------

A Website for users find a good deal when they plan to refill the gas. 

 - Gas price forecast 
   Through of the complex algorithm based the daily
   price trend of crude oil and gas it will can make tomorrow's average
   gas price of 3 different of fuel grade in most city of USA. After
   compared today's price and predicted price of tomorrow, it will
   suggest you buy it today or wait until tomorrow.
 - Mileage Calculator
   After the user submit the info about his cars, he
   can check out his car's different mileage cost(highway,city and
   comb). Also after he input how many miles he plan to drive , he can
   get the total cost  and compare it with the the gas sipper and gas
   guzzle the cost of which will be updated simultaneously.
 - Trend Graph
   The app can show the recent 30 days' daily price trend of
   the crude oil and the gas in your city.
 
 - Change your car's profile 
   In case of you changed a new car, just go
   to your car's profile to edit and save it.

Check out the live site: https://gas-helper.herokuapp.com/ .

How to user
-----------

 - Sign UP
 - Submit your car's profile
 - Go anywhere you want  to check out
   Four icons in the home page link to the main function

What was used
-------------

JS, jQuery,HTML, Sass
Devise for logging in.
Kimono'API to crawl the data website.
Nokogiri gem for building up my own crawller in model of GasPrice and OilPrice) .
Whenever gem for pulling off data at the set up time everyday.
Chartkick and Groupdate for making the graph.
Font-awesome-sass for icon.
Parallax.js 
Check out the [Gemfile](https://github.com/Graciexia/Gas-price-prediction-helper/blob/master/Gemfile) to see all that was used.
Rails (4.2.1)
Hosting by Heroku
Postgresql Database
Puma webserver

More info
---------

[trello](https://trello.com/b/0hGAFtEw/final-project-gas-prediction) scrum board
Data Scouce:
gas price:  http://fuelg## Heading ##augereport.aaa.com
oil price:  http://finance.yahoo.com/q/hp?s=%5EXOI+Historical+Prices
mileage cost: 2015 IRS Mileage Rate Report



s