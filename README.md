# dsci-532_individual_TempTales_R

## Overview

**TempTales** is an interactive dashboard that allows users to explore global and country-level temperature trends over time. Users can select a country, view seasonal and monthly temperature patterns. This tool consolidates climate data from over two centuries into a user-friendly interface for researchers, students, policy makers, and environmentally conscious individuals.

Deployed Dashboard <https://019cedc6-a865-4373-9ce5-85e0944748dd.share.connect.posit.cloud/>

NOTE: This repository was based on a python-based application. ChatGPT5 was used to help convert individual functions, but the compilation, structure, and functionality was done manually.

### Usage (Makefile Guide)

This project uses `make` to automate common tasks. Below is a guide to the available commands:

### Project Setup

``` bash
# Clone the repository
$ git clone git@github.com:iangault/dsci-532_individual_TempTales_R.git

# Navigate to the project directory
$ cd dsci-532_individual_TempTales_R

# Install the packages using Makefile
$ make install
```

#### Initialization

Before running the app for the first time, you can process the data:

``` bash
$ make data
```

This command runs `src/data_processor.R` to re process the data from a .csv

#### Running the App

To start the **Shiny** app in development mode:

``` bash
$ make run
```

#### Additional Functions

Create manifest.json for Posit Connect Cloud

``` bash
$ make manifest
```

Remove the processed data in data/

``` bash
$ make clean
```
