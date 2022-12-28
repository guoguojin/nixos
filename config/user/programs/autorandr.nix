{ config, pkgs, nixpkgs, ... }:

{
  programs.autorandr = {
    enable = true;
    profiles = {
      "rogue-undocked" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
        };
        config = {
          "eDP-1" = {
            enable = true;
            mode = "2256x1504";
            position = "0x0";
            primary = true;
            rate = "60.00";
          };
        };
      };
      "rogue-docked" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
          "DVI-I-1-1" = "00ffffffffffff0010acef404d353934221a0103803e2278ea08a5a2574fa2280f5054a54b00d1c0a94081808100714f01010101010104740030f2705a80b0588a006d552100001e000000ff004a34324d433638513439354d0a000000fc0044454c4c205332383137510a20000000fd001d4b1f8c1e000a202020202020014202032bf150101f200514041312110302161507060123090707830100006d030c001000003c20006001020304740030f2705a80b0588a006d552100001e565e00a0a0a02950302035006d552100001a4d6c80a070703e8030203a006d552100001a114400a080002550302036006d552100001a00000000000000000000000032";
          "DVI-I-2-2" = "00ffffffffffff0010acef404d383734221a0103803e2278ea08a5a2574fa2280f5054a54b00d1c0a94081808100714fe1000101010108e80030f2705a80b0588a006d552100001e000000ff004a34324d433638513437384d0a000000fc0044454c4c205332383137510a20000000fd001d4b1f8c3c000a20202020202001cb02033bf15561605f5e5d101f200514041312110302161507060123090707830100006d030c001000003c20006001020367d85dc40178c003e20f0304740030f2705a80b0588a006d552100001e4d6c80a070703e8030203a006d552100001a565e00a0a0a02950302035006d552100001a00000000000000000000000000001f";
        };
        config = {
          "eDP-1" = {
            enable = true;
            mode = "2256x1504";
            position = "0x0";
            rate = "60.00";
          };
          "DVI-I-2-2" = {
            enable = true;
            mode = "3840x2160";
            position = "2256x0";
            primary = true;
            rate = "60.00";
          };
          "DVI-I-1-1" = {
            enable = true;
            mode = "3840x2160";
            position = "6096x0";
            rate = "60.00";
          };
        };
      };
      "songbird-undocked-intel" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff000e6f021400000000001e0104b51e137802ee95a3544c99260f505400000001010101010101010101010101010101b6c840a0b0084e70302036002ebc10000018000000000000000000000000000000000018000000fe0043534f542054330a2020202020000000fe004d4e453030375a41312d310a2000d3";
        };
        config = {
          "eDP-1" = {
            enable = true;
            mode = "2880x1800";
            position = "0x0";
            primary = true;
            rate = "90.00";
          };
        };
      };
      "songbird-docked-intel" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff000e6f021400000000001e0104b51e137802ee95a3544c99260f505400000001010101010101010101010101010101b6c840a0b0084e70302036002ebc10000018000000000000000000000000000000000018000000fe0043534f542054330a2020202020000000fe004d4e453030375a41312d310a2000d3";
          "DVI-I-2-1" = "00ffffffffffff0010acef404d353934221a0103803e2278ea08a5a2574fa2280f5054a54b00d1c0a94081808100714fe1000101010108e80030f2705a80b0588a006d552100001e000000ff004a34324d433638513439354d0a000000fc0044454c4c205332383137510a20000000fd001d4b1f8c3c000a20202020202001cd02033bf15561605f5e5d101f200514041312110302161507060123090707830100006d030c001000003c20006001020367d85dc40178c003e20f0304740030f2705a80b0588a006d552100001e4d6c80a070703e8030203a006d552100001a565e00a0a0a02950302035006d552100001a00000000000000000000000000001f";
          "DVI-I-3-2" = "00ffffffffffff0010acef404d383734221a0103803e2278ea08a5a2574fa2280f5054a54b00d1c0a94081808100714fe1000101010108e80030f2705a80b0588a006d552100001e000000ff004a34324d433638513437384d0a000000fc0044454c4c205332383137510a20000000fd001d4b1f8c3c000a20202020202001cb02033bf15561605f5e5d101f200514041312110302161507060123090707830100006d030c001000003c20006001020367d85dc40178c003e20f0304740030f2705a80b0588a006d552100001e4d6c80a070703e8030203a006d552100001a565e00a0a0a02950302035006d552100001a00000000000000000000000000001f";
        };
        config = {
          "eDP-1" = {
            enable = true;
            mode = "2880x1800";
            position = "0x0";
            rate = "90.00";
          };
          "DVI-I-3-2" = {
            enable = true;
            mode = "3840x2160";
            position = "2880x0";
            primary = true;
            rate = "60.00";
          };
          "DVI-I-2-1" = {
            enable = true;
            mode = "3840x2160";
            position = "6720x0";
            rate = "60.00";
          };
        };
      };
      "nightshade" = {
        fingerprint = {
          "DP-4" = "00ffffffffffff0010acee404d383734221a0104b53e22783a08a5a2574fa2280f5054a54b00d1c0a94081808100714f0101010101014dd000a0f0703e80302035006d552100001a000000ff004a34324d433638513437384d0a000000fc0044454c4c205332383137510a20000000fd001d4b1f8c36010a20202020202001bc02031df150101f20051404131211030216150706012309070783010000a36600a0f0701f80302035006d552100001a565e00a0a0a02950302035006d552100001a4d6c80a070703e8030203a006d552100001a114400a080002550302036006d552100001a0000000000000000000000000000000000000000000000000000db";
          "DP-7" = "00ffffffffffff0010acee404d353934221a0104b53e22783a08a5a2574fa2280f5054a54b00d1c0a94081808100714f0101010101014dd000a0f0703e80302035006d552100001a000000ff004a34324d433638513439354d0a000000fc0044454c4c205332383137510a20000000fd001d4b1f8c36010a20202020202001be02031df150101f20051404131211030216150706012309070783010000a36600a0f0701f80302035006d552100001a565e00a0a0a02950302035006d552100001a4d6c80a070703e8030203a006d552100001a114400a080002550302036006d552100001a0000000000000000000000000000000000000000000000000000db";
        };
        config = {
          "DP-4" = {
            enable = true;
            mode = "3840x2160";
            position = "0x0";
            primary = true;
            rate = "60.00";
          };
          "DP-7" = {
            enable = true;
            mode = "3840x2160";
            position = "3840x0";
            rate = "60.00";
          };
        };
      };
    };
  };
}