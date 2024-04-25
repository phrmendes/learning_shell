{
  inputs,
  parameters,
  ...
}: {
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc"
      "/var/lib"
      "/var/log"
    ];
    users.${parameters.user} = {
      files = [
        ".config/kde.org"
        ".config/plasma-org.kde.plasma.desktop-appletsrc"
        ".config/kwinoutputconfig.json"
      ];
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Projects"
        "Videos"
        "Zotero"
        ".gnupg"
        ".mozilla"
        ".ssh"
        ".tmux"
        ".config/kde.org"
        ".config/Bitwarden"
        ".config/Duplicati"
        ".config/dconf"
        ".config/obsidian"
        ".config/syncthing"
        ".config/systemd"
        ".local/share/Trash"
        ".local/share/atuin"
        ".local/share/keyrings"
        ".local/share/syncthing"
        ".local/share/zoxide"
        ".local/state/nvim"
      ];
    };
  };
}
