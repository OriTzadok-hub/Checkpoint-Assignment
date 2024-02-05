import requests
import boto3
import os
import json

# Constants defining the URL for the JSON data, the filename for filtered products,
# and environment variables for AWS S3 bucket name and CloudFront domain.
JSON_URL = 'https://dummyjson.com/products'
FILE_NAME = 'filtered_products.json'
S3_BUCKET_NAME = os.environ.get('BUCKET_NAME', 'default-bucket-name')
CLOUDFRONT_DOMAIN = os.environ.get('CLOUDFRONT_DOMAIN', 'default-cloudfront-domain')

"""
Script Overview:
This script automates the process of downloading a JSON file from a specified URL,
filtering the data based on certain criteria (e.g., product price), saving the filtered data
to a new JSON file, uploading this file to an AWS S3 bucket, and finally accessing
the file through a CloudFront distribution.

Steps:
A. Download JSON data from a given URL.
B. Filter the JSON data based on a specified condition.
C. Upload the filtered JSON data to an S3 bucket.
D. Attempt to download the uploaded file via CloudFront and print the data.
"""

# Download JSON data from the specified URL.
response = requests.get(JSON_URL)
data = response.json()

# Parse the JSON data and filter products based on the specified condition.
# Here, we're filtering for products with a price of $100 or more.
filtered_products = [product for product in data['products'] if product['price'] >= 100]

# Save the filtered list of products to a new JSON file.
with open(FILE_NAME, 'w') as file:
    json.dump(filtered_products, file)

# Upload the filtered JSON file to the specified S3 bucket.
s3_client = boto3.client('s3')
s3_client.upload_file(FILE_NAME, S3_BUCKET_NAME, FILE_NAME)

# Download the JSON file via CloudFront using the constructed URL.
# This demonstrates accessing the uploaded content via CloudFront, potentially for public access.
cloudfront_url = f'https://{CLOUDFRONT_DOMAIN}/{FILE_NAME}'
response = requests.get(cloudfront_url)

if response.ok:
    # If the file is successfully downloaded via CloudFront, print the filtered data.
    print(json.dumps(filtered_products, indent=4))
else:
    # If there's an issue accessing the file via CloudFront, indicate failure.
    print("Failed to download JSON via CloudFront.")
