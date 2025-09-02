# Stage 1: Build the application (install dependencies)
FROM node:20-alpine AS builder
 
WORKDIR /app
 
# Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./
RUN npm install --omit=dev
 
# Stage 2: Create the final production image
FROM node:20-alpine
 
WORKDIR /app
 
# Copy only necessary files from the builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY server.js ./
COPY server ./server
    
# Expose the port the application listens on
EXPOSE 3000
    
# Command to run the application
CMD ["node", "server.js"]