# Use the official Ubuntu base image
FROM ubuntu:latest

# Update the package list and install Python 3
RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get clean

# Set the default command to python3
CMD ["python3"]
