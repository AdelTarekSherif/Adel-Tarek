import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogOfAlert extends StatefulWidget {
  const DialogOfAlert(
      {super.key,
      required this.title,
      required this.fnc,
      required this.isSuccess,
      required this.color});
  final String title;
  final VoidCallback fnc;
  final bool isSuccess;
  final Color color;
  @override
  State<DialogOfAlert> createState() => _DialogOfAlertState();
}

class _DialogOfAlertState extends State<DialogOfAlert> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();

      widget.fnc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      content: widget.isSuccess
          ? SvgPicture.asset(
              'assets/svgs/verify-1.svg',
              colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
            )
          : SvgPicture.asset(
              'assets/svgs/error-icon.svg',
            ),
    );
  }
}
