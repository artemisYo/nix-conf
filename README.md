# My nixos configuration
This is just a little config.

# Niri
I wanted to try out niri, as it seems a good fit for my laptop setup. It can cause problems on first install with nix, as before it is built any options niri brings aren't available and so the nix validator dies.
It seems to affect only some systems, with a 50/50 chance so far (I have tested on exactly 2 systems).

# Foot/Kitty
While developing this config on a vm, kitty would be undergoing a stroke in the font rendering department of the abomination that is the terminal emulator. Which is why foot was used instead, but foot sucks ass, so kitty also exists. Both modules cannot be enabled at the same time, so make sure to disable one of them.

# Configuration
This repo is a clusterfuck, so you *will* have to tweak it before it can work; for example: the configuration.nix shouldn't even be in here, but it is, so deal with it.

# Impure
This config is impure so far, while originally developed on a virtualbox vm, which requires the default user profile to be built using the impure flag set, there are more reasons it is like that.
The biggest (and only reason I have encountered without any further scrutiny) is the use of `builtins.fetch*` for both `wallpapers.nix` and the NUR in `emacs.nix`, which is an impure function.

# flake.lock
It might be necessary to delete flack.lock before building?