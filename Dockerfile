# Use a modern, minimal Alpine Python base image
FROM python:3.11-alpine3.19

# Create a non-root user and group for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory
WORKDIR /usr/src/app

# Copy dependency requirements
COPY requirements.txt .

# Install dependencies without caching to keep the image minimal
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY app/ app/

# Change ownership of the application files to the non-root user
RUN chown -R appuser:appgroup /usr/src/app

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 8080

# Define the command to run the application
CMD ["python", "app/main.py"]