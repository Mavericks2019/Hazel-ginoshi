import os
import subprocess
import sys
from pathlib import Path

# Add project root and vendor to Python path
PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT / 'scripts'))
sys.path.insert(0, str(PROJECT_ROOT / 'vendor'))

import Utils

VULKAN_SDK = os.environ.get('VULKAN_SDK')
VULKAN_SDK_INSTALLER_URL = 'https://sdk.lunarg.com/sdk/download/latest/windows/vulkan_sdk.exe'
HAZEL_VULKAN_VERSION = '1.4.350.0'
VULKAN_SDK_EXE_PATH = str(PROJECT_ROOT / 'vendor' / 'VulkanSDK' / 'VulkanSDK.exe')

def InstallVulkanSDK():
    print('Downloading {} to {}'.format(VULKAN_SDK_INSTALLER_URL, VULKAN_SDK_EXE_PATH))
    Utils.DownloadFile(VULKAN_SDK_INSTALLER_URL, VULKAN_SDK_EXE_PATH)
    print("Done!")
    print("Running Vulkan SDK installer...")
    os.startfile(os.path.abspath(VULKAN_SDK_EXE_PATH))
    print("Re-run this script after installation")

def InstallVulkanPrompt():
    print("Would you like to install the Vulkan SDK?")
    install = Utils.YesOrNo()
    if (install):
        InstallVulkanSDK()
        quit()

def CheckVulkanSDK():
    if (VULKAN_SDK is None):
        print("You don't have the Vulkan SDK installed!")
        InstallVulkanPrompt()
        return False
    elif (HAZEL_VULKAN_VERSION not in VULKAN_SDK):
        print(f"Located Vulkan SDK at {VULKAN_SDK}")
        print(f"You don't have the correct Vulkan SDK version! (Hazel requires {HAZEL_VULKAN_VERSION})")
        InstallVulkanPrompt()
        return False
    
    print(f"Correct Vulkan SDK located at {VULKAN_SDK}")
    return True

def CheckVulkanSDKDebugLibs():
    # Debug libs are now included in the standard Vulkan SDK installer (>= 1.3.268).
    # Just make sure to check "Install Vulkan Debug Symbols (x64)" during installation.
    if (VULKAN_SDK is None):
        print("VULKAN_SDK environment variable is not set. Cannot check for debug libs.")
        print("Please install the Vulkan SDK first.")
        return False

    shadercdLib = Path(f"{VULKAN_SDK}/Lib/shaderc_sharedd.lib")
    if (not shadercdLib.exists()):
        print(f"Vulkan SDK debug libs not found. (Checked {shadercdLib})")
        print("Re-run the Vulkan SDK installer and make sure to check:")
        print('  "Install Vulkan Debug Symbols (x64)"')
        return False

    print(f"Vulkan SDK debug libs located at {shadercdLib}")
    return True