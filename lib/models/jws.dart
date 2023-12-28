import 'dart:convert';
import 'package:crypto/crypto.dart';

class JwsGenerator {
  final String algorithm;
  final Map<String, dynamic> payload;
  final String secretKey;

  JwsGenerator({
    required this.algorithm,
    required this.payload,
    required this.secretKey,
  });

  
}
