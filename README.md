git-branch-status
=================

Git command to give you an overview of your branches

![Screenshot](https://raw.github.com/alexdavid/git-branch-status/master/docs/screenshot.png)


## Installing
### Using nix flakes
```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  inputs.git-branch-status = {
    url = "github:alexdavid/git-branch-status";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, git-branch-status, ... }: let
    nixosConfigurations.myMachine = nixpkgs.lib.nixosSystem {
      modules = [{
        users.users.myuser.packages = [
          git-branch-status.packages.x86_64-linux.default
        ];
      }];
    };
  };
}
```

### Using git
```bash
$ git clone https://github.com/alexdavid/git-branch-status.git
$ cp git-branch-status/git-branch-status /usr/local/bin
```
