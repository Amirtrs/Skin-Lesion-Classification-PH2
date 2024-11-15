# PH² Dataset Lesion Analysis and Feature Extraction

This project uses MATLAB to perform feature extraction and classification of skin lesions based on images from the PH² dataset. The project includes image preprocessing, feature extraction using wavelet decomposition, GLCM, and other image properties, and employs a neural network for classification.

## Project Details

- **Dataset**: The PH² dataset, which contains dermoscopic images of skin lesions along with their binary masks and labels.
- **Image Preprocessing**: Images are converted to grayscale, and lesion areas are isolated using binary masks.
- **Feature Extraction**:
  - Wavelet decomposition features (mean and standard deviation of horizontal, vertical, and diagonal components).
  - Texture features from GLCM (Contrast, Correlation, Energy, and Homogeneity).
  - Additional features include asymmetry, border complexity, color variance, diameter, area, perimeter, eccentricity, and circularity.
- **Classification**: A neural network with a single hidden layer is trained to classify skin lesions based on extracted features.

## Dataset

The PH² dataset contains:
1. **Images**: Original dermoscopic images and binary masks for segmented lesions.
2. **Labels**: The `PH² Dataset.xlsx` or `PH² Dataset.txt` file contains the classifications and dermoscopic criteria for each image in the dataset.

### Setting up the Dataset

1. Place the images in a folder, e.g., `C:\Users\Amir\Desktop\img`.
2. Place the lesion mask images in a separate folder, e.g., `C:\Users\Amir\Desktop\label`.
3. Ensure you have the `PH² Dataset.xlsx` file or `label.mat` file, which contains the labels and classifications for each image.

## Getting Started

### Prerequisites

- **MATLAB** with the **Image Processing Toolbox** and **Wavelet Toolbox**

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/Amirtrs/PH2-Lesion-Feature-Extraction.git
Open MATLAB and navigate to the cloned folder.
Run the main script to execute the feature extraction and classification.
Usage
Ensure that the image and label directories are correctly set in the code.
Run the script in MATLAB to:
Extract features from the skin lesion images.
Save the features and labels in features.mat and labels.mat.
Train a neural network and calculate its performance on the dataset.
Code Explanation
Image Preprocessing: Converts images to grayscale and masks the lesion area.
Feature Extraction:
Wavelet Decomposition: Extracts mean and standard deviation for horizontal, vertical, and diagonal components.
GLCM and Texture Features: Calculates texture properties for masked lesion regions.
Geometric and Color Features: Calculates asymmetry, border complexity, color variance, lesion diameter, area, perimeter, eccentricity, and circularity.
Classification:
A neural network with 20 hidden neurons is trained to classify the lesions based on extracted features.
The dataset is split into training (80%), validation (10%), and testing (10%).
Class Mean Calculation: Calculates and displays mean feature values for each class.
