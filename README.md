# MAS Automated Installer Scripts

This repository contains helper scripts to simplify and automate tasks when deploying **IBM Maximo Application Suite (MAS)** on OpenShift.  
It includes:
1. A script to create the Image Registry PVC in OpenShift.
2. An automated installer script using `expect` to handle interactive prompts during MAS installation.

---

## 📂 Files

### 1. script_image_registry.sh
This shell script creates the required PVC for the OpenShift internal image registry.  

**Usage:**
1. Make it executable
``` bash
chmod +x script_image_registry.sh
```

2. Run the script
```
./script_image_registry.sh
```

### 2. script_mas_auto_install.exp
An expect script that automatically provides answers to the interactive mas install prompts.
This is useful for unattended or repeatable installations.

**Usage:**
1. Install expect (if not already installed):
``` bash
yum install -y expect
```

2. Make it executable
``` bash
chmod +x script_mas_auto_install.exp
```

3. Run the script instead of mas install
``` bash 
./script_mas_auto_install.exp
```
This will:
- Launch the MAS installer
- Match each installer prompt
- Send your predefined answer
- Hand back control to you at the end

## ⚠️ Notes

- Run these scripts inside the same environment/container where MAS CLI is installed.
- Adjust answers inside script_mas_auto_install.exp according to your cluster configuration.
- Use at your own risk: these scripts are intended to assist with automation and reduce repetitive typing.

## 👤 Author
Mohammad Yahya Ibrahim
yahyaibrahim01@gmail.com