Assessment2

## Project overview 

This task includes five algorithms to classify the characters segmented from the license plates of automobiles using MATLAB
- MLP (multi-layer perceptron)
- CNN (convolutional neural network)
- LVQ (learning vector quantization)
- RBF1 with k-means clustering
- RBF2 with SOM (self-organizing map)

---
## File running order
1. run the figure_preprocessing.m and create a new file folder ass2_processede_data


---


## Components/Scripts inside the project

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
	- return and save the confusion matrix as C_CNN.mat
