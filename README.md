# Overview

This is my personal NixOs configuration


# Channel

nix-channel --list

nixos https://nixos.org/channels/nixos-25.05

sudo nix-channel --remove nixos

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

sudo nix-channel --update


# Warnings

\nThis is not the default location. You must set environment variable\nICAROOT to this location after installation has completed, for example:\n\nexport ICAROOT=-i "/nix/store/gdj6lja6l4q77bmsfr3dxp30361yzgbb-citrix-workspace-24.11.0.85/opt/citrix-icaclient"
\nProceed with installation? [default nWARNING: One of the prerequisites required for installation is not present- "libwebkit2gtk-4.0.so.37" not found. Citrix Workspace app (Self Service) may not work.\nDo you want to proceed with the installation..[default n]:
Installation proceeding...
\nChecking available disk space ...
\n\tDisk space available 380132964 K \n\tDisk space required 1156202 K
\n\nContinuing ...
Creating directory -i /nix/store/gdj6lja6l4q77bmsfr3dxp30361yzgbb-citrix-workspace-24.11.0.85/opt/citrix-icaclient
Core package...
Setting file permissions...
Failed to connect to user scope bus via local transport: $DBUS_SESSION_BUS_ADDRESS and $XDG_RUNTIME_DIR not defined (consider using --machine=<user>@.host --user to connect to bus of other user)
Created symlink '/build/tmp.Et8NKnFG2X/.config/systemd/user/default.target.wants/ctxcwalogd.service' → '/build/tmp.Et8NKnFG2X/.config/systemd/user/ctxcwalogd.service'.
Unit /build/tmp.Et8NKnFG2X/.config/systemd/user/ctxcwalogd.service is added as a dependency to a non-existent unit default.target.
Failed to connect to user scope bus via local transport: $DBUS_SESSION_BUS_ADDRESS and $XDG_RUNTIME_DIR not defined (consider using --machine=<user>@.host --user to connect to bus of other user)
