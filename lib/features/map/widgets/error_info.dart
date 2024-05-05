import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(errorText);
  }
}