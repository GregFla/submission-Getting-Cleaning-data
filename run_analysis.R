# Let's start by setting they working directory and the access
# to the different files.

working_dir<-getwd()
file_test<-paste(getwd(),"/UCI HAR Dataset/test",sep="")
file_train<-paste(getwd(),"/UCI HAR Dataset/train",sep="")
file_main<-paste(getwd(),"/UCI HAR Dataset",sep="")

# Then we open the different files and read them
# _test and _train first, then the "overall" files from the main directory

setwd(file_test)
test_x<-as.data.frame(read.table("X_test.txt"))
test_y<-as.data.frame(read.table("Y_test.txt"))
test_subject<-as.data.frame(read.table("subject_test.txt"))

setwd(file_train)
train_x<-as.data.frame(read.table("X_train.txt"))
train_y<-as.data.frame(read.table("Y_train.txt"))
train_subject<-as.data.frame(read.table("subject_train.txt"))

setwd(file_main)
act_labl<-as.data.frame(read.table("activity_labels.txt"))
features<-as.data.frame(read.table("features.txt"))

# Let's merge train, test and subject data using rbind

dat_x<-rbind(test_x, train_x)             
dat_y<-rbind(test_y,train_y)
dat_subject<-rbind(test_subject,train_subject)

# Now they are merged, we also give them a name
# dat_y and dat_subject are just index

colnames(dat_y)<-"label_code"
colnames(dat_subject)<-"subject"

# Then I create a new index to make the link between the label code (1..6) in data_y
# and the real name of the experiment (Walking / Standing / etc ..)

label<-vector(length = length(dat_y[,1]))
label[dat_y$label_code %in% 1]<-as.character(act_labl[1,2])
label[dat_y$label_code %in% 2]<-as.character(act_labl[2,2])
label[dat_y$label_code %in% 3]<-as.character(act_labl[3,2])
label[dat_y$label_code %in% 4]<-as.character(act_labl[4,2])
label[dat_y$label_code %in% 5]<-as.character(act_labl[5,2])
label[dat_y$label_code %in% 6]<-as.character(act_labl[6,2])

# In order to extract only the columns from dat_x that refere to mean or standard deviation,
# we use grep function to find the list of names the expected ones.
# Then we creat extr_dat_x containing only the expected columns from dat_x.

extr<-grep("mean|std", features[,2])
extr_dat_x<-dat_x[extr]
colnames(extr_dat_x)<-features[,2][extr]

# We now merged the extract of dat_x, the label crated above, and the informations
# coming from the "overall" files.

dat<-cbind(label,dat_y, dat_subject, extr_dat_x)

# In order to fill the tidy data set, i made 3 for loops
# The Overall specify on which subject we are working
# The Second Level is specifying for a specific subject, which activity is studied
# The Last one is going through the different variables, calculating her mean 
# (for a specific subject and a specific activity)

tidy<-as.data.frame(matrix(nrow = 180, ncol = length(dat[1,])-1))       
p<-length(dat[1,])-3                                                    
for (i in 1:30){
      for (z in 1:6){
            for (j in 1:p){
                  tidy[i*6+z-6,j+2]<-mean(dat[,j+3][dat$subject %in% i & dat$label_code %in% z])
            }
      tidy[i*6+z-6,1]<-z
      tidy[i*6+z-6,2]<-i
      }
}

# We just rename the different columns

for(j in 1:p){
      names(tidy)[j+2]<-names(dat)[j+3]
}
names(tidy)[1]<-"label_code"
names(tidy)[2]<-"subject"

# We end by adding the label index, in order to have a clear view when we read the file

final<-cbind(label=rep(act_labl[,2],30), tidy)

# Finaly we go back to the main directory and save our data frame in a txt file called "final.csv"

setwd(working_dir)
write.table(final, "final.txt", row.names=FALSE)