{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # nix.settings.trusted-users = [ "erik" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_13;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  services.keyd = {
    enable = true;
    keyboards = {
      defaults = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      # options = "caps:swapescape";
      variant = "nodeadkeys";
    };
  };

  console.useXkbConfig = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.erik = {
      isNormalUser = true;
      description = "Erik Wright";
      extraGroups = [
        "networkmanager"
        "video"
        "wheel"
      ];
      packages = with pkgs; [ ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.htop.enable = true;
  programs.hyprland.enable = true;
  programs.light.enable = true;
  programs = {
    zsh = {
      enable = true;
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
      syntaxHighlighting.enable = false;
      autosuggestions.enable = true;
      enableCompletion = true;
      # dotDir = ".config/zsh";
      # completionInit = ''
      #   autoload -Uz compinit && compinit
      #   zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      # '';
      #
      # plugins = [
      #   {
      #     name = "zsh-vi-mode";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "jeffreytse";
      #       repo = "zsh-vi-mode";
      #       rev = "v0.9.0";
      #       sha256 = "sha256-KQ7UKudrpqUwI6gMluDTVN0qKpB15PI5P1YHHCBIlpg=";
      #     };
      #   }
      # ];
      #
      # # .zshrc
      # initExtra = ''
      #   export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
      #
      #   source ~/.dotfiles/path
      #   source ~/.dotfiles/func
      #
      #   unsetopt share_history
      #   setopt no_share_history
      # '';
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bun
    chezmoi
    clang
    curl
    dbeaver-bin
    direnv
    eza
    fzf
    ghostty
    git
    inputs.neovim-nightly-overlay.packages.${system}.default
    gparted
    meslo-lgs-nf
    nixfmt-rfc-style
    nodejs_22
    ripgrep
    rustup
    starship
    tofi
    unzip
    uv
    vim
    waybar
    yazi
    inputs.zen-browser.packages."${system}".default
    zoxide
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
