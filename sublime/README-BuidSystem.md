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
