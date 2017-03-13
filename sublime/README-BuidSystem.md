http://sublimetext.info/docs/en/reference/build_systems.html

https://addyosmani.com/blog/custom-sublime-text-build-systems-for-popular-tools-and-languages/

Build Node JS
```
{
    "cmd": ["node", "$file"],
    "working_dir": "$file_path",
    "selector" : "source.js",
    "windows" : {
        "shell": true
    }
}
```



`ln -s /Users/sle/.nvm/versions/node/v0.12.15/bin/node /usr/local/bin/node`

```
{
    "cmd": ["/usr/local/bin/node", "$file"],
    "working_dir": "$file_path",
    "selector" : "source.js",
    "windows" : {
        "shell": true
    }
}
```
