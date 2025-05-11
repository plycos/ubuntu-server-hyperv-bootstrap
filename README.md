# Ubuntu Server Hyper-V Bootstrap

This project automates enabling Hyper-V on Windows and sets up a scheduled task to resume the bootstrap process after a
required reboot.

## How It Works

- `bootstrap.ps1` is the main entry point. It checks for administrator rights and runs each step in order.
- The first step, `Enable-HyperV.ps1`, checks if Hyper-V is enabled:
    - If not, it prompts the user to enable it.
    - If the user agrees, it creates a scheduled task to resume the bootstrap after reboot and enables Hyper-V (which
      requires a reboot).
- After reboot, the scheduled task automatically resumes `bootstrap.ps1`.
- Cleanup logic in `bootstrap.ps1` ensures the scheduled task is always removed, even if something fails.

## Usage

1. Open PowerShell as Administrator.
2. Run the bootstrap script from the project root:

   ```powershell
   .\bootstrap.ps1
   ```

3. Follow the prompts to enable Hyper-V if needed.
4. If a reboot is required, allow the system to reboot. The process will resume automatically.

## Notes

- You must run the script as an administrator.
- The script is designed for Windows systems with PowerShell and DISM available.
- The scheduled task is automatically cleaned up after the process completes or fails.

---