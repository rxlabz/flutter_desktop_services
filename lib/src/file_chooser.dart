import 'dart:async';

import 'package:flutter_desktop_services/src/plugin_service.dart';

const kFileChooserChannel = 'flutter/filechooser';
const kShowOpenPanelMethod = "FileChooser.Show.Open";
const kShowSavePanelMethod = "FileChooser.Show.Save";
const kFileChooserCallbackMethod = "FileChooser.Callback";

const kAllowedFileTypesKey = "allowedFileTypes";
const kAllowsMultipleSelectionKey = "allowsMultipleSelection";
const kCanChooseDirectoriesKey = "canChooseDirectories";
const kInitialDirectoryKey = "initialDirectory";
const kPlatformClientIDKey = "clientID";

class FilechooserService extends PluginService {
  final String clientID;

  StreamController<List<String>> _pathSelectionStreamer =
      new StreamController<List<String>>();

  Stream<List<String>> get pathSelection$ => _pathSelectionStreamer.stream;

  FilechooserService({String clientID})
      : this.clientID = clientID,
        super(kFileChooserChannel) {
    channel.setMethodCallHandler((call) {
      if (call.method == kFileChooserCallbackMethod) {
        final res = call.arguments;
        if (res['result'] == 1) {
          final List<String> paths = res['paths'];
          _pathSelectionStreamer.add(paths);
        }
      }
    });
  }

  void open({
    bool allowsDirectories: false,
    String initialPath = '/',
    bool allowsMultipleSelection: false,
    List<String> allowedFileTypes: const <String>[],
  }) {
    final args = {
      kPlatformClientIDKey: clientID,
      kCanChooseDirectoriesKey: allowsDirectories,
      kInitialDirectoryKey: initialPath,
      kAllowsMultipleSelectionKey: allowsMultipleSelection,
    };
    if (allowedFileTypes.length > 0) {
      args[kAllowedFileTypesKey] = allowedFileTypes;
    }
    channel.invokeMethod(kShowOpenPanelMethod, args);
  }

  void save(
      {String initialPath: '/',
      List<String> allowedFileTypes: const <String>[]}) {
    final args = <String, dynamic>{
      kPlatformClientIDKey: clientID,
      kInitialDirectoryKey: initialPath,
    };
    if (allowedFileTypes.length > 0) {
      args[kAllowedFileTypesKey] = allowedFileTypes;
    }
    channel.invokeMethod(kShowSavePanelMethod, args);
  }

  void stop() {
    _pathSelectionStreamer.close();
  }
}
