# Day 47: Docker Python App

## 🎯 task
A python app needed to be Dockerized, and then it needs to be deployed on App Server 1. We have already copied a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 1. Further complete this task as per details mentioned below:

Create a Dockerfile under /python_app directory:

Use any python image as the base image.
Install the dependencies using requirements.txt file.
Expose the port 5002.
Run the server.py script using CMD.

1. Build an image named nautilus/python-app using this Dockerfile.


2. Once image is built, create a container named pythonapp_nautilus:

3. Map port 5002 of the container to the host port 8095.

4. Once deployed, you can test the app using curl command on App Server 1.

## Solution
1. Create a Dockerfile under /python_app directory with the following content:

```Dockerfile
FROM python:3.8-slim
WORKDIR /app
COPY ./src /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5002
CMD ["python", "server.py"]
```

## 2. Build the Docker image & run container using the following command:

```bash
docker build -t nautilus/python-app .
docker run -d --name pythonapp_nautilus -p 8095:5002 nautilus/python-app
```

