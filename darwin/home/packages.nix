{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
    fd
    gcc
    gh
    gnumake
    gnupg
    go
    jdk21
    just
    kubectl
    kubernetes-helm
    maven
    mc
    minikube
    ncdu
    nodejs_21
    parallel
    podman
    podman-compose
    qemu
    quarto
    ripgrep
    tealdeer
    terraform
    terragrunt
  ];
}
