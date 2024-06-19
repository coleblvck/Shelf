import 'package:flutter/material.dart';

import '../ui/theming.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: ShelfTheme.of(context).colors.primary,
    ));
  }
}
