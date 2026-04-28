FROM debian:bullseye-slim
# Project By Surya..!!!
# Install dependencies 
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    tmux \
    procps \
    nano \
    ca-certificates \
    tar \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

# Download and install Tailscale binaries
RUN curl -fsSL https://pkgs.tailscale.com/stable/tailscale_1.62.1_amd64.tgz | tar xz -C /tmp && \
    mv /tmp/tailscale_*/tailscale /usr/local/bin/ && \
    mv /tmp/tailscale_*/tailscaled /usr/local/bin/ && \
    rm -rf /tmp/tailscale_*

# Download and install AdGuard Home
RUN curl -L -o /tmp/AdGuardHome.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz && \
    tar -xvf /tmp/AdGuardHome.tar.gz -C /opt && \
    rm /tmp/AdGuardHome.tar.gz

# Copy custom configuration files
#COPY adlists.txt /adlists.txt
COPY start.sh /custom-start.sh

RUN chmod +x /custom-start.sh

# Expose port 80 so Render can route the web admin dashboard
EXPOSE 80

# Start script
ENTRYPOINT ["/custom-start.sh"]
