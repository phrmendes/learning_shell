{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ../dotfiles/vscode/settings.json);
    keybindings = builtins.fromJSON (builtins.readFile ../dotfiles/vscode/keybindings.json);
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
        alejandra
        ansible-lint
        micromamba
        nil
        pandoc
        quarto
        shfmt
      ]);
  };
}
