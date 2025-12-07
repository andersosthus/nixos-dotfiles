{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Anders Østhus";
        email = "anders@osthus.me";
      };
    };
    settings = {
      init.defaultBranch = "main";
    };
  };
}
