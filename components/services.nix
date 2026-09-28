{ config, pkgs, lib, ... }:

let
  cfg = config.myServices;
  dockerBin = "${cfg.dockerPackage}/bin/docker";
in
{
  options.myServices = {
    enable = lib.mkEnableOption "user-level docker services (systemd user units + timers)";

    dataRoot = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/services/data";
      example = "/home/christophe/services/data";
      description = ''
        Root folder for service data. Each service gets a subdirectory
        below it, e.g. ''${dataRoot}/trilium.
      '';
    };

    dockerPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.docker;
      defaultText = lib.literalExpression "pkgs.docker";
      description = ''
        Package providing the `docker` CLI used in ExecStart/ExecStop.
        Override this if docker comes from the host system instead of nix,
        e.g. `pkgs.docker-client`, or a custom wrapper.
      '';
    };

    # If i use podman i must remember to activate the socket
    # `systemctl --user neable --now podman.socket`
    trilium = {
      enable = lib.mkEnableOption "Trilium Notes docker service (example service)";

      image = lib.mkOption {
        type = lib.types.str;
        default = "triliumnext/trilium:latest";
        example = "triliumnext/trilium:v0.91.0";
        description = "Docker image for Trilium.";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 8010;
        description = "Host port mapped to Trilium's container port 8010.";
      };
    };

    exampleCron = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Example cron job (systemd user timer) that runs
          `echo 'test cron'` every 12 hours.
        '';
      };

      onCalendar = lib.mkOption {
        type = lib.types.str;
        default = "*-*-* 00,12:00:00";
        example = "hourly";
        description = ''
          systemd OnCalendar schedule for the example cron job.
          Default runs at 00:00 and 12:00 every day (every 12 hours).
          See `man systemd.time` for the calendar format.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.dockerPackage ];

    # Make sure user services are (re)started on `home-manager switch`.
    systemd.user.startServices = lib.mkDefault "sd-switch";

    # Ensure the data root exists (belt and braces; the units also mkdir -p).
    home.activation.mkServicesDataRoot = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${cfg.dataRoot}"
    '';

    # --- Example service: Trilium Notes ---------------------------------
    # Data lives in ${dataRoot}/trilium, e.g. ~/services/data/trilium.
    # Reach it at http://localhost:<port> once started:
    #   systemctl --user status trilium.service
    #   systemctl --user start trilium.service
    #   journalctl --user -u trilium.service -f
    systemd.user.services.trilium = lib.mkIf cfg.trilium.enable {
      Unit = {
        Description = "Trilium Notes (docker service)";
        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];
      };
      Service = {
        Type = "simple";
        ExecStartPre = [
          "-${dockerBin} rm -f trilium"
          "${pkgs.coreutils}/bin/mkdir -p ${cfg.dataRoot}/trilium"
        ];
        ExecStart = "${dockerBin} run --rm --name trilium "
          # intermal port is 8080 but i allow to use a different port.
          + "-p ${toString cfg.trilium.port}:8080 "
          + "-v ${cfg.dataRoot}/trilium:/home/node/trilium-data "
          + cfg.trilium.image;
        ExecStop = "${dockerBin} stop trilium";
        Restart = "always";
        RestartSec = "10s";
      };
      Install.WantedBy = [ "default.target" ];
    };

    # --- Template for your next service ----------------------------------
    # Copy/paste this block, rename `myservice`, and add matching options
    # under `options.myServices` if you want it configurable:
    #
    # systemd.user.services.myservice = {
    #   Unit = {
    #     Description = "My service (docker)";
    #     After = [ "network-online.target" ];
    #     Wants = [ "network-online.target" ];
    #   };
    #   Service = {
    #     Type = "simple";
    #     ExecStartPre = [
    #       "-${dockerBin} rm -f myservice"
    #       "${pkgs.coreutils}/bin/mkdir -p ${cfg.dataRoot}/myservice"
    #     ];
    #     ExecStart = "${dockerBin} run --rm --name myservice "
    #       + "-p 1234:80 "
    #       + "-v ${cfg.dataRoot}/myservice:/data "
    #       + "myimage:latest";
    #     ExecStop = "${dockerBin} stop myservice";
    #     Restart = "always";
    #     RestartSec = "10s";
    #   };
    #   Install.WantedBy = [ "default.target" ];
    # };

    # --- Example cron job: every 12 hours --------------------------------
    # Equivalent of `0 */12 * * * echo 'test cron'`, implemented as a
    # systemd user timer (the Home Manager / systemd-native way).
    # Inspect with:
    #   systemctl --user status services-example-cron.{service,timer}
    #   systemctl --user list-timers
    #   journalctl --user -u services-example-cron.service -f
    systemd.user.services.services-example-cron = lib.mkIf cfg.exampleCron.enable {
      Unit.Description = "Example cron job (echo test cron)";
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/echo 'test cron'";
      };
    };

    systemd.user.timers.services-example-cron = lib.mkIf cfg.exampleCron.enable {
      Unit.Description = "Run example cron job every 12 hours";
      Timer = {
        OnCalendar = cfg.exampleCron.onCalendar;
        Persistent = true;
        Unit = "services-example-cron.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
