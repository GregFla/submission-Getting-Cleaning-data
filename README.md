# submission-Getting-Cleaning-data

In order to make the code working you have to download the data at the following link:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
This file contain a readme.txt file explaining the experiment and the source of the data,
here is an extract:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. "

The script "run_analysis.R" I made has two objectives:
  -Turning those data into a tidy data set
  -Creating a file with fewer informations about mean of some variables
  
The Script do the following operations: 
  -It search into the downloaded file some informations i specified
  -Then it add some indexes and change variable names in order to make it more readable 
  -By using 3 "for loops" It create a smaller file containing the mean value of the variable
         - The Overall specify on which subject (volunteers) we are working
         - The Second Level is specifying for a specific subject, which activity is studied
         - The Last one is going through the different variables, calculating their mean 
           (for a specific subject and a specific activity)
         
