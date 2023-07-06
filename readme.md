# Personal NixOS Configuration

## Pre-requisites

In order to install Displaylink drivers, we need to pre-fetch displaylink drivers from [https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.6.1-EXE.zip](https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.6.1-EXE.zip) then rename the executable to `displaylink-561.zip` (or whatever the version currently is). Then use `nix-prefetch-url` to make it available to nix

```bash
nix-shell -p wget
wget https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.6.1-EXE.zip -o ~/Downloads/displaylink-561.zip
nix-prefetch-url file://$HOME/Downloads/displaylink-561.zip
```

## Instructions

1. Create an EFI boot partition and label it `boot`
2. Create a root partition and label it `root`
3. Create a swap partition and label it `swap`
4. Mount the root partition to `/mnt`

    ```bash
    mount /dev/disk/by-label/root /mnt
    ```

5. Create the boot mount folder

    ```bash
    mkdir /mnt/boot/efi
    ```

6. Mount the boot partition to `/mnt/boot/efi`

    ```bash
    mount /dev/disk/by-label/boot /mnt/boot/efi
    ```

7. Enable the swap partition

    ```bash
    swapon /dev/disk/by-label/swap
    ```

8. Enable Git and Nix Flakes

    ```bash
    nix-shell -p git nixFlakes
    ```

9. Clone this repository

    ```bash
    git clone https://github.com/guoguojin/nixos.git /path/to/clone-to
    ```

10. Navigate to the folder you just cloned:

    ```bash
    cd /path/to/clone-to
    ```

11. Install NixOS

    ```bash
    nixos-install --flake .#<profile-to-install>
    ```

    This will use the specified profile and flake to install the system. You will be prompted for a root password
    for the system. Enter the password you want to use and repeat when prompted.

12. When finished reboot the machine. Log in and remember to change the user password. 

## Post install

To modify the build, edit the flake files, then run `sudo nixos-rebuild switch`.

By default if there's a `flake.nix` file in the /etc/nixos folder, `nixos-rebuild` will automatically run as though the `--flake` flag has been passed to it. If the profile name is not specified, then `nixos-rebuild` use the machine's hostname as the profile name.

The above command when run with a flake is equivalent to:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#<hostname>
```

## Adding system wide configurations

To add system wide configurations, look up the configuration settings on [https://search.nixos.org/options?channel=unstable](https://search.nixos.org/options?channel=unstable).

Create a new nix script under config and import the script in the configurations.nix file you want to add the configuration to.

## Adding user specific application configurations (home-manager)

To add user specific configurations that are managed by `home-manager`. Lookup the configuration settings you need on [https://rycee.gitlab.io/home-manager/options.html](https://rycee.gitlab.io/home-manager/options.html). Create a new nix script under `user/programs` and import the script in the `user/programs.nix` file you want to add the configuration to.

If you want to create machine specific user configurations, add a new nix script under `config/<machine-name>` and point to it in the flake.nix file:

```nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./config/<machine-name>/<your-home-config-file>.nix
              ];
            };
          }
```
