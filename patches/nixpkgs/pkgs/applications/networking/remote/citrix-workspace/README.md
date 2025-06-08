# Solution

This has three patches to support new Citrix version 25.03.0.66

1. update sources.nix and add this to the supportedVersions

    # New
    "25.03.0" = {
      major = "25";
      minor = "03";
      patch = "0";
      x64hash = "052zibykhig9091xl76z2x9vn4f74w5q8i9frlpc473pvfplsczk";
      x86hash = "";
      x64suffix = "66";
      x86suffix = "";
      homepage = "https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html";
    };

2. add the new dependency in generic.nix

add to the top level of the file

  sane-backends,

3. use the new dependency in buildInputs in generic.nix

add the sane-backends in the buildInputs list
