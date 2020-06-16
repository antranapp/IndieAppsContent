# Content for Indie Apps Showcases

This is the repository used to provide content to [the Indie Apps Showcases app](https://github.com/antranapp/IndieApps).

## Sample

Please take a look at the files in [this folder](https://github.com/antranapp/IndieAppsContent/tree/master/apps/Reference/app.antran.IndieApps) to see how you can add your app into this repository.

Some important notes:

- The icon should be **256x256** in size. Please don't add too big icons since in the worst case, users will have to clone the whole repo again into their apps.
- Please use underscore "_" instead of dot "." for folder names. In MacOS you can't have a folder ending with ".app" since MacOS will recognise this folder as an app folder automatically.

Please make sure that you follow the format carefully. In the future, I'll setup some kinds of CI to validate the pull requests automatically.


## Tooling

There is a script to validate the content. You can run the script with the following command:

```swift
swift run --package-path scripts/ContentTools ContentTools
```

## LICENSE

Do whatever you want with it, public domain.
