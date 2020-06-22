# Content for Indie Apps Showcases

This is the repository used to provide content to [the Indie Apps Showcases app](https://github.com/antranapp/IndieApps).

## Steps to add content

- Use the following template as your starting point:
````
version: 2
id: ID of the app
name: Name of the app
shortDescription: A short descripton
description: |- 
  Some longer description
links:
  - type: homepage
    value: https://myhomepage.com
  - type: testflight
    value: https://testflight.apple.com/join/xxxxx
  - type: appstore
    value: https://apps.apple.com/app/idxxx
  - type: sourcecode
previews:
  - type: iOS
    value: 
      - https://to.a.screenshot1.png
      - https://to.a.screenshot2.png
      - https://to.a.screenshot3.png
releaseNotes:
  - version: x.x.x
    note: |- 
      * Some cool bug fixes
      * Some cool new features
createdAt: YYYY-mm-DD
updatedAt: YYYY-mm-DD
````

- Create a folder in an appropriate category for your app, named as your appID (use "_" instead of ".").
- Add the `app.yml` and `icon.png` to this folder.
- Create an PR to `master`.

## Sample

Please take a look at the files in [this folder](https://github.com/antranapp/IndieAppsContent/tree/master/apps/Reference/app_antran_IndieApps) to see how you can add your app into this repository.

## Important notes:

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
