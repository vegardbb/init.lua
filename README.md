# init.lua
Neovim config with sensible keymaps and batteries included.

Manually forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/tree/master).

## Installation

We typically recommend installing the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions installed.

**A word of caution:** When running on a Linux based OS, please refrain from installing the Snap version. As it turns out, this edition prepackages treesitter, so installing it along with Lazy makes the shell spam error message reading out like `Error detected while processing FileType Autocommands for "*":` See also: https://github.com/neovim/neovim-snap/issues/8

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`, or Zig)
  - on Windows, you may use the package manager Chocolatey ìn Admin mode to install unzip `choco install unzip` and make (`choco install make`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
   - Can also be installed with Chocolatey in Admin mode in Windows (`choco install ripgrep`)
- [fd-find](https://github.com/sharkdp/fd#installation)
   - Can also be installed with Chocolatey in Admin mode in Windows (`choco install fd`)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have one set in your terminal, set the value of `vim.g.have_nerd_font` in `init.lua` to `true`
- Emoji fonts (for Ubuntu only): `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you will need `node` and `npm`
  - If you want to write Golang, you will need the `go` binaries
  - And so on
- You will need to setup Copilot in your GitHub settings to make copilot.nvim and CopilotChat working
- `curl`, version 8.12, needs to be a runnable command on your system, this command is used by the aforementioned CopilotChat package
- `npm` must be a runnable command on your system, so that you may run `npm i tree-sitter-cli -g`, which is required to make parsing of TeX files work in tree-sitter

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Config Setup

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo, so that you have your own copy that you can modify at your own leasure, then install by cloning the fork down to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/init.lua.git`

When maintaining your fork, it is generally [recommended to track `lazy-lock.json` in version control](https://lazy.folke.io/usage/lockfile).

#### Clone the config repository

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `vegardbb` with `<your_github_username>` in the following commands

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/vegardbb/init.lua.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/vegardbb/init.lua.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/vegardbb/init.lua.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start up Neovim with this command:

```sh
nvim
```

That is all. Lazy will install all the plugins you have. Use `:Lazy` to view the current plugin status. Press `q` to close the buffer.

#### Read The Friendly Manual/Documentation

Read through the `init.lua` file in your configuration folder for further information about extending and exploring Neovim. That also includes examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to this one?
  * Yes, you can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install this configuration in `~/.config/nvim-vegardbb` and create an alias:
    ```
    alias nvim-vegardbb='NVIM_APPNAME="nvim-vegardbb" nvim'
    ```
    When you run Neovim using `nvim-vegardbb` alias it will use the alternative config directory and the matching local directory
    `~/.local/share/nvim-vegardbb`. You may apply this approach to any Neovim
    distribution that you would like to try out.
* *What if I want to "uninstall" this configuration?*
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* *Why is the entire configuration stored in a single file? Wouldn't it make sense to split it into multiple files?*
  * You are free to do so with your own fork/clone. Curiously enough, there already is a fork of `kickstart.nvim` that splits out modules into their own directories. It is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Further discussion on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)
* *How to filter out this and that annoying TS diagnostic message?*
  * See line 970 in `init.lua` for one such example. For a full list of diagnostic codes in Typescript, see the [codes in the diagnosticMessages.json](https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json) file in the Typescript repository.

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Config Setup](#Config Setup) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>
