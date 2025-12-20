{ pkgs, secrets, ... }:
{
  users.users.monu = {
    packages = [ pkgs.simple-scan ];
    extraGroups = [
      "scanner"
      "lp"
    ];
  };

  # Printing setup
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-brother-dcpt725dw ];

  # Scanner
  hardware = {
    sane = {
      enable = true;
      brscan4.enable = true;
    };
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_DCP-T820DW";
        location = "Home";
        deviceUri = "usb://Brother/DCP-T820DW?serial=${(import "${secrets}/config").printer-serial}";
        model = "brother_dcpt725dw_printer_en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Brother_DCP-T820DW";
  };
}
