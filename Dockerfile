# Start from the official Odoo image
FROM odoo:17.0

# Switch to root user to install dependencies
USER root

# Add PostgreSQL repository if needed
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Update package lists and install necessary system dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y python3-pip python3-dev libpq-dev build-essential nodejs npm

# Install Python dependencies (like pandas and scikit-learn)
RUN pip3 install pandas scikit-learn

# Switch back to the odoo user for Odoo-specific tasks
USER odoo

# Set the working directory for your app
WORKDIR /usr/src/app

# Install JavaScript dependencies (e.g., luxon)
RUN npm install luxon

# Copy your custom modules into the container
COPY ./addons /mnt/extra-addons
