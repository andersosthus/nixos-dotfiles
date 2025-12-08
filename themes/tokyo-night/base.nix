{ lib, ... }:

let
  base = {
    color00 = { r =  26; g =  27; b =  38; a = 255; }; #1A1B26
    color01 = { r =  22; g =  22; b =  30; a = 255; }; #16161E
    color02 = { r =  47; g =  53; b =  73; a = 255; }; #2F3549
    color03 = { r =  68; g =  75; b = 106; a = 255; }; #444B6A
    color04 = { r = 120; g = 124; b = 153; a = 255; }; #787C99
    color05 = { r = 169; g = 177; b = 214; a = 255; }; #A9B1D6
    color06 = { r = 203; g = 204; b = 209; a = 255; }; #CBCCD1
    color07 = { r = 213; g = 214; b = 219; a = 255; }; #D5D6DB
    color08 = { r = 192; g = 202; b = 245; a = 255; }; #C0CAF5
    color09 = { r = 169; g = 177; b = 214; a = 255; }; #A9B1D6
    color10 = { r =  13; g = 185; b = 215; a = 255; }; #0DB9D7
    color11 = { r = 158; g = 206; b = 106; a = 255; }; #9ECE6A
    color12 = { r = 180; g = 249; b = 248; a = 255; }; #B4F9F8
    color13 = { r =  42; g = 195; b = 222; a = 255; }; #2AC3DE
    color14 = { r = 187; g = 154; b = 247; a = 255; }; #BB9AF7
    color15 = { r = 247; g = 118; b = 142; a = 255; }; #F7768E
  };

  # Helpers
  pad2 = s: if builtins.stringLength s == 1 then "0${s}" else s;
  toHex2 = n: pad2 (lib.toHexString n);

  # Formatters
  toHex = c: "#${toHex2 c.r}${toHex2 c.g}${toHex2 c.b}";

  # CSS 8-digit hex RGBA: rgba(RRGGBBAA)
  toHexRGBA = c: "rgba(${toHex2 c.r}${toHex2 c.g}${toHex2 c.b}${toHex2 c.a})";

  # rgba(r,g,b,aFloat)
  toRgba = c:
    let
      aFloat = (c.a or 255) / 255.0;
      aStr = builtins.toString (lib.round (aFloat * 1000) / 1000.0);
    in
      "rgba(${builtins.toString c.r}, ${builtins.toString c.g}, ${builtins.toString c.b}, ${aStr})";

  # Build theme object
  mkTheme = colors:
    lib.mapAttrs (_name: c: {
      inherit c;
      hex = toHex c;
      hexRGBA = toHexRGBA c;
      rgba = toRgba c;
    }) colors;
in
{
  _module.args.theme = mkTheme base;
}
