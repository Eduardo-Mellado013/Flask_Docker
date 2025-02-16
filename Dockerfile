FROM ubuntu:18.04

# Use LABEL instead of deprecated MAINTAINER
LABEL maintainer="Your Name <youremail@domain.tld>"

# Update and install Python 3 (3.6+), pip3, and development headers
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip python3-dev && \
    pip3 install --upgrade pip setuptools

# Copy only requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

# Set working directory
WORKDIR /app

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Copy the rest of your application code
COPY . /app

# Use python3 to run the application
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]

