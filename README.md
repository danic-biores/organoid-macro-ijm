# organoid-macro-ijm
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19311956.svg)](https://doi.org/10.5281/zenodo.19311956)
An ImageJ/Fiji macro for semi-automated batch analysis of organoid growth and morphology.

## Description
This macro provides a structured workflow for the automated segmentation and quantification of organoids in growth assays. It is designed to process large datasets efficiently while maintaining high accuracy through an interactive thresholding step.

## Key Features
* **Batch Processing:** Automatically processes all images within a selected input directory.
* **Image Preprocessing:** Enhances image quality using Contrast Enhancement, Unsharp Mask, and Gaussian Blur to improve edge detection.
* **Semi-Automated Segmentation:** Includes a manual threshold adjustment step (`waitForUser`) to account for biological variability between samples.
* **Organized Output:** Automatically creates and populates subfolders for results (`RESULTS/`), quality control images (`JPEG/`), and selection files (`ROI/`).

## Measured Parameters
The macro focuses on key growth metrics for each image:
* **Count:** Total number of organoids detected.
* **Total Area:** The sum of the area of all detected organoids.
* **Average Size:** The mean area of the identified organoids.
* **%Area:** The percentage of the total image area covered by organoids.

## How to Use
1. Open **Fiji** (or ImageJ).
2. Drag and drop the `organoid-macro-ijm.ijm` file into the main window.
3. Click **Run**.
4. Select the **Input folder** (containing your raw images) and the **Output folder** when prompted.
5. For each image, adjust the threshold levels in the pop-up window to ensure it is as representative as possible of the original image (accurately capturing the organoid boundaries), then click **OK** to proceed.

## Developed by
* **Daniela Conticelli**
* **Marika Milan**
  
## License
Distributed under the MIT License. See `LICENSE` for more information.
