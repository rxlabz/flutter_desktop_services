import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PluginService {
  @protected
  final OptionalMethodChannel channel;

  PluginService(String channelName)
    : channel =
  new OptionalMethodChannel(channelName, const JSONMethodCodec());
}