# Pollution-Predictor
Using public access pollution data from monitoring sites to create a visualization of various pollutants in selected states.

This was a project done for school in order to further develop skills in R as well as cleaning and obtaining data. The data was public access and had to be cleaned to just the selected states of Colorado, Wyoming, Utah, New Mexico and Texas. The data also had to be cleaned to just the selected pollutants of Ozone, NO2, and fine particulate matter (PM2.5). Data cleaning was done in Excel.

I was in charge of interpolating the data to create a visualization of the states pollution from just the monitoring stations located near the points to be interpolated. The method of interpolation is a type of spatial interpolation called Kriging, Kriging predicts values using a weighted average of points in the neighbourhood, or in this case pollutant concentration from an average of monitoring stations nearby.

To create these Kriging models the data had to be more normally distributed, and had to be fit to variogram models by creating graphs of the semivariance vs distance the models were selected that most closely resembled the plot the points were creating.


Created for my final project in GGR376 and completed in a group. Full write-up and final assignment available on my website.
