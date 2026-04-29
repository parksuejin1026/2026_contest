import pandas as pd
import os

def preprocess_csv(input_file, output_file):
    # Load the CSV file
    df = pd.read_csv(input_file)

    # Example preprocessing steps
    # 1. Drop rows with missing values
    df.dropna(inplace=True)

    # 2. Rename columns for consistency
    df.rename(columns={
        'OldColumnName1': 'NewColumnName1',
        'OldColumnName2': 'NewColumnName2'
    }, inplace=True)

    # 3. Convert data types if necessary
    df['SomeColumn'] = df['SomeColumn'].astype(float)

    # Save the cleaned DataFrame to a new CSV file
    df.to_csv(output_file, index=False)

if __name__ == "__main__":
    # Define input and output file paths
    input_directory = os.path.join(os.path.dirname(__file__), '../../data/csv/')
    output_directory = os.path.join(os.path.dirname(__file__), '../../data/csv/processed/')

    # Ensure output directory exists
    os.makedirs(output_directory, exist_ok=True)

    # List of CSV files to preprocess
    csv_files = [
        'industry_education_age_gender.csv',
        'job_experience_trend.csv',
        'region_weights.csv'
    ]

    # Process each CSV file
    for csv_file in csv_files:
        input_file_path = os.path.join(input_directory, csv_file)
        output_file_path = os.path.join(output_directory, f'processed_{csv_file}')
        preprocess_csv(input_file_path, output_file_path)