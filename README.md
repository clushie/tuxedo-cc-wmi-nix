### Tuxedo-CC-WMI-Nix

Package for the wmi drivers for tuxedo notebooks.

Tested with the tuxedo InfityBook Pro 15 v4.

Installs the [kernel module](https://github.com/tuxedocomputers/tuxedo-cc-wmi).

#### Usage

Clone this repo, import the module in your `configuration.nix`, and use it.

```nix
    imports = 
    [ 
       /path/where/this/is/cloned/modules/tuxedo-cc-wmi.nix
    ];

    tuxedo-cc-wmi.enable = true;
```

##### TODOs

* clean this repo up a bit more
* figure out if this is actually helping with anything :shrug:
