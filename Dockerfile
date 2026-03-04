# Use a lightweight nginx base image
FROM nginx:alpine

# Copy the static HTML file into the default nginx html directory
# This keeps the image small and only adds the necessary file
COPY index.html /usr/share/nginx/html/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Use nginx' default command, which is already optimized for production
# No additional CMD or ENTRYPOINT needed since the base image defines one.
