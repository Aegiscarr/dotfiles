{
  inputs,
  self,
  config,
  ...
}: {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs self;
      inherit (config.networking) hostName;
    };
    users = {
      # TODO - change username
      aegiscarr = ./aegiscarr;
      # more users can go here, the format is only for convenience
    };
  };
}
