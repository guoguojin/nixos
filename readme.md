# Personal NixOS Configuration

## Pre-requisites

In order to install Displaylink drivers, we need to pre-fetch displaylink drivers from [https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.6.1-EXE.zip](https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.6.1-EXE.zip) then rename the executable to `displaylink-561.zip` (or whatever the version currently is). Then use `nix-prefetch-url` to make it available to nix

```bash
nix-shell -p wget
wget https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.6.1-EXE.zip -o ~/Downloads/displaylink-561.zip
nix-prefetch-url file://$HOME/Downloads/displaylink-561.zip
```

## Instructions

The easiest way to install NixOS using this flake is to download a NixOS LiveCD Installer from 
[https://nixos.org/download.html](https://nixos.org/download.html). Once you have booted into the installer
and connected to the Internet (You will not be able to install from a flake without an internet connection),
make sure you have exited the Calamares installer.

Use GParted or a CLI disk partitioner to prepare your disks, you will need the following:

1. Create an EFI boot partition formatted to `FAT32` and label it `boot`
2. Create a root partition formatted to `EXT4` and label it `root`
3. Create a swap partition formatted to `linuxswap` and label it `swap`

> Note: if you want to format the root partition to something other than `EXT4`, you can do so, but you need
  to update the hardware-configuration.nix for the machine definition accordingly.

1. Open up a terminal.

2. Mount the root partition to `/mnt`

    ```bash
    mount /dev/disk/by-label/root /mnt
    ```

3. Create the boot mount folder

    ```bash
    mkdir /mnt/boot/efi
    ```

4. Mount the boot partition to `/mnt/boot/efi`

    ```bash
    mount /dev/disk/by-label/boot /mnt/boot/efi
    ```

5. Enable the swap partition

    ```bash
    swapon /dev/disk/by-label/swap
    ```

6. Enable Git and Nix Flakes

    ```bash
    nix-shell -p git nixFlakes
    ```

7. Clone this repository

    ```bash
    git clone https://github.com/guoguojin/nixos.git /path/to/clone-to
    ```

    > NOTE: If you clone the folder into a volatile path (i.e. a path that will not be available after you have
    installed NixOS), you will need to clone the repo again after the install is completed and you have rebooted
    in order to update your system with the flake.<br/>
    </br>
    Alternatively, you should clone this into the mounted volume so you can access it again after you have 
    installed NixOS.


8. Navigate to the folder you just cloned:

    ```bash
    cd /path/to/clone-to
    ```

9. Install NixOS

    ```bash
    nixos-install --flake .#<profile-to-install>
    ```

    This will use the specified profile and flake to install the system. You will be prompted for a root password
    for the system. Enter the password you want to use and repeat when prompted.

10. When finished reboot the machine. Log in and remember to change the user password.

## Post install

After you have logged in and you have changed your password, you should create a sym link to the flake.nix and 
flake.lock file in /etc/nixos. As previously mentioned, you may need to clone this repository again after you
have completed the install if you had originally cloned it to a volatile file system (i.e. the install LiveCD).

```bash
sudo ln -s /path/to/clone-to/flake.nix /etc/nixos/flake.nix
sudo ln -s /path/to/clone-to/flake.lock /etc/nixos/flake.lock
```

To modify the build, edit the flake files, then run `sudo nixos-rebuild switch`.

By default if there's a `flake.nix` file in the /etc/nixos folder, `nixos-rebuild` will automatically run as though the `--flake` flag has been passed to it. If the profile name is not specified, then `nixos-rebuild` use the machine's hostname as the profile name.

The above command when run with a flake is equivalent to:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#<hostname>
```

The location of this repo will not matter as long as the `flake.nix` and `flake.lock` files are symlinked 
to `/etc/nixos`

## Adding system wide configurations

To add system wide configurations, look up the configuration settings on [https://search.nixos.org/options?channel=unstable](https://search.nixos.org/options?channel=unstable).

Create a new nix script under config and import the script in the configurations.nix file you want to add the configuration to.

See the `nvidia` nix configuration files or `steam.nix` for examples.

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

## Variety Wallpaper Changer

The variety wallpaper changer will not correctly show wallpapers if you are using i3 because the session is called
`none+i3` and not just `i3` which is what the `set_wallpaper` script checks for.

To get the set_wallpaper working correctly: 

1. Find the `set_wallpaper` script - typically it is in `$XDG_CONFIG_HOME/variety/scripts/`. 
2. Find the line that defines the `SIMPLE_WMS` list. You should see `i3` along with `bspwm`, `dwm`, `xmonad` etc.
   listed with it.
3. Add `none+i3` as the first entry in the list.
4. Save the file.

Now when you update the wallpaper it should display correctly.
