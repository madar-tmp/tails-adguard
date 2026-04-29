# 🛡️ Tails-AdGuard

![Docker](https://img.shields.io/badge/Docker-Ready-blue?logo=docker&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-Zero_Trust-black?logo=tailscale&logoColor=white)
![AdGuard Home](https://img.shields.io/badge/AdGuard_Home-DNS-success?logo=adguard&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

A streamlined, cloud-native DNS sinkhole and ad-blocking server. This project combines the powerful filtering of **AdGuard Home** with the zero-trust mesh networking of **Tailscale**. 

Designed specifically to be deployed seamlessly on **Render Web Services**, it automatically handles configuration, password encryption, and native DNS-over-HTTPS (DoH) routing on boot.

---

## ✨ Features
* **Zero-Trust Networking:** Only accessible to devices authenticated on your personal Tailnet.
* **Native Encrypted DNS:** Bypasses proxy overhead by utilizing built-in DoH routing to Cloudflare and Quad9.
* **Ephemeral Ready:** Generates secure `yaml` configurations dynamically on boot without manual setup wizards.
* **Web Panel Secured:** Automatically encrypts your custom dashboard password via `bcrypt`.
* **Auto-Updatable:** Integrated with Debian package managers so Tailscale can be updated directly from the Tailscale Admin Console.

---

## ⚙️ Environment Variables

When deploying this project (e.g., on Render), you must configure the following environment variables:

| Variable | Status | Description |
| :--- | :--- | :--- |
| `TAILSCALE_AUTHKEY` | **Required** | Your Tailscale authentication key. It is highly recommended to generate a **Reusable** and **Ephemeral** key from the [Tailscale Admin Console](https://login.tailscale.com/admin/settings/keys). |
| `ADGUARD_PASSWORD` | *Optional* | The password used to log into the AdGuard Home Web UI. If left blank, it defaults to `admin`. Username is always `admin`. |

---

## 🚀 Deployment & Login

1. Deploy the Dockerfile to a Render Web Service.
2. Wait for the build and deployment process to finish (check the Render logs for `Running AdGuard Home boot sequence...`).
3. Access the dashboard by visiting your public Render URL (e.g., `https://tails-adguard.onrender.com/`) or by navigating to `http://tails-adguard/` if you are connected to Tailscale.
4. Log in using the username **`admin`** and the password you set in your `ADGUARD_PASSWORD` environment variable.

---

## 🌐 Setting Up Tailscale DNS

To force your devices to use this AdGuard container to block ads, you need to configure your Tailnet to route DNS queries to it.

1. **Get the IP:** Open your [Tailscale Machines Dashboard](https://login.tailscale.com/admin/machines). Find the machine named `tails-adguard` and copy its Tailscale IP address (e.g., `100.x.x.x`).
2. **Go to DNS Settings:** Navigate to the **DNS** tab in the Tailscale Admin Console.
3. **Add Nameserver:** Scroll down to **Nameservers** -> **Add nameserver** -> **Custom...**
4. **Enter IP:** Paste the `100.x.x.x` IP address you copied in step 1.
5. **Override Local DNS:** Once added, toggle the switch that says **"Override local DNS"**. 
6. *(Optional but recommended)*: Enable **MagicDNS** in the Tailscale settings to ensure seamless host resolution.

Your Tailscale-connected devices will now route all DNS queries through your private AdGuard Home server.

---

## ⏰ Keep-Alive (For Free Tier Users)

If you are deploying this on Render's Free Web Service tier, the container will spin down after 15 minutes of inactivity, which will break your DNS. 

To keep the DNS server awake permanently:
1. Create a free account on [cron-job.org](https://cron-job.org/).
2. Create a new cron job targeting your AdGuard login page: `https://your-app-name.onrender.com/login.html` *(Note: You must target `/login.html` to prevent 302 redirect errors)*.
3. Set the execution schedule to run every **10 to 14 minutes**.
4. Save the job. Your DNS server will now stay awake 24/7.

---

## 📜 License & Credits

**MIT License**

Designed and built with ❤️ by **Surya...!!!** Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, of the Software.
