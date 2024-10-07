import 'package:flutter/material.dart';
import 'package:visionary/views/homepage/crearobjetivos_views/crearobjetivodos_view.dart';
import 'package:visionary/views/homepage/crearobjetivos_views/crearobjetivouno_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareados_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareascuatro_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareatres_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareauno_view.dart';
import 'package:visionary/views/homepage/creartareas_views/tareacreada_view.dart';
import 'package:visionary/views/homepage/homepage_view.dart';
import 'package:visionary/views/auth_views/login_view.dart';
import 'package:visionary/views/auth_views/register_view.dart';
import 'package:visionary/views/homepage/homepagevacio_view.dart';
import 'package:visionary/views/settings/ajustes_cuenta.dart';

import '../views/tutorial_inicio/tutorial_cuatro.dart';
import '../views/tutorial_inicio/tutorial_dos.dart';
import '../views/tutorial_inicio/tutorial_tres.dart';
import '../views/tutorial_inicio/tutorial_uno.dart';

const tutorialUno = '/tutorial-uno/';
const tutorialDos = '/tutorial-dos/';
const tutorialTres = '/tutorial-tres/';
const tutorialCuatro = '/tutorial-cuatro/';
const loginView = '/login-view/';
const registerView = '/register-view/';
const ajustesCuenta = '/ajustes-cuenta/';
const homepageView = '/homepage-view/';
const crearObjetivoUno = '/crearobjetivouno-view/';
const crearObjetivoDos = '/crearobjetivodos-view';
const homepageVacioView = '/homepagevacio-view';
const crearTareaUno = 'creartareauno-view';
const crearTareaDos = 'creartareados-view';
const crearTareaTres = 'creartareatres-view';
const crearTareaCuatro = 'creartareacuatro-view';
const tareaCreadaView = 'tareacreada-view';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
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
    case ajustesCuenta:
      return _buildFadeRoute(const AjustesCuenta(), settings);
    case homepageView:
      return _buildFadeRoute(const HomepageView(), settings);
    case crearObjetivoUno:
      return _buildFadeRoute(const CrearObjetivoUnoView(), settings);
    case crearObjetivoDos:
      return _buildFadeRoute(const CrearObjetivoDosView(), settings);
    case homepageVacioView:
      return _buildFadeRoute(const HomepageVacioView(), settings);
    case crearTareaUno:
      return _buildFadeRoute(const CreaTareaUnoView(), settings);
    case crearTareaDos:
      return _buildFadeRoute(const CreaTareaDosView(), settings);
    case crearTareaTres:
      return _buildFadeRoute(const CreaTareaTresView(), settings);
    case crearTareaCuatro:
      return _buildFadeRoute(const CreaTareaCuatroView(), settings);
    case tareaCreadaView:
      return _buildFadeRoute(const TareaCreadaView(), settings);
    default:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
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
