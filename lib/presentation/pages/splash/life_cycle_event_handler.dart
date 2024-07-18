import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/services/socket/socket_services.dart';

final lifecycleEventHandler = LifecycleEventHandler._();

class LifecycleEventHandler extends WidgetsBindingObserver {
  var inBackground = true;

  LifecycleEventHandler._();

  init() {
    WidgetsBinding.instance.addObserver(lifecycleEventHandler);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        log('App State: Resumed');
        break;
      case AppLifecycleState.inactive:
        log('App State: Inactive');
      case AppLifecycleState.paused:
        log('App State: Paused');
      case AppLifecycleState.detached:
        SocketServices().disconnectSocket();
        log('App State: Detached');
        break;
      case AppLifecycleState.hidden:
        log('App State: Hidden');
    }
  }
}
