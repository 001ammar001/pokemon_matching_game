import 'package:flutter/material.dart';

class GateNavigationAnimation {
  const GateNavigationAnimation({required this.child});
  final Widget child;

  static Route createRoute({
    required BuildContext context,
    required Widget child,
  }) {
    const begin = Offset(0.5, 0);
    const end = Offset(0, 0);

    final tween = Tween<Offset>(begin: begin, end: end).chain(
      CurveTween(curve: Curves.ease),
    );

    const begin2 = Offset(0.5, 0);
    const end2 = Offset(1, 0);

    final tween2 = Tween<Offset>(begin: begin2, end: end2).chain(
      CurveTween(curve: Curves.ease),
    );

    bool last = false;

    final wideScreen = MediaQuery.sizeOf(context).width > 400;

    return PageRouteBuilder(
      barrierDismissible: true,
      transitionDuration: const Duration(seconds: 2),
      reverseTransitionDuration: const Duration(seconds: 2),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, _) {
        final offsetAnimation = animation.drive(tween);

        final offsetAnimation2 = animation.drive(tween2);

        if (!last && offsetAnimation.status == AnimationStatus.forward) {
          last = true;
        }

        if (last && offsetAnimation.isCompleted) {
          return child;
        }

        return Stack(
          children: [
            _buildGate(
              offsetAnimation2,
              Alignment.centerRight,
              Colors.black,
              wideScreen,
            ),
            _buildGate(
              offsetAnimation,
              Alignment.centerLeft,
              Colors.red,
              wideScreen,
            ),
            Container(
              color: Colors.transparent,
            ),
          ],
        );
      },
    );
  }

  static Widget _buildGate(
    Animation<Offset> animation,
    Alignment alignment,
    Color color,
    bool wideScreen,
  ) {
    return SlideTransition(
      position: animation,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 1,
        child: Container(
          color: color,
          alignment: alignment == Alignment.centerRight
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Image.asset(
            alignment: alignment,
            width: wideScreen ? 100 : 50,
            height: wideScreen ? 200 : 100,
            "assets/images/pokemonImages/pokeball.png",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
