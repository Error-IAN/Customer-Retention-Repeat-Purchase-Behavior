from google.colab import drive
from google.cloud import bigquery
from google.oauth2 import service_account
import os
from google.colab import auth
auth.authenticate_user()


# 📌 Step 2: Mount Google Drive
drive.mount('/content/drive')

# Initialize BigQuery client
client = bigquery.Client(project="sentiment-analysis-461919") 

# Create dataset config
dataset_id = "retail_transaction"
dataset_ref = bigquery.Dataset(f"{client.project}.{dataset_id}")
dataset_ref.location = "US"  

# Create dataset
dataset = client.create_dataset(dataset_ref, exists_ok=True)
print(f"Dataset '{dataset_id}' created")

project_id = "sentiment-analysis-461919" 
client = bigquery.Client(project=project_id)
file_path = "/content/drive/MyDrive/Retail_Transactions_Dataset.csv"  
dataset_id = "retail_transaction" 
table_id = "chohort_analysis"  
full_table_id = f"{project_id}.{dataset_id}.{table_id}"

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,
    skip_leading_rows=1,
    autodetect=True,
)

with open(file_path, "rb") as source_file:
    load_job = client.load_table_from_file(source_file, full_table_id, job_config=job_config)

load_job.result() 

print(f"Upload complete")
