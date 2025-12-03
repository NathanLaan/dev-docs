{ config, pkgs, ... }:

{
  ########################
  # Base system settings #
  ########################

  imports = [
    ./hardware-configuration.nix
  ];

  # IMPORTANT: set this to the version you installed (e.g. "24.05").
  system.stateVersion = "24.05"; # CHANGE_ME: only bump on major upgrades

  networking.hostName = "minecart";  # Name of this server
  time.timeZone = "America/Edmonton";

  # Enable networking
  networking.useDHCP = true;

  ##########################
  # SSH + user management  #
  ##########################

  # SSH daemon
  services.openssh = {
    enable = true;
    settings = {
      # Keys only: more secure; set to true temporarily if you need passwords.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  # Firewall: allow SSH and Minecraft
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 25565 ];
    allowedUDPPorts = [ 25565 ];
  };

  # Main admin user
  users.users.laan = {
    isNormalUser = true;
    description = "Nathan";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHcrbgisg79OqMnmD/8CMS3Rcx0yf4777wNdRGi+LQWu laan@minecart"
    ];
  };

  # Disable root password login completely
  users.users.root = {
    # This locks the root password (no password auth, but sudo still works).
    hashedPassword = "!";
  };

  # sudo: wheel can sudo with password (you can change to false if you want no password).
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  #####################
  # Minecraft server  #
  #####################

  # Use the built-in Minecraft server service.
  services.minecraft-server = {
    enable = true;

    # Accept the EULA
    eula = true;

    # Use the vanilla server bundled by NixOS (or choose pkgs.minecraft-server if supported)
    # You can set `package = pkgs.minecraft-server;` explicitly if you want.
    # package = pkgs.minecraft-server;

    # Keep configuration declarative
    declarative = true;
    dataDir = "/var/lib/minecraft";

    # JVM tuning for a 4G heap (tune to your RAM)
    jvmOpts = ''
      -Xms4G
      -Xmx4G
      -XX:+UseG1GC
      -XX:+ParallelRefProcEnabled
      -XX:MaxGCPauseMillis=100
      -XX:+UnlockExperimentalVMOptions
      -XX:+DisableExplicitGC
      -XX:+AlwaysPreTouch
      -XX:G1NewSizePercent=30
      -XX:G1MaxNewSizePercent=40
      -XX:G1HeapRegionSize=8M
      -XX:G1ReservePercent=20
      -XX:G1HeapWastePercent=5
      -XX:G1MixedGCCountTarget=4
      -XX:InitiatingHeapOccupancyPercent=15
      -XX:G1MixedGCLiveThresholdPercent=90
      -XX:G1RSetUpdatingPauseTimePercent=5
      -XX:SurvivorRatio=32
      -XX:+PerfDisableSharedMem
      -XX:MaxTenuringThreshold=1
    '';

    # server.properties (declarative)
    serverProperties = {
      "motd" = "NixOS Minecraft Server";
      "max-players" = "10";
      "server-port" = "25565";
      "online-mode" = "true";
      "view-distance" = "10";
      "simulation-distance" = "10";
      "white-list" = "false";
      "spawn-protection" = "0";
      "enable-rcon" = "false";
      "enable-query" = "false";
    };

    # We manage the firewall ourselves above.
    openFirewall = false;
  };

  #########################
  # Automatic updates     #
  #########################

  # Automatically upgrade system from the current NixOS channel.
  system.autoUpgrade = {
    enable = true;
    # Uses `nixos-rebuild switch --upgrade` under the hood.
    allowReboot = true;      # Set false if you want to manually reboot after upgrades
    dates = "03:30";         # Nightly upgrades at 03:30
    randomizedDelaySec = "45min";
  };

  # Optional: optimize store automatically
  nix.settings = {
    auto-optimise-store = true;
  };

  #########################
  # Basic hardening       #
  #########################

  # Kernel-level hardening
  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
  };

  # Protect the kernel image from being read by unprivileged users
  security.protectKernelImage = true;

  # Enable fail2ban to block brute-force logins
  services.fail2ban = {
    enable = true;
    jails = {
      sshd.settings = {
        enabled = "true";
        port = "ssh";
        filter = "sshd";
        logpath = "/var/log/auth.log";
        maxretry = "5";
      };
    };
  };

  # Optional: AppArmor
  # security.apparmor.enable = true;
  # security.apparmor.profiles = [ "abstractions/base" ];

  #########################
  # Misc default services #
  #########################

  # Enable OpenSSH-only headless server profile
  services.xserver.enable = false;  # no GUI, saves RAM/CPU for Minecraft

  # Basic system packages you might want
  environment.systemPackages = with pkgs; [
    vim
    htop
    tmux
    jq
    wget
    git
  ];
}
