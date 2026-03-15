# Day 21: Set Up Git Repository on Storage Server

## The Nautilus development team has provided requirements to the DevOps team for a new application development project, specifically requesting the establishment of a Git repository. Follow the instructions below to create the Git repository on the Storage server in the Stratos DC:

Utilize yum to install the git package on the Storage Server.

Create a bare repository named /opt/demo.git (ensure exact name usage).

1️⃣ Install Git using yum

SSH into the Storage Server and run:

`sudo yum install git -y`

Verify installation:

`git --version`

2️⃣ Create the bare Git repository

Run the following command to create the repository exactly at /opt/demo.git:

`sudo git init --bare /opt/demo.git`

3️⃣ Verify the repository

Check that the repository exists:

`ls -ld /opt/demo.git`

You should see directories like:

HEAD
branches
config
description
hooks
info
objects
refs

✅ Summary

Commands used:

`sudo yum install git -y`
`sudo git init --bare /opt/demo.git`

