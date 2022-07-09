#Loading libraries and dataset
install.packages("gstat")
install.packages("sp")
install.packages("tibble")
library(tidyverse)
library(ggplot2)
library(readxl)
library(gstat)
library(sp)
library(tibble)

#CHANGE FILE LOCATION TO DATA SHEET HERE

Rain_data <- read_excel("/Users/junogong/Library/Containers/com.apple.iWork.Numbers/Data/Documents/ggr376 assignment 3/A3Data.xlsx")


#Seperating pollutants and creating SpatialPointsDataFrames

NO2 <- Rain_data %>% 
  filter(`Parameter Name` == "Nitrogen dioxide (NO2)")

NO2 %>% 
  mutate(x = Longitude)

NO2$x <- NO2$Longitude

NO2 %>% 
  mutate(y = Latitude)

NO2$y <- NO2$Latitude

coordinates(NO2) <- ~ x + y

Ozone <- Rain_data %>% 
  filter(`Parameter Name` == "Ozone")

Ozone %>% 
  mutate(x = Longitude)

Ozone$x <- Ozone$Longitude

Ozone %>% 
  mutate(y = Latitude)

Ozone$y <- Ozone$Latitude

coordinates(Ozone) <- ~ x + y

PM25 <- Rain_data %>% 
  filter(`Parameter Name` == "PM2.5 - Local Conditions")

PM25 %>% 
  mutate(x = Longitude)

PM25$x <- PM25$Longitude

PM25 %>% 
  mutate(y = Latitude)

PM25$y <- PM25$Latitude

coordinates(PM25) <- ~ x + y

#Distributing Data to be normal

hist(NO2$`Observation Count`)

NO2@data$logNO2 <- log(NO2@data$`Observation Count`)

hist(NO2@data$logNO2)


hist(Ozone@data$`Observation Count`)

Ozone@data$logOz <- log(Ozone@data$`Observation Count`)

hist(Ozone@data$logOz)


hist(PM25$`Observation Count`)

PM25@data$logPM <- log(PM25@data$`Observation Count`)

hist(PM25@data$logPM)


#Creating Variogram

NO2.vgm <- variogram(NO2@data$logNO2~1, NO2)
plot(NO2.vgm)
#nug

Oz.vgm <- variogram(Ozone@data$logOz~1, Ozone)
plot(Oz.vgm)
#lin

PM25.vgm <- variogram(PM25@data$logPM~1, PM25)
plot(PM25.vgm)
#per

#Fitting Variogram Models

NO2.fit <- fit.variogram(NO2.vgm, model = vgm("Wav"))
plot(NO2.vgm, NO2.fit)

Oz.fit <- fit.variogram(Oz.vgm, model = vgm("Lin"))
plot(Oz.vgm, Oz.fit)

PM25.fit <- fit.variogram(PM25.vgm, model = vgm("Sph"))
plot(PM25.vgm, PM25.fit)

#Create convex hull and polygons from hull

chpids_NO2 <- NO2@coords %>% 
  chull()

chp_NO2 <-NO2@coords[chpids_NO2,] %>% 
  as.data.frame()


crds_NO2 <- coordinates(chp_NO2)

polyNO2 <- sp::Polygon(crds_NO2)

ID <- "Minimum Boundary"
Pls_NO2 <- Polygons(list(polyNO2), ID=ID)

SPls_NO2 <-SpatialPolygons(list(Pls_NO2))
plot(SPls_NO2)


chpids_Oz <- Ozone@coords %>% 
  chull()

chp_Oz <-Ozone@coords[chpids_Oz,] %>% 
  as.data.frame()


crds_Oz <- coordinates(chp_Oz)

polyOz <- sp::Polygon(crds_Oz)

ID <- "Minimum Boundary"
Pls_Oz <- Polygons(list(polyOz), ID=ID)

SPls_Oz <-SpatialPolygons(list(Pls_Oz))
plot(SPls_Oz)


chpids_PM25 <- PM25@coords %>% 
  chull()

chp_PM25 <-PM25@coords[chpids_PM25,] %>% 
  as.data.frame()


crds_PM25 <- coordinates(chp_PM25)

polyPM25 <- sp::Polygon(crds_PM25)

ID <- "Minimum Boundary"
Pls_PM25 <- Polygons(list(polyPM25), ID=ID)

SPls_PM25 <-SpatialPolygons(list(Pls_PM25))
plot(SPls_PM25)

#Creating grids for each polygon

grid_NO2 <- makegrid(SPls_NO2, cellsize = 0.5)

coordinates(grid_NO2) <- ~x1 + x2


PolyGrid_NO2 <- sp::over(grid_NO2, SPls_NO2)
gridpred_NO2 <- grid_NO2[!is.na(PolyGrid_NO2)]

plot(gridpred_NO2)

grid_Oz <- makegrid(SPls_Oz, cellsize = 0.5)

coordinates(grid_Oz) <- ~x1 + x2


PolyGrid_Oz <- sp::over(grid_Oz, SPls_Oz)
gridpred_Oz <- grid_Oz[!is.na(PolyGrid_Oz)]

plot(gridpred_Oz)

grid_PM25 <- makegrid(SPls_PM25, cellsize = 0.5)

coordinates(grid_PM25) <- ~x1 + x2


PolyGrid_PM25 <- sp::over(grid_PM25, SPls_PM25)
gridpred_PM25 <- grid_PM25[!is.na(PolyGrid_PM25)]

plot(gridpred_PM25)

#Predicting Values

NO2_krige1 <- krige(logNO2~1, NO2, gridpred_NO2, model = NO2.fit)

spplot(NO2_krige1, "var1.pred")

Oz_krige1 <- krige(logOz~1, Ozone, gridpred_Oz, model = Oz.fit)

spplot(Oz_krige1, "var1.pred")

PM25_krige1 <- krige(logPM~1, PM25, gridpred_PM25, model = PM25.fit)

spplot(PM25_krige1, "var1.pred")

#Kriging Variance

spplot(NO2_krige1, "var1.var")

spplot(Oz_krige1, "var1.var")

spplot(PM25_krige1, "var1.var")







