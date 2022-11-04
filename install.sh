sudo cp ~/Documents/Github/nixos/configuration.nix /etc/nixos/configuration.nix
echo "Instalation start"
sudo nixos-rebuild switch
echo "Instalation end"
