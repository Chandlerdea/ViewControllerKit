# ViewControllerKit
`ViewControllerKit` is a tool I use for creating boilerplate `UIViewController` subclasses. There are two ways of using this tool: the command line, and Xcode templates

## Xcode templates
Once you clone the repo, just copy and paste the `.xctemplate` directories into `path-to-xcode/Contents/Developer/Library/Xcode/Templates/File Temples/Source`, and that's it!

## Command line
Once you clone the repo, you can use run the executable from the command line using the following command:
```
swift run --package-path ~/Development/Personal/GitHub/ViewControllerKit ViewControllerKit $1 $2 $3 $4

$1 = The view controller's name, ex: PersonViewController
$2 = The location of the files to be written, ex: .
$3 & $4 = An optional --type flag, possible values are the following: view | table | collection
If you do not pass the --type flag, a regular view controller is created by default
```
