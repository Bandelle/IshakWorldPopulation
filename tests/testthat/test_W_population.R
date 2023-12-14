# Check to see if I get what I expect

test_that('Test whether a user inputs a
          country name which is in the UN population data set ', {
  expect_error(CountryPopulation('Game'))
  expect_error(CountryPopulation('Toure'))
})
