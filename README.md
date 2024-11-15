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


   
## Getting Started

1. Open MATLAB and navigate to the cloned folder.
2. Run the main script to execute the feature extraction and classification.

## Usage

1. Ensure that the image and label directories are correctly set in the code.
2. Run the script in MATLAB to:
   - Extract features from the skin lesion images.
   - Save the features and labels in `features.mat` and `labels.mat`.
   - Train a neural network and calculate its performance on the dataset.

## Code Explanation

### Image Preprocessing
- Converts dermoscopic images to grayscale.
- Masks the lesion area using binary masks.

### Feature Extraction
1. **Wavelet Decomposition**:
   - Extracts mean and standard deviation for horizontal (`H`), vertical (`V`), and diagonal (`D`) components.
2. **GLCM and Texture Features**:
   - Calculates texture properties for masked lesion regions, including:
     - Contrast
     - Correlation
     - Energy
     - Homogeneity
3. **Geometric and Color Features**:
   - Calculates the following features:
     - **Asymmetry**: Difference between left and right halves of the lesion.
     - **Border Complexity**: Based on the lesion perimeter.
     - **Color Variance**: Standard deviation of pixel intensities.
     - **Diameter**: Maximum distance within the lesion boundary.
     - **Region Properties**: Area, Perimeter, Eccentricity, and Circularity.

### Classification
- A neural network with 20 hidden neurons is trained to classify lesions based on extracted features.
- The dataset is divided as follows:
  - **Training**: 80%
  - **Validation**: 10%
  - **Testing**: 10%

### Class Mean Calculation
- Computes and displays mean feature values for each class in the dataset.
- Displays results in a tabular format for easy comparison.
