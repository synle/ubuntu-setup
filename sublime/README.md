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


## eslint
### Common Def
https://github.com/synle/ubuntu-setup/blob/master/misc/eslintrc

### Path for NVM Nodes
Linux : Preferences > Packages >...
```
{
    "paths": {
        "linux": [
            "/home/syle/.nvm/versions/node/v6.10.0/bin"
        ],
        "osx": [
            "/Users/syle/.nvm/versions/node/v7.4.0/bin"
        ],
        "windows": []
    }
}
```

### Dep
#### scripts
```
"lint": "./node_modules/.bin/eslint src",
```

#### devDeps
```
"eslint": "^3",
"eslint-config-airbnb": "^15.1.0",
"eslint-plugin-import": "^2.7.0",
"eslint-plugin-jsx-a11y": "^5.1.1",
"eslint-plugin-react": "^7.1.0"
```
