# Prediction System for Soil Water Pressure Head

This repository contains two Python scripts developed as part of my master's thesis, titled **"Prediction System for Soil Water Pressure Head"**, in the Environmental Modeling program at [Czech University of Life Sciences Prague (CZU)](https://www.fzp.czu.cz/en/r-9408-study/r-9495-study-programmes/r-9745-master-s-degree-programmes/r-9753-environmental-modelling). This work was a component of the [AgriClima Project (Phase 2)](https://www.fzp.czu.cz/en/r-9411-projects-and-partnerships/r-9880-projects/r-14937-agriclima-adding-value-through-piloting-of-the-eu-celac-climate-services-market-in-agriculture), aimed at enhancing climate services in agriculture.

Part of this research was presented at EGU 2021 as an abstract, which can be accessed [here](https://meetingorganizer.copernicus.org/EGU21/EGU21-9972.html).

## Project Overview

The project automates data processing for environmental modeling, specifically in predicting soil water pressure head. My methodology involved two main scripts:

1. **Input Generation Tool**: Automates meteorological data processing, retrieving weather data and calculating necessary variables for model input.
2. **Observations Automation Tool**: Interfaces with an API to retrieve in-situ soil sensor data, processes it, and structures it for model use.

The process flowcharts for these tools are illustrated below:

[![Figure 3.1: Flowchart for Observations Automation Tool](https://i.postimg.cc/k4CjV4gr/Screenshot-2024-11-05-143132.png)](https://postimg.cc/mcd3JT9V)
  
[![Figure 3.2: Flowchart for Input Generation Tool](https://i.postimg.cc/bJS5nMQb/Screenshot-2024-11-05-143143.png)](https://postimg.cc/0MxZRVX2)



## Scripts

### 1. Input Generation Tool

- **Purpose**: Fetches, cleans, and combines meteorological data, such as temperature, humidity, and wind speed, from multiple days into a single file for evaporation modeling.
- **Main Functions**:
  - `find_string()`: Finds relevant data entries in files.
  - `clean_up()`: Cleans up and structures data for output.
  - `csv_generate()`: Generates a daily CSV file for meteorological data.
  - `combine()`: Combines data from multiple days into a single output file.
- **User Input**: Start date (YYYYMMDD) and number of days to process.
- **Output**: `meteo_data.out` file containing combined meteorological records.

### 2. Observations Automation Tool

- **Purpose**: Retrieves JSON data from in-situ soil sensors and processes it to calculate soil water potential and pressure head. Outputs data in CSV format for further modeling.
- **Main Functions**:
  - Fetches data via API and cleans JSON data for structured output.
  - Calculates soil water potential and pressure head from sensor values.
  - `csv_writer`: Writes cleaned data to CSV format.
- **Output**: `observations.out` file containing structured sensor data for model input.

### 3. Ebalance

- **Purpose**: This script generates the `ebalance.in` file, calculating solar radiation and preparing meteorological data for energy balance modeling.

- **Main Functions**:

1. **Leap Year Check**: `is_leap(year)` determines if the given year is a leap year.
2. **Solar Radiation Calculation**: `solar_rad(day, mon, year, lat, t)` computes the solar radiation at a given latitude and time of day.

- **Output**:
   Solar radiation is calculated, allowing the script to estimate energy balance inputs.
  

## Methodology Summary

The core methodology used in the project includes:

- **Estimation of Solar Radiation**: Uses the Angstrom formula to estimate solar shortwave radiation in the absence of direct measurements. Key variables include solar elevation angle, extraterrestrial radiation, and solar declination.
- **Tools for Input Automation**: 
  - **Observations Automation Tool**: Retrieves and processes in-situ soil data for soil water potential and pressure head calculations.
  - **Input Generation Tool**: Automates the retrieval and calculation of meteorological inputs, consolidating multiple daily records for seamless model integration.
- **Case Study Site**: Conducted in a vineyard in San Juan, Argentina, with detailed soil profile and climate data. The simulation setup included water and heat transport models, informed by site-specific parameters.

For more information on the code and methodology, see my supervisor [Michal Kuraz]'s [GitHub repository](https://github.com/michalkuraz) for additional resources.

## Installation and Usage

1. **Clone this repository**:
    ```bash
    git clone https://github.com/username/Prediction-System-for-Soil-Water-Pressure-Head.git
    ```

2. **Run the Input Generation Tool**:
    - This script is designed to prompt the user for the start date and number of days of meteorological data.
    - The output will be saved as `meteo_data.out` in the specified output directory.

3. **Run the Observations Automation Tool**:
    - This script automatically fetches and processes in-situ sensor data for soil measurements.
    - The output will be saved as `observations.out` in the specified output directory.
  
4. **Run the `Ebalance` script**:
   - This script reads meteorological data, calculates solar radiation based on location and time, and writes the data into a formatted `.in` file for use in energy balance models.
   - Run the following command:

    ```bash
    python Ebalance.py
    ```






---
## Contact

- **Author**: Arij Chmeis  
- **Email**: arij.chmeis@gmail.com  


