# dsci-532_individual_TempTales_R

## Overview

**TempTales** is an interactive dashboard that allows users to explore global and country-level temperature trends over time while connecting these trends to major historical events. Users can select a country, view seasonal and monthly temperature patterns, and see how significant events like industrialization or world wars align with temperature changes. A world heatmap provides a spatial view of temperatures for selected years, making regional patterns immediately clear. This tool consolidates climate data from over two centuries into a user-friendly interface for researchers, students, policy makers, and environmentally conscious individuals.

Deployed Dashboard URL

## For Users

**TempTales** is an interactive dashboard that allows users to explore global and country-level temperature trends over time while connecting these trends to major historical events. Users can select a country, view seasonal and monthly temperature patterns, and see how significant events like industrialization or world wars align with temperature changes. A world heatmap provides a spatial view of temperatures for selected years, making regional patterns immediately clear. This tool consolidates climate data from over two centuries into a user-friendly interface for researchers, students, policy makers, and environmentally conscious individuals.

### Installation

This project uses `conda` for dependency management. Ensure you have Anaconda or Miniconda installed.

``` bash
# Clone the repository
$ git clone https://github.com/UBC-MDS/DSCI-532_2026_26_TempTales.git

# Navigate to the project directory
$ cd DSCI-532_2026_26_TempTales

# Create the environment using Makefile
$ make install
```

### Configure GitHub API Key

Some features of the dashboard (like the AI Assistant or QueryChat) require access to GitHub’s API. To set it up:

1.  Sign up at <https://github.com/marketplace/models> to get an API key.
2.  In your project root, create a .env file if it doesn’t exist.
3.  Add your GitHub API key to .env:

``` bash
GITHUB_API_KEY=your_github_api_key_here
```

### Usage (Makefile Guide)

This project uses `make` to automate common tasks. Below is a guide to the available commands:

#### Initialization

Before running the app for the first time, you must download and process the data:

``` bash
$ make db
```

This command runs `src/data_loader.py` to download the data and `src/data_processor.py` to convert it into the required format.

#### Running the App

To start the **Shiny** app in development mode:

``` bash
$ make run
```
