{ pkgs }:

{
  deps = [
    pkgs.libzbar
  ];

  env = {
    LD_LIBRARY_PATH = "${pkgs.libzbar}/lib";
  };
}
