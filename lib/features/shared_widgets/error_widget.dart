import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.black,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Text(
          "",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}