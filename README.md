<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features
A Flutter package written to add a snowfall effect to your widgets. 

## Getting started

Add this library to pubspec.yaml

Import it where you want to use it:

```dart
import 'package:snowfall/snowfall.dart';
```



## Usage

Enclose your widget with SnowfallWidget:
```dart
Scaffold(
 body: SnowfallWidget(child: Center(
// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
child: YOURWIDGET
)
```

### Optional named arguments:

```dart
 Color color // Defaults to White color;
 int numberOfSnowflakes // Defaults to 30
 int alpha // defaults to 180
)
```


## Additional information

This project is based on [Constantin Stan's work](https://medium.com/flutter-community/fluttering-snowflakes-1cf011b0d38d). 
Here is the [original work](https://github.com/Constans/fluttering-dart)

