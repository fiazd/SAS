*Daanish Fiaz;
*Create a histogram of weight and interpret it;
*The distribution of the graph is centered around 3500 because it has the highest percentage of cars.
*The ranges goes all the way up to about 6000 and all the way down to 2000. Overall, most cars weigh 3500 lbs.;
PROC UNIVARIATE DATA = Cars;
	VAR WEIGHT;
	HISTOGRAM;
RUN;

*Histogram of length variable;
*Distribution of length is not normally distributed, this is because there are a lot of cars that have a length of 192 and 176 but not 184.
*But at the same time, the rest of the histogram is somewhat normally distributed.;
PROC UNIVARIATE DATA = Cars;
	VAR LENGTH;
	HISTOGRAM;
RUN;

*Vertical side by side box plots of weight for different types of cars.;
*SUV'S seem to be the heaviest;
PROC BOXPLOT DATA = Cars;
	PLOT WEIGHT*TYPE;
RUN;

*Horizontal side by side boxplots of length for different types of cars;
*Sports cars seem to be the shortest;
PROC BOXPLOT DATA = Cars;
	PLOT LENGTH*TYPE /
		boxstyle = schematic
		HORIZONTAL;
RUN;

*Side by side histograms of invoice of cars from different origin;
*European cars seem to be the most expensive.;
PROC UNIVARIATE DATA = Cars;
	VAR INVOICE;
	CLASS ORIGIN;
	HISTOGRAM /nrows = 3;
RUN;

*Scatter plot of enginsize and mpg_city with different colors for each region.;
*The smaller the engine size the greater the MPG. The bigger the engine size the lower the MPG.;
PROC SGPLOT DATA = Cars;
	SCATTER X = ENGINESIZE Y = MPG_CITY / group = ORIGIN;
RUN;

*Scatter plot of enginesize and mpg_city with regression line and confidence bounds;
*Same trend, smaller the engine, higher the mpg;
PROC REG DATA = Cars;
	MODEL MPG_CITY = ENGINESIZE;
RUN;
QUIT;

*Subset data include cars with 4 and 6 cyclinders;
DATA CARS_SUB;
	SET Cars;
	IF Cylinders in ("4","6");
RUN;

*hypothesis test for difference in means of horsepower
*H0 = All the cars have the same horsepower no matter the number of cylinders.
*HA = The cars have different horsepower;
*p val < 0.001;
*This means that the cars do differ from one another significantly and we reject the null hypothesis.;
PROC TTEST DATA = Cars;
	VAR HORSEPOWER;
RUN;
*Moved cars_sub to data2 under documents;
PROC IMPORT OUT = Data2.Cars_sub;
		DATAFILE = "C:\Users\fiazd\AppData\Local\Temp\Sas Temporary Files\Work\Cars_sub"
		DBMS = TAB REPLACE;
	GETNAMES = YES;
	DATAROW = 2;
RUN;

*Basic summary for all numerical vars in orig dataset;
*MSRP INVOICE ENGINESIZE CYLINDERS HORSEPOWER MPG_CITY MPG_HIGHWAY WEIGHT WHEELBASE LENGTH;
PROC MEANS DATA = Cars;
	VAR MSRP INVOICE ENGINESIZE CYLINDERS HORSEPOWER MPG_CITY MPG_HIGHWAY WEIGHT WHEELBASE LENGTH;
RUN;
