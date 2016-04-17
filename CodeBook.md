## Code Book



This Code Book describes the files used in the project, and the steps to arrive at the final tidy data set

### Explanation of each files used


- 'features.txt': List of all features - 561 features

- 'activity_labels.txt': Links the class labels with their activity name - 6 activities

- 'train/X_train.txt': Training set - 7352 observations, 561 features.

- 'train/y_train.txt': Training labels -- 7352 observations.

- 'test/X_test.txt': Test set - 2947 observations, 561 features.

- 'test/y_test.txt': Test labels - 2947 observations.

- 'subject_train.txt' : 30 training Subjects, 7352 observations.

- 'subject_test.txt': 30 test Subjects , 2947 observations.


### Process Steps



1. Each data files were read into data frames

2. Meaningful column headers were added to each data frame

3. Extract features only those features having to do with mean, and std (standard deviation)

4. Merge Training Data 

5. Merge Test Data

6. Merge Training and Test Data

7. Melt into skinny data Set

8. Use Dcast to calculate mean 
 
9. Write out data to tidy text file
 
