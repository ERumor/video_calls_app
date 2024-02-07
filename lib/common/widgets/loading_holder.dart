import 'package:flutter/material.dart';

class LoadingHolder extends StatelessWidget {
  const LoadingHolder({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Center(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
