{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
    minikube
  ];
}