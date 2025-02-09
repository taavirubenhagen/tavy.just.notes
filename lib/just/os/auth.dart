import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


abstract class Auth {
  
  static Future<bool> supportsAuth = LocalAuthentication().canCheckBiometrics;
  
  static Future<bool> auth(String message) async {
    if (!( await supportsAuth ) || message.isEmpty) return false;
    try {
      return await LocalAuthentication().authenticate(
        localizedReason: message,
      );
    } on PlatformException catch (e) {
      debugPrint(e.code);
      return false;
    }
  }
}