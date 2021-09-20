import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes/app.dart';
import 'package:notes/desktop_app.dart';

void main(List<String> args) async {
  if (Platform.isWindows || Platform.isLinux) {
    runApp(const DesktopApp());
  } else if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final authRepo = AuthenticationRepository();
    await authRepo.user.first;
    runApp(NotesApp(authenticationRepository: authRepo));
  }
}
