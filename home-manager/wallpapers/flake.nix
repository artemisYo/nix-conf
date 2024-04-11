{
  description = "Wallpaper collection, that's also locked!";

  inputs = {
    topDownBuilding = {
      url = "file+https://images.unsplash.com/photo-1711100360031-24aaccbcd408";
      flake = false;
    };
    castle = {
      url = "file+https://images.unsplash.com/photo-1492502014314-f5522cae92a6";
      flake = false;
    };
    cabin = {
      url = "file+https://images.unsplash.com/photo-1600890197174-a578edf49c1b";
      flake = false;
    };
    flowersYellowWall = {
      url = "file+https://images.unsplash.com/photo-1710599901865-0506a7cf062e";
      flake = false;
    };
  };

  outputs = {...}@papers: {
    nixosModules.default = { ... }: {
      custom.niri.wallpaperPath = papers.castle.outPath;
    };
  };
}
