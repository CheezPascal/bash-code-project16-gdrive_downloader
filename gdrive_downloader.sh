#!/bin/bash

# Script to download files from Google Drive and optionally unzip them.

# Instructions
echo "This application downloads files from Google Drive."
echo "Please provide the file ID."
echo "Hint: The file ID is the string after 'https://drive.google.com/file/d/' in the file link."
read -p "File ID: " file_id

echo "Please provide the file name (e.g., file.zip)."
read -p "File Name: " file_name

# Download the file
echo "Downloading the file..."
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=${file_id}" -O "${file_name}"

# Check if the download succeeded
if [ $? -eq 0 ]; then
  echo "File downloaded successfully as ${file_name}."
else
  echo "Download failed. Please check the file ID and try again."
  exit 1
fi

# Prompt to unzip the file
read -p "Do you want to unzip the file? (y/n): " unzip_choice

if [[ "$unzip_choice" == "y" || "$unzip_choice" == "Y" ]]; then
  # Check if the file is a zip file
  if [[ "$file_name" == *.zip ]]; then
    echo "Unzipping the file..."
    unzip "$file_name"
    
    # Check if the unzip was successful
    if [ $? -eq 0 ]; then
      echo "File unzipped successfully."
    else
      echo "Failed to unzip the file. Please ensure 'unzip' is installed and the file is a valid zip archive."
    fi
  else
    echo "The file is not a zip file. Skipping unzip."
  fi
else
  echo "Skipping unzip operation."
fi

echo "Operation completed."
