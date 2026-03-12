{ config, pkgs, lib, ... }:

{
  imports = [./base.nix];
  
  home.packages = with pkgs; [
    sqlcmd
    azure-cli
    powershell
    wslu
    mssql_jdbc
    liquibase
    uv
    (python313.withPackages (ps: with ps; [
      pip
      keyring
    ]))
  ];
  home.sessionVariables.PYTHONPATH = "$HOME/.local/lib/python3.13/site-packages";
  home.file.".local/wheels/artifacts_keyring-1.0.0-cp313-cp313-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl".source = ./thirdparty/artifacts_keyring-1.0.0-cp313-cp313-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl;

  home.activation.setupAzureKeyring = lib.hm.dag.entryAfter ["writeBoundary"] ''
    set -e
    WHEEL="$HOME/.local/wheels/artifacts_keyring-1.0.0-cp313-cp313-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl"
    SITE_PACKAGES="$HOME/.local/lib/python3.13/site-packages"
    mkdir -p "$SITE_PACKAGES"
    echo "Installing artifacts-keyring..."
    PYTHONPATH="$SITE_PACKAGES" ${pkgs.python313.withPackages (ps: with ps; [pip])}/bin/python -m pip install --target "$SITE_PACKAGES" "$WHEEL"
    echo "Done!"
  '';

}

