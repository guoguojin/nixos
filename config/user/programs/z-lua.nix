{ config, ... }:

{
    programs.z-lua = {
        enable = true;
        enableAliases = true;
        options = [
            "enhanced"
            "once"
        ];
    };
}
