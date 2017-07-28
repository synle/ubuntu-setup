# Sublime
## find config
`*.scss,*.html,*.js,*.less`


## plugins
```
cat ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
```


## Build System
http://sublimetext.info/docs/en/reference/build_systems.html

https://addyosmani.com/blog/custom-sublime-text-build-systems-for-popular-tools-and-languages/

```
    {
        "cmd": ["/usr/local/bin/node", "$file"],
        "working_dir": "$file_path",
        "selector" : "source.js",
        "windows" : {
            "cmd": ["node", "$file"]
        }
    }
```


## DPI Scaling
```
"dpi_scale": 1.5,
```


## Sample Linter Config
### Mac
```
"paths": {
    "linux": [],
    "osx": [
        "/Users/syle/.nvm/versions/node/v7.4.0/bin"
    ],
    "windows": []
},
```
