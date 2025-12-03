# STEP 1: Define the base image (Python environment)
# We use a slim version for smaller image size.
FROM python:3.11-slim

# STEP 2: Set environment variables
# Prevents Python from writing .pyc files (saves space)
ENV PYTHONDONTWRITEBYTECODE 1
# Forces output directly to the terminal (good for Airflow logs)
ENV PYTHONUNBUFFERED 1

# STEP 3: Set the working directory inside the container
# All subsequent commands will run from here
WORKDIR /app

# STEP 4: Copy dependency file and install libraries
# Copy requirements.txt first to leverage Docker's build cache
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# STEP 5: Copy the rest of the project files
# Copy the entire src folder and the app.py file
COPY src/ src/
COPY app.py app.py

# STEP 6: Define the entry command (what to run by default)
# When the container starts, it will run the ETL pipeline once
CMD ["streamlit", "run", "app.py"]