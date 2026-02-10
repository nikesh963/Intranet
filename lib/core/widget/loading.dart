
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: AppTheme.colors.primary,
            strokeWidth: 2.5,
          ),
        ),
      ),
    );
  }
}
