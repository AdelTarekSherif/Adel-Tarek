import 'package:flutter/material.dart';

class UploadOrScanDocumentArg {
  final String title;
  final String? status;
  final VoidCallback onUploadDocument;

  UploadOrScanDocumentArg({
    required this.title,
    this.status,
    required this.onUploadDocument,
  });
}
