# Uber_data_analytics

## Introduction
The goal of this project is to perform data analytics on Uber data using various tools and technologies, including GCP Storage, Python, Compute Instance, Mage Data Pipeline Tool, BigQuery, and Looker Studio.

## Architecture

![Architecture](https://github.com/akhandchauhan/Uber_data_analytics/assets/112802105/2c072400-4f59-47bd-aeb0-ea3a629e9524)

## Services Used
![Services Used](https://github.com/akhandchauhan/Uber_data_analytics/assets/112802105/27bb4139-d963-41cd-b6b0-5d25fd770026)
![Mage](https://github.com/akhandchauhan/Uber_data_analytics/assets/112802105/19940c05-6fed-40cb-9121-55a8963efcf4)

## Dataset 
The dataset used in this project is TLC Trip Record Data. It includes fields capturing pick-up and drop-off dates/times, pick-up and drop-off locations, trip distances, itemized fares, rate types, payment types, and driver-reported passenger counts.
The dataset used for the analysis can be found here: [uber_data.csv](./uber_data.csv)
## Usage

To use the data in your analysis, you can download the CSV file and load it into your preferred data analysis tool or programming language. Here's an example in Python:

```python
import pandas as pd

# Load the dataset
df = pd.read_csv('path/to/uber_data.csv')

# Display the first few rows
print(df.head())
```
## Model Diagram using Lucid Chart
![Uber_data_model](https://github.com/akhandchauhan/Uber_data_analytics/assets/112802105/29f6962c-0b67-403d-8257-4702546f14d5)

## Creating Your Account

If you don’t have your own Google Cloud Platform (GCP) account, you can create a free tier account which provides you with some basic services to get started on GCP. If you need help creating the free tier account.

## Loading Data into Google Cloud Storage

If you have any basic idea about cloud services, you should know that for most cloud-based storage, we start with creating buckets. We similarly have to create a bucket for getting started on the project.

1. **Create a Bucket:**
    - Type in ‘Google Cloud Storage’ and get started with creating buckets.
    - When you create the bucket, ensure that it's public so that we can access it using a URL. However, this is not the safest way to build that while working on a production-grade project.
      ![image](https://github.com/akhandchauhan/Uber_data_engineering/assets/112802105/b3c83a83-c683-4be1-bda2-c481e11b593f)


2. **Grant Public Access to the Bucket:**
    - Once the bucket is created, upload the NYC file data into the bucket and ensure to change the permissions to make it public and accessible via URL.
    - If you get stuck with any error, refer to the ‘Google Cloud and Mage Installation’ part of the video.

## GCP Compute Engine and Install Mage

Since our project requires Mage to run, we shall be installing that in our VM built using GCP’s Compute Engine.

1. **Create the VM:**
    - Ensure that the HTTP has full default access and choose a standard machine type with 4 CPU and 16 GB memory.
    - Once the instance is created, click on ‘SSH’ to open your instance where you can start with your commands.
      ![image](https://github.com/akhandchauhan/Uber_data_engineering/assets/112802105/4543dde5-189d-40cf-a323-0758480f2fdd)


## Run Mage on Compute Engine

Once the installation is successful, run Mage using the command `mage start <project_name>`. If everything is successful, you can see Mage running on port 6789. 

1. **Access Mage from Web UI:**
    - You would need the external IP of your VM (which you can get by clicking on your VM in GCP). 
    - Try typing in your external IP and the port to access Mage, e.g., `35.127.11.11:6789`.
    - If you can’t access it, it's because we didn’t explicitly tell the VM to accept requests from port 6789. To remedy this, go to ‘Firewall’ in GCP and click on ‘create firewall rule’.

2. **Create Firewall Rule:**
    - In the new rule, give details and give the IP as `0.0.0.0/0` and mention the port.
    - Create the rule to help in opening the Mage UI.
      ![image](https://github.com/akhandchauhan/Uber_data_engineering/assets/112802105/ebd40783-74c9-49dd-ab96-a546d7244d45)


## Create Files on Mage for ETL/Transformation

Mage is similar to other orchestration tools like Airflow, with one big difference: Mage provides a lot of templates for loading and transforming data.

1. **Mage UI:**
    - In the API section, you can add the public URL from which the data was downloadable from Google Cloud Storage.
    - Run the code using the run icon on top of the data loader file. The output should yield the CSV NYC data file.

2. **Create a Data Transformation File:**
    - In this file, import pandas and write the code used in Jupyter notebooks.
    - The data outputted from the data loader file goes into the data transformation file.
    - The transform files convert data into dataframes of different fact and dimension tables. The dataframes are converted into dictionaries passed to the next function.
      ![image](https://github.com/akhandchauhan/Uber_data_engineering/assets/112802105/e3685e4d-f259-45cb-90e6-2b699985f569)


3. **Write Output Data into BigQuery:**
    - Create a file with data exporter for exporting to BigQuery.
    - Include table details for BigQuery and an `io.yaml` file with details about the GCP (BigQuery) credentials.
    - To get the credentials, go to GCP console, type in ‘API & Services’, go to ‘create credentials’, and ‘create service account’.

4. **Create Service Account:**
    - Allow services in VM to interact with services in GCP.
    - Add a key to the created service account, create a JSON key, and download the file.
    - Copy and paste the credentials from the JSON file into the YAML file in Mage.

5. **Create a Dataset in BigQuery:**
    - Go to BigQuery, click on ‘create dataset’, and create a dataset with multi-region enabled.
    - In Mage’s transformer code, add the table details with the dataset name and the table name required (e.g., `fact_table`).

6. **Install Google Cloud Packages:**
    - If you get a Google Cloud error when running the transformer code, it could be due to a lack of Google Cloud packages in the VM.
    - Open another instance by clicking on the SSH button and install the Google Cloud packages using the commands shared in the link above.
    - Once the transformation file is run, it will load all tables into BigQuery.

## BigQuery Data Analysis

In the BigQuery console, you can see all the dimension and fact tables have been copied. Now you can start querying from the console.

1. **Create a Table for Analytics:**
    - To create some dashboards out of the dataset, create a separate table based on the query.
    - This query joins all the required datasets and extracts relevant metrics for the final dataset necessary to show on the dashboard.
      ![image](https://github.com/akhandchauhan/Uber_data_engineering/assets/112802105/e7c67a42-8058-4d25-a78b-8c6efb2fe538)

## Play with Dashboard!
https://lookerstudio.google.com/reporting/f327282a-ee3f-49f9-8e4f-76b6c2a5e301
