# Use Nginx base image
FROM nginx:alpine

# Copy the HTML file into the Nginx server directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow outside access to your web application
EXPOSE 80

