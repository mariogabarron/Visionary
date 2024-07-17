import 'package:flutter/material.dart';
import 'package:visionary/views/login_view.dart';
import 'package:visionary/views/register_view.dart';
import 'package:visionary/views/splash_screen.dart';

import '../views/tutorial_inicio/tutorial_cuatro.dart';
import '../views/tutorial_inicio/tutorial_dos.dart';
import '../views/tutorial_inicio/tutorial_tres.dart';
import '../views/tutorial_inicio/tutorial_uno.dart';

const splashScreen = '/splash-screen/';
const tutorialUno = '/tutorial-uno/';
const tutorialDos = '/tutorial-dos/';
const tutorialTres = '/tutorial-tres/';
const tutorialCuatro = '/tutorial-cuatro/';
const loginView = '/login-view/';
const registerView = '/register-view/';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return _buildFadeRoute(const SplashScreen(), settings);
    case tutorialUno:
      return _buildFadeRoute(const TutorialUno(), settings);
    case tutorialDos:
      return _buildFadeRoute(const TutorialDos(), settings);
    case tutorialTres:
      return _buildFadeRoute(const TutorialTres(), settings);
    case tutorialCuatro:
      return _buildFadeRoute(const TutorialCuatro(), settings);
    case loginView:
      return _buildFadeRoute(const LoginView(), settings);
    case registerView:
      return _buildFadeRoute(const RegisterView(), settings);
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}

PageRouteBuilder _buildFadeRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var fadeAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
    settings: settings,
  );
}
