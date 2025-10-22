# hotspot-toggle

**hotspot-toggle** is a lightweight Bash utility for creating, enabling, and disabling Wi-Fi hotspots on Linux systems that use **NetworkManager**.  
It automates `nmcli` hotspot creation and toggling, allowing quick use via a simple command:

```bash
hotspot on     # Start or initialize the hotspot
hotspot off    # Stop the hotspot
```

---

## 🧩 Features

- One-time hotspot initialization (SSID + password)
- Simple toggle command (`hotspot on | off`)
- Persistent configuration stored in NetworkManager
- Works on most modern Linux distributions
- No root required after installation
- Supports shared internet (optional NAT setup)
- Clean error handling and status feedback

---

## 🧱 Requirements

| Requirement | Description |
|--------------|-------------|
| **NetworkManager** | Must manage your Wi-Fi device |
| **nmcli** | Comes with NetworkManager |
| **Wi-Fi adapter with AP mode** | Check with `iw list | grep -A10 "Supported interface modes"` |
| **Bash ≥ 4** | Default in most distributions |

---

## 🖥️ Supported Distributions

✅ **Fully supported:**
- Rocky Linux / RHEL / CentOS Stream
- Fedora
- Ubuntu / Debian / Linux Mint
- openSUSE (if NetworkManager is active)
- Pop!_OS

⚠️ **Partial / unsupported without modification:**
- Arch Linux (if using `iwd` or `systemd-networkd` instead of NetworkManager)
- WSL, containers, or virtual machines (no physical Wi-Fi interface)

---

## ⚙️ Installation

### Option 1 — Manual Install
```bash
git clone https://github.com/<yourusername>/hotspot-toggle.git
cd hotspot-toggle
sudo cp hotspot /usr/local/bin/
sudo chmod +x /usr/local/bin/hotspot
```

### Option 2 — System Package (planned)
Future versions will include an `.rpm` package for direct installation:
```bash
sudo dnf install hotspot-toggle.rpm
```

---

## 🚀 Usage

### Start the hotspot
```bash
hotspot on
```
- If it’s your first time, the script asks for SSID and password.
- Configuration is saved in NetworkManager as “Hotspot”.
- Next runs reuse stored settings automatically.

### Stop the hotspot
```bash
hotspot off
```

### Reset the hotspot (reinitialize)
```bash
nmcli connection delete Hotspot
```
Then rerun `hotspot on` to reconfigure.

---

## 🔧 Configuration

If your Wi-Fi interface name differs (e.g., `wlan0` or `wlp2s0`),  
edit the script line:
```bash
DEVICE="wlp9s0"
```

To list your interfaces:
```bash
nmcli device status
```

---

## 🧠 How It Works

The script uses **NetworkManager’s `nmcli`** to:
1. Detect if a hotspot connection named `Hotspot` exists.
2. If not, prompt for SSID and password, create it with:
   ```bash
   nmcli dev wifi hotspot ifname <iface> ssid <ssid> password <password>
   ```
3. Set IPv4 method to `shared` for NAT internet sharing.
4. Activate or deactivate it with:
   ```bash
   nmcli connection up Hotspot
   nmcli connection down Hotspot
   ```

---

## 🔒 Security Notes

- Password must be at least 8 characters.
- NetworkManager stores hotspot credentials securely in its configuration.
- Anyone connected to your hotspot shares your local network, so use strong credentials.

---

## 🧰 Troubleshooting

| Issue | Command / Fix |
|--------|----------------|
| Wi-Fi unavailable | `rfkill unblock all` |
| Missing driver | `lspci -nnk | grep -A3 -i network` then install appropriate firmware |
| Error: device not supported | Check AP mode with `iw list` |
| Hotspot not starting | `sudo systemctl restart NetworkManager` |
| Connection name changed | Edit `CON_NAME` in the script |

---

## 🧪 Example Session

```bash
$ hotspot on
Hotspot not initialized.
Enter SSID: MyHotspot
Enter password (8+ chars): ********
Hotspot 'MyHotspot' created and active.

$ nmcli connection show --active
NAME        UUID                                  TYPE   DEVICE
Hotspot     e4a3f7b5-xxxx-xxxx-xxxx-xxxxxxxxxxxx  wifi   wlp9s0

$ hotspot off
Hotspot deactivated.
```

---

## 🗃️ File Structure

```
hotspot-toggle/
├── hotspot        # Main Bash script
├── README.md      # Documentation (this file)
├── HELP.md        # Detailed command reference
└── LICENSE        # License file (MIT recommended)
```

---

## 🧩 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 🧑‍💻 Author

**Your Name**  
Linux / Embedded Systems / RF & IC Design Enthusiast  
📧 <your.email@example.com>  
GitHub: [@yourusername](https://github.com/yourusername)

---

## ⭐ Contributing

Pull requests are welcome.  
If you add features such as:
- Interface auto-detection  
- NAT/bridge mode selection  
- GUI/GTK front-end  

…document them in both `README.md` and `HELP.md` before submitting.

---

## 🧾 Version History

| Version | Date | Notes |
|----------|------|-------|
| 1.0.0 | 2025-10-22 | Initial release |

---

### 🧠 TL;DR Quick Commands

```bash
# Enable hotspot
hotspot on

# Disable hotspot
hotspot off

# Reset configuration
nmcli connection delete Hotspot

# Show current Wi-Fi interfaces
nmcli device status
```

---
**Simple. Portable. Reliable.**
