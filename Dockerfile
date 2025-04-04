# Use official Node.js runtime as a base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .

# Install application dependencies
RUN npm install

# Copy the application code into the container
COPY . .

# Expose the necessary port
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
