{ config, ... }:

let
  localBinDir = "${config.home.homeDirectory}/.local/scripts";
in
{
  _module.args.localBinDir = localBinDir;

  home.file.".local/scripts".source = ../bin;
}
