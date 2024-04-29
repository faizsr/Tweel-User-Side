// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityStatusCubit extends Cubit<ConnectivityStatus> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  ConnectivityStatusCubit() : super(ConnectivityStatus.disconnected);

  void getConnectiviy(BuildContext context) {
    subscription = Connectivity().onConnectivityChanged.listen(
      (result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected) {
          debugPrint('Connected to Internet');
          emit(ConnectivityStatus.connected);
        }
        if (!isDeviceConnected && isAlertSet == false) {
          changeSystemThemeOnPopup(
            context: context,
            color: Theme.of(context).colorScheme.surfaceVariant,
          );
          showCupertinoDialog(
            context: context,
            builder: (ctx) => CustomAlertDialog(
              title: 'No Connection!',
              description: 'Please check your internet \nconnectivity.',
              disablePopupBtn: true,
              actionBtnTxt: 'OK',
              onTap: () async {
                isAlertSet = false;
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (isDeviceConnected) {
                  debugPrint('Connected to Internet');
                  Navigator.pop(context, 'Cancel');
                  emit(ConnectivityStatus.connected);
                }
                if (!isDeviceConnected) {
                  changeSystemThemeOnPopup(
                    context: context,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  );
                  showDialogBox(context);
                  isAlertSet = true;
                }
              },
            ),
          ).then((value) => mySystemTheme(context));
          emit(ConnectivityStatus.disconnected);
        }
      },
    );
  }

  showDialogBox(BuildContext context) {
    return CustomAlertDialog(
      title: 'No Connection!',
      description: 'Please check your internet \nconnectivity',
      disablePopupBtn: true,
      actionBtnTxt: 'OK',
      onTap: () async {
        isAlertSet = false;
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected) {
          debugPrint('Connected to Internet');
          Navigator.pop(context, 'Cancel');
        }
        if (!isDeviceConnected) {
          changeSystemThemeOnPopup(
            context: context,
            color: Theme.of(context).colorScheme.surfaceVariant,
          );
          showDialogBox(context);
          isAlertSet = true;
        }
      },
    );
  }

  void dispose() {
    subscription.cancel();
  }
}
