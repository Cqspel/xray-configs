# Xray Configurations

This repository contains configuration templates and examples for setting up [Xray](https://github.com/XTLS/Xray-core), a powerful proxy tool designed to protect your internet traffic and bypass censorship.

## Features
- Pre-configured templates for Xray server setup
- Supports various Xray protocols and settings
- Easy customization using placeholders for dynamic values

## Getting Started

### Prerequisites
- **git**: Required to clone this repository
- **bash**: Used to run the installation script

### Installation
1. Clone the repository:
   ```bash
   apt-get update
   apt-get install git
   mkdir ~/xray && cd ~/xray
   git clone https://github.com/Cqspel/xray-configs.git
   cd xray-configs
   ```

2. Use the provided `debian_12_install.sh` script to install Xray and automatically replace the placeholders in the configuration file:
   ```bash
   ./debian_12_install.sh
   ```

### Example Placeholder Values
- `{{client_id}}`: Randomly generated client ID (e.g., `cccaaaYhS11D`)
- `{{private_key}}`: Private key generated using the `xray x25519` command
- `{{short_id}}`: Randomly generated short ID (e.g., `d491234f456fdaaa`)

## Configuration Files
- `server-config.json`: Template for setting up an Xray server
- Additional templates can be added for specific use cases or protocols

## Clients
- **macOS**: Use [FoXray](https://github.com)
- **iOS**: Use [Shadowrocket](https://apps.apple.com)

### Client Configuration Recommendations
1. **General Settings:**
   - Address: The IP of your host
   - Port: `443`
   - UUID: `{{client_id}}`

2. **Transport Settings:**
   - Type: `grpc`
   - Host: Empty
   - Service Name: `/`

3. **TLS Settings:**
   - TLS: `true`
   - SNI: `www.yahoo.com`
   - ECH: Empty
   - ALPN: Empty
   - Public key: `{{public_key}}`
   - Short ID: `{{short_id}}`
   - Fragment: `off`

4. **Advanced Settings:**
   - Muxing: `false`
   - TCP Fast Open: `false`
   - UDP Relay: `off`

### Suggested Rules for Clients
1. **General Rules:**
   - SKIP Proxy: `*.ru`

2. **Rule:**
   - Type: `GEOIP`
   - Policy: `DIRECT`
   - Country/Area: `RU`

## Tested Configuration
This configuration has been tested with **Xray 24.11.30** to ensure compatibility and functionality.

## Contribution
Contributions are welcome! To add or improve templates, follow these steps:
1. Fork the repository
2. Create a new branch: `git checkout -b feature-branch`
3. Make your changes and commit: `git commit -m 'Add feature'`
4. Push the branch: `git push origin feature-branch`
5. Submit a pull request

## Support
For issues or questions, feel free to open an issue in this repository or consult the [Xray documentation](https://xtls.github.io/).

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

