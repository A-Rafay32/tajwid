import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tajwid/core/extensions/routes_extenstion.dart';
import 'package:tajwid/core/extensions/snackbar_ext.dart';
import 'package:tajwid/core/services/loading.dart';
import 'package:tajwid/features/home/model/comparision_result_model.dart';
import 'package:tajwid/features/home/repository/home_repository.dart';
import 'package:tajwid/features/home/screens/comparision_result_screen.dart';

enum RecordingModes { started, stopped, paused, reset }

class HomeProvider extends ChangeNotifier {
  RecordingModes recordingMode = RecordingModes.stopped;

  void setRecordingMode(RecordingModes mode) {
    recordingMode = mode;
    print(recordingMode);
    notifyListeners();
  }

  void switchRecordingMode() {
    recordingMode == RecordingModes.paused
        ? recordingMode = RecordingModes.started
        : recordingMode = RecordingModes.paused;
    print(recordingMode);
    notifyListeners();
  }

  Loading loading = Loading();
  bool? isLoggedIn = false;

  void setLoading(bool isLoading) {
    loading.setLoading(isLoading);
    notifyListeners();
  }

  ComparisionResultModel? comparisionResult;
  void compareAccents({
    required Map<String, File> files,
    required BuildContext context,
  }) async {
    setLoading(true);
    final response = await HomeRepository().compare(files: files);
    response.fold(
      (left) {
        context.showSnackBar(left.message);
        context.pop();
        setLoading(false);
      },

      (right) {
        comparisionResult = right;
        print("Comparision Result :  ${comparisionResult.toString()}");
        notifyListeners();
        context.pop();
        context.push(ComparisionResultScreen());
      },
    );
  }
}
