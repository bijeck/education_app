import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Dashboard',
          style: context.theme.textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
