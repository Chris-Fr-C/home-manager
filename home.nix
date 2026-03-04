{ pkgs, ... }:

{
  imports = [
    ./base.nix
  ];
  
  # For sunshine streaming
  home.file.".xprofile" = {
    text =''
      xset -dpms
      xset s off
      xset s noblank
    '';
  };

# Disable KDE monitor sleep (Wayland-safe, fixes Sunshine 503)
# Disable ALL display sleep in KDE (Wayland-safe)
# The Migration section I had this on my initial file, no idea if i should keep it.
  home.file.".config/powermanagementprofilesrc".text = ''
    [Migration]
    MigratedProfilesToPlasma6=powerdevilrc

    [AC][DPMSControl]
    idleTime=0
    lockBeforeTurnOff=0
    turnOffDisplayIdleTimeout=0

    [Battery][DPMSControl]
    idleTime=0
    lockBeforeTurnOff=0
    turnOffDisplayIdleTimeout=0

    [LowBattery][DPMSControl]
    idleTime=0
    lockBeforeTurnOff=0
    turnOffDisplayIdleTimeout=0
    '';

  # Disable screen locking entirely
  home.file.".config/kscreenlockerrc".text = ''
    [Daemon]
    Autolock=false
    LockOnResume=false
    Timeout=0
    '';

}
