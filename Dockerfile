# Use official lightweight Python image
FROM python:3.9-slim

# Set working directory inside container
WORKDIR /app

# Copy requirement file
COPY app/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY app/ /app

# Expose the Flask port
EXPOSE 8085

# Run the Flask app with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8085", "wsgi:app"]
