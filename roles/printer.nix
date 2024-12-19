{ pkgs, secrets, ... }:
{
  # Printing setup
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.unstable.cups-brother-dcpt725dw ];

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
