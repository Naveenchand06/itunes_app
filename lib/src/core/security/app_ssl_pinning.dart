import 'dart:io';
import 'package:flutter/services.dart';

Future<SecurityContext> getSecurityContext() async {
  final bytes = await rootBundle.load('assets/security/itunes.pem');
  final securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(bytes.buffer.asInt8List());
  return securityContext;
}

Future<HttpClient> createSecureHttpClient() async {
  final securityContext = await getSecurityContext();
  final client = HttpClient(context: securityContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  return client;
}
