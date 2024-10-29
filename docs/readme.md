<div align="center">

# Flakeflight&nbsp;&nbsp;[![Built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)</div>

<small>
<table align="right">
<td>

**Home**</td>
<td>

[Environment](environment.md)</td>
<td>

[Controls](404.md)</td>

</table>
</small>
<div>
<img src="https://img.shields.io/badge/Nix-222.svg?logo=nixos" alt="Go">&nbsp;
<img src="https://img.shields.io/badge/Nushell-222.svg?logo=nushell" alt="Nu">&nbsp;
<img src="https://img.shields.io/badge/Zellij-222.svg?logo=tmux&logoColor=A3BD8D" alt="Zellij">&nbsp;
<img src="https://img.shields.io/badge/NixVim-222.svg?logo=neovim&logoColor=4C6DB0" alt="Nvim">&nbsp;
</div>

### Pre-flight checks ❄️
Install Nix using the [Determinate Nix installer](https://determinate.systems/posts/determinate-nix-installer), which enables Flakes[^1] for you.

```shell
curl --proto "=https" --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Ready for take-off 🛩️
Launch your productivity to the troposphere and start developing using Flakeflight!
```shell
nix develop github:ricoschouten/flakeflight
```

### Advanced flying ✈️
You can configure a custom Flakeflight flake using the template[^2].
```shell
nix flake new -t github:ricoschouten/flakeflight .
```

[^1]: https://nix.dev/concepts/flakes.html
[^2]: https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-flake-new
[^3]: https://github.com/nix-community/nix-direnv#creating-a-new-flake-native-project

[^1]: https://nix.dev/concepts/flakes.html
[^2]: https://github.com/nix-community/nix-direnv#creating-a-new-flake-native-project
[^3]: https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-flake-new