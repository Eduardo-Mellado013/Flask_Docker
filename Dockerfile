FROM ubuntu:latest

# Use LABEL instead of deprecated MAINTAINER
LABEL maintainer="Your Name <youremail@domain.tld>"

# Update package list and install Python 3, pip, development headers, CA certificates, and build dependencies
RUN apt-get update -y && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-dev \
        ca-certificates \
        build-essential \
        libssl-dev \
        libffi-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and setuptools using python3 -m pip with no-cache, ignore-installed, and break-system-packages options
RUN python3 -m pip install --no-cache-dir --ignore-installed --upgrade pip setuptools --break-system-packages

# Copy only requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

# Set working directory
WORKDIR /app

# Install Python dependencies from requirements.txt using the break-system-packages flag
RUN pip3 install --break-system-packages -r requirements.txt

# Copy the rest of your application code
COPY . /app

# Use python3 to run the application
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]

