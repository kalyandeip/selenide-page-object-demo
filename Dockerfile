FROM maven:3.9.6-eclipse-temurin-17 AS build

# Install Chrome
RUN apt-get update && apt-get install -y \
    wget gnupg unzip curl \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libnspr4 libnss3 libxss1 xdg-utils libgbm1 libgtk-3-0

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google.gpg
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

# Optional: Install Xvfb if using with non-headless Chrome
# RUN apt-get install -y xvfb

# Set display env if needed
ENV DISPLAY=:99

# Setup workdir
WORKDIR /usr/src/app

# Copy source
COPY . .

# Build
RUN mvn clean test

# Default CMD
CMD ["mvn", "test"]
