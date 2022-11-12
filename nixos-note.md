# Nixos notes

Small not with some useful nixos commands.

<details>
    <summary>Updating & Upgrading<summary>

    - $ nix-channel --update
    - $ sudo nixos-rebuild --upgrade
    - For nix-env:
        $ nix-env -u '*'
</details>

<details>
    <summary>Garbage Collection<summary>

    - $ nix-collect-garbage
        - --delete-old
        - d
</details>

