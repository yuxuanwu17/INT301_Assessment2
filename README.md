Assessment2

## Project overview 

This task includes five algorithms to classify the characters segmented from the license plates of automobiles using MATLAB
- MLP (multi-layer perceptron)
- CNN (convolutional neural network)
- LVQ (learning vector quantization)
- RBF1 with k-means clustering
- RBF2 with SOM (self-organizing map)

---
## Files running order
1. run the figure_preprocessing.m and create a new file folder ass2_processede_data
2. run data_partition.m split the dataset in 8:2 version and returned the X_train, X_test, y_train, y_test and save as train_test_data.mat
3. run ass2_CNN.m (this script did not use the processed data, but read the figure directly from the original file)
4. run ass2_mlp.m 
5. run ass2_lvq.m
6. run ass2_rbf_kmean.m
7. run ass2_rbf_som.m
8. run ass2_confusion_matrix_summary.m


---


## Components/Scripts inside the project

## The script part

### figure_preprocessing.m

This is the script to extract the ass2data and rewrite to a new file folder ass2_processed_data. 

	- normalize the data into range 0-1
	- assign the numerical labels to each character
	- combine all the processed plot into a dataset $$2400 \times 1152$$
	- 2400 stands for the number of samples; 1152 stands for the features in one figure

### data_partition.m

This is the script splitted the processed data into training and testing dataset in 8:2 ratio. It adjusted the size and columns or rows for fitting the designed model's network.

	- read images from the processed folder ass2_processed_data. 
	- split the dataset into 8:2
	- save the splitted samples and parameters as train_test_data.mat

### ass2_CNN.m

This is the script to conduct the CNN.

	- use imageDataset to store and train the model
	- use splitEachLabel to split the training and testing datasets
	- do not use the train_test_data as the input since CNN has standard samples in Matlab documents
	- calculate the training and testing accuracy
	- return and save the confusion matrix as C_CNN.mat

### ass2_mlp.m

This is the script to conduct the MLP

	- load the dataset obtained previously train_test_data.mat
	- lr_rate = 0.2;
	- momentum = 0.4;
	- epochs = 1000;
	- 3 layers with 50, 100, 100 
	- Hyperbolic tangent sigmoid transfer function (tansig)
	- gradient descent to update the weights
	- calculate the training and testing accuracy
	- return and save the confusion matrix as C_mlp.mat

### ass2_lvq.m

	- load the dataset obtained previously train_test_data.mat
	- set the cluster into 360 due to its performance, you could also set cluster into 24 for computational convenience
	- lvqnet(24) could achieve ideal performance, but the performance could not be comparable with the cluster set into 360
	- save the lvqnet(360) as lvq_360.mat, uncomment the line if you wish to see the performance
	- calculate the training and testing accuracy
	- return and save the confusion matrix C_lvq.mat


### ass2_rbf_kmean.m
	
	- load the dataset obtained previously train_test_data.mat
	- use kmeans to return the center of each cluster, the number of cluster is determined as 360
	- use assembled function RBF_training_kmeans to calculate the W (weights), sigma (the variance of the RBF kernel) and the coordinate of each cluster's center 
	- use the previous returned parameter to return the training prediction by assembled function: RBF_predict
	- calculate the training and testing accuracy
	- return and save the confusion matrix C_rbf_kmeans.mat

### ass2_rbf_som.m
	
	- load the dataset obtained previously train_test_data.mat
	- define the SOM network, the dimension is set to 18 $$ \times $$ 20 for convenience, keep it uniform to the previous number of clusters: 360
	- coverSteps = 10
	- initNeighbor = 80 
	- topologyFcn = 'hextop' 
	- distanceFcn = 'dist'
	- once finished the training of SOM network, use assembled function RBF_training_som.m to calculate the weights W, sigma (the variance of the RBF kernel) and center of SOM clusters, which is the IW{1,1}.
	- use the previous returned parameter to return the training prediction by assembled function: RBF_predict
	- return and save the confusion matrix C_rbf_som.mat

### ass2_confusion_matrix_summary.m

	- load the previous saved mat file
	- reshow the confusion matrix
	- compare the performance returned by different neural networks
	- compare the accuracy returned by different neural networks  

---

## The function part (assembled function for reproduction)

### getimdata.m

	- Input: the file path, in this case the processed file with renamed figure and same format jpeg (ass2_processed_data) 
	- Output: Transormed the numerical data into the one-hot encoding vector format

### getimdata2.m

	- Input: the file path, in this case the processed file with renamed figure and same format jpeg (ass2_processed_data) 
	- Output: The normalized figure data (0-1), with data and corresponding labels. Labels are in numerical format (1,2,3...24)

### RBF_training_kmeans.m

	- Input: data, labels, number of clusters to be determined by kmeans
	- sigma ($$ \sigma $$) is determined by the longest Euclidean distance between two clusters
	- k weight matrix is calculated by the radbas(distance of samples between clusters' centers/2*sigma^2)
	- W weights is calculated by the pesudo inverse of (k'*k)*k'*labels


### RBF_training_som.m

	- Input: data, labels and net
	- net is pre-trained by som networks
	- the cluster center is returned by the first layer of som network, which is denoted by net.IW{1,1}
	- sigma ($$ \sigma $$) is determined by the longest Euclidean distance between two clusters
	- k weight matrix is calculated by the radbas(distance of samples between clusters' centers/2*sigma^2)
	- W weights is calculated by the pesudo inverse of (k'*k)*k'*labels

### RBF_predict.m

	- Input: data, W, sigma, C trained previously from either RBF_training_kmeans or RBF_training_som
	- Output: vectors of the final prediction
	- data could be either training data or testing data

### getcls.m 

	- Input: vecs - matrix of column vectors (returned from the RBF_predict.m)
	- Output: cls - matrix where the largest element in each column in vectors is set to 1 and the rest to 0   Ex: vecs = [2 4; 1 5], gives c = [1 0; 0 1]
	- This function is used to return the most likely label in multi-variable classification, especially after the one-hot encoding method

### rate.m 

	- Input: matrix of class vectors
	- Computes the percentage of equal columns in t1 and t2, can be used to compute the rate of correct classified patterns in a pattern recognition application
	- Output: number of matching vectors

---
## Saved parameters

### train_test_data.mat
	
	- the value obtained from the data_partition.m
	- X_train, X_test, y_train, y_value

### som_net_data.mat 

	- the network trained by som (it takes long time, for computation convenience)

### lvq_360.mat
	- lvq with cluster set to 360

### lvq_24.mat

	- lvq with cluster set to 24 

### kmeans_plot.mat
	
	- calculate silhouette value to find the suitable cluster k, but the results are not satisfied
	- return the plot of each epoch

### Confusion_matrix summary:
	- CNN_confusion.mat
	- C_rbf_som.mat
	- C_rbf_kmeans.mat
	- C_mlp.mat
	- C_lvq.mat
	- C_CNN.mat





