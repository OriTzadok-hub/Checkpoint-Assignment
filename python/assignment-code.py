import requests
import boto3
import json

# Constants
JSON_URL = 'https://dummyjson.com/products'
S3_BUCKET_NAME = 'ori-assignment-bucket'
FILE_NAME = 'filtered_products.json'
CLOUDFRONT_DOMAIN = 'dvqlynkg72hxr.cloudfront.net'

# A. Download JSON
response = requests.get(JSON_URL)
data = response.json()

# B. Parse JSON and filter products
filtered_products = [product for product in data['products'] if product['price'] >= 100]

# Save to new JSON file
with open(FILE_NAME, 'w') as file:
    json.dump(filtered_products, file)

# C. Upload to S3
s3_client = boto3.client('s3')
s3_client.upload_file(FILE_NAME, S3_BUCKET_NAME, FILE_NAME)

# D. Download the JSON file via CloudFront
cloudfront_url = f'https://{CLOUDFRONT_DOMAIN}/{FILE_NAME}'
response = requests.get(cloudfront_url)

if response.ok:
    # Print the entire filtered JSON data
    print(json.dumps(filtered_products, indent=4))
else:
    print("Failed to download JSON via CloudFront.")
