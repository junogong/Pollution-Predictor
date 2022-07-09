# Pollution-Predictor
Using public access pollution data from monitoring sites to create a visualization of various pollutants in selected states.

This was a project done for school in order to further develop skills in R as well as cleaning and obtaining data. The data was public access and had to be cleaned to just the selected states of Colorado, Wyoming, Utah, New Mexico and Texas. The data also had to be cleaned to just the selected pollutants of Ozone, NO2, and fine particulate matter (PM2.5). Data cleaning was done in Excel.

I was in charge of interpolating the data to create a visualization of the states pollution from just the monitoring stations located near the points to be interpolated. The method of interpolation is a type of spatial interpolation called Kriging, Kriging predicts values using a weighted average of points in the neighbourhood, or in this case pollutant concentration from an average of monitoring stations nearby.

To create these Kriging models the data had to be more normally distributed, and had to be fit to variogram models by creating graphs of the semivariance vs distance the models were selected that most closely resembled the plot the points were creating.


![krigpm](https://user-images.githubusercontent.com/104862416/178122812-33d8a170-286d-4e46-b088-09e5ac5e86a0.png)

![krigno](https://user-images.githubusercontent.com/104862416/178122820-909560b3-7c39-423f-ade9-c691d70d6cbb.png)

![krigpm](https://user-images.githubusercontent.com/104862416/178122850-d1bcd1ab-912b-4d58-826f-7d4fc60e61e5.png)

Kriging Variance was used in place of error. 

![MergedImages(1)](https://user-images.githubusercontent.com/104862416/178122869-ca97e30d-aa70-457b-a3ff-506d06a26228.png)

Created for my final project in GGR376 and completed in a group. Full write-up and final assignment available on my website.
