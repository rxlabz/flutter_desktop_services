import 'dart:async';
import 'dart:ui';

import 'package:flutter_desktop_services/src/plugin_service.dart';

const kColorPanelChannel = "flutter/colorpanel";
const kShowColorPanelMethod = "ColorPanel.Show";
const kHideColorPanelMethod = "ColorPanel.Hide";
const kColorPanelCallback = "ColorPanel.Callback";

class ColorPickerService extends PluginService {
  StreamController<Color> _colorSelectionStreamer =
      new StreamController<Color>();

  Stream<Color> get colorSelection$ => _colorSelectionStreamer.stream;

  ColorPickerService() : super(kColorPanelChannel) {
    channel.setMethodCallHandler((call) {
      if (call.method == kColorPanelCallback) {
        final res = call.arguments[0];
        hidePicker();

        _colorSelectionStreamer.add(
            new Color.fromARGB(255, res['red'], res['green'], res['blue']));
      }
    });
  }

  void pick() {
    channel.invokeMethod(kShowColorPanelMethod);
  }

  void hidePicker() {
    channel.invokeMethod(kHideColorPanelMethod);
  }
}
