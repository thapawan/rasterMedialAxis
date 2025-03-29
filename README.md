## Modified Medial Axis Transform for River Centerline Extraction and Water-surface Width Estimation (MMAT)

<hr style="border: 1px solid black; margin: 0;">

[![Version](about:sanitized)](https://www.google.com/search?q=https://www.google.com/search%3Fq%3Dhttps://github.com/yourusername/MMAT/releases)
[![Issues](about:sanitized)](https://www.google.com/search?q=https://www.google.com/search%3Fq%3Dhttps://github.com/yourusername/MMAT/issues)
[![License: MIT](about:sanitized)](https://opensource.org/licenses/MIT)
[![Hits](about:sanitized)](https://hits.seeyoufarm.com)
[![CRAN Status](about:sanitized)](https://www.google.com/search?q=https://cran.r-project.org/package%3DMMAT)

| | |
| --- | --- |
| <a href="[https://yourwebsite.com](https://thapawan.github.io/)"><img src="([https://github.com/thapawan/raster_medial_axis/blob/main/Logo/channels4_profile.jpg](https://github.com/thapawan/raster_medial_axis/blob/main/Logo/channels4_profile.jpg))" alt="Your Logo" width="300"></a> | This repository provides an R package and source code for the automatic extraction of river centerlines and estimation of water-surface widths from raster imagery. It is developed by [Pawan Thapa/University of Alabama], [Department of Geography and the Environment], United States. |

### **Background**

<hr style="border: 1px solid black; margin: 0;">

Accurate river centerline extraction and water-surface width estimation are crucial for hydrological modeling, river morphology studies, and environmental monitoring. Traditional methods can be time-consuming and require manual intervention, especially when dealing with large datasets or complex river geometries.

To address these challenges, we developed the Modified Medial Axis Transform for River Centerline Extraction and Water-surface Width Estimation (MMAT). This R package automates the process of extracting river centerlines and estimating water-surface widths from raster images, leveraging a modified medial axis transform approach. It provides robust and efficient tools for processing various types of river imagery.

### **Repository Structure**

<hr style="border: 1px solid black; margin: 0;">

The architecture of `MMAT` integrates key functions for image processing, medial axis transformation, and width estimation. All function codes are in the `R` folder.

```bash
MMAT/
├── R/
│   └── centerline_extraction.R
│   └── width_estimation.R
├── man/
│   └── centerline_extraction.Rd
│   └── width_estimation.Rd
├── data/
│   └── example_raster.tif # example raster data
├── inst/
│   └── doc/
│       └── MMAT_usage.Rmd
├── DESCRIPTION
├── NAMESPACE
├── README.md
└── LICENSE
```

The workflow of the `MMAT` package can be summarized as follows:

1.  **Read Raster Image:** Load the raster data.
2.  **Extract Centerline:** Use the `centerline_extraction()` function to extract the river centerline.
3.  **Estimate Width:** Use the `width_estimation()` function to estimate water-surface widths.
4.  **Output:** Obtain results as spatial data frames or data frames.

### **Package Installation and Usage**

<hr style="border: 1px solid black; margin: 0;">

This package can be installed from CRAN or directly from GitHub.

**From CRAN:**

```r
# Install from CRAN
install.packages("MMAT")

# Load the package
library(MMAT)
```

**From GitHub:**

```r
# Install from GitHub
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("yourusername/MMAT")

# Load the package
library(MMAT)
```

**Note: Detailed usage instructions and examples are provided in the package documentation and vignettes (accessible with `vignette("MMAT_usage")`).**

#### **Data Input**

The primary input is a raster image, which should represent the river area. The package also requires the spatial resolution of the raster.

#### **Executing the MMAT Functions**

The `MMAT` package provides functions for centerline extraction and width estimation.

```r
# Example usage:
raster_path <- system.file("data", "example_raster.tif", package = "MMAT") # sample raster.
centerline_gdf <- centerline_extraction(raster_path, spatial_resolution = 10) # 10 is spatial resolution
width_df <- width_estimation(raster_path, centerline_gdf)
```

### **Functions in MMAT**

| Function Name | Objective | Arguments | Outputs |
|---------------|-----------|-----------|---------|
| `centerline_extraction()` | Extracts the river centerline from a raster image. | `raster_path`: Path to the raster image, `spatial_resolution`: Spatial resolution of the raster. | SpatialLinesDataFrame containing the centerline geometry. |
| `width_estimation()` | Estimates the water-surface width along the extracted centerline. | `raster_path`: Path to the raster image, `centerline_gdf`: SpatialLinesDataFrame containing the centerline. | data.frame containing width estimates along the centerline. |

### **Acknowledgements**

| | |
| --- | --- |
| \! | [Add any acknowledgements here] |

### **For More Information**

Contact [Pawan Thapa/[Contact Information](https://geography.ua.edu/graduate-student/thapa-pawan/)] for more details.

