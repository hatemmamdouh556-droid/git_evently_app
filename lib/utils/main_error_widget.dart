import 'package:evently_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage ;
  const MainErrorWidget({super.key,required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
