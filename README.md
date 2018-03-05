# Flutter Desktop plugins services

services for [flutter-desktop-embedding](https://github.com/google/flutter-desktop-embedding) plugins on desktop

## FileChooserService

- open
  
```dart
void open({
    bool allowsDirectories: false,
    String initialPath = '/',
    bool allowsMultipleSelection: false,
    List<String> allowedFileTypes: const <String>[],
  }){//..}
```

- save
  
```dart
void save(
      {String initialPath: '/',
      List<String> allowedFileTypes: const <String>[]}){//..}
```

  - Stream<List<String>> pathSelection$
  
## ColorpickerService

- pick()
- hidePicker()