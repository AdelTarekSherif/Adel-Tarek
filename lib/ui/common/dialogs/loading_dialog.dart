import 'package:adel_tarek/ui/style/app.colors.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({
    super.key,
  });

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.5),
      alignment: Alignment.center,
      title: Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
