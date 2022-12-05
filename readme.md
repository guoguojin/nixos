# Personal NixOS Configuration

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

10. Symlink the `flake.nix` and `flake.lock` in `/mnt/etc/nixos`

    ```bash
    sudo ln -s /path/to/clone-to/flake.nix /mnt/etc/nixos/flake.nix
    sudo ln -s /path/to/clone-to/flake.lock /mnt/etc/nixos/flake.lock
    ```

11. Install NixOS

    ```bash
    nixos-install --flake /mnt/etc/nixos#<profile-to-install>
    ```

## Post install

To modify the build, edit the flake files, then run `sudo nixos-rebuild switch`.

By default if there's a `flake.nix` file in the /etc/nixos folder, `nixos-rebuild` will automatically run as though the `--flake` flag has been passed to it. If the profile name is not specified, then `nixos-rebuild` use the machine's hostname as the profile name.

The above command when run with a flake is equivalent to:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#<hostname>
```


