FROM maven:3.9.6-eclipse-temurin-17 AS build

# Install required packages and Google Chrome
RUN apt-get update && apt-get install -y \
    wget curl gnupg2 unzip \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libnspr4 libnss3 libxss1 xdg-utils libgbm1 libgtk-3-0 \
    --no-install-recommends

# Add Google Chrome repo and install Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/trusted.gpg.d/google.gpg && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Install ChromeDriver compatible with WebDriverManager fallback or specific version if needed
# Optional: You can install xvfb if you run non-headless
