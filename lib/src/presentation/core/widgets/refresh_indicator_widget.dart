import 'package:flutter/material.dart';

class RefreshLoadingWidget extends StatelessWidget {
  const RefreshLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 32),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(-2, 3),
            ),
          ],
        ),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
