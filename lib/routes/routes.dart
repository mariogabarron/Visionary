import 'package:flutter/material.dart';
import 'package:visionary/views/homepage/crearobjetivos_views/crearobjetivouno_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareados_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareascuatro_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareatres_view.dart';
import 'package:visionary/views/homepage/creartareas_views/creartareauno_view.dart';
import 'package:visionary/views/homepage/creartareas_views/tareacreada_view.dart';
import 'package:visionary/views/homepage/homepage_view.dart';
import 'package:visionary/views/auth_views/login_view.dart';
import 'package:visionary/views/auth_views/register_view.dart';
import 'package:visionary/views/settings/ajustes_cuenta.dart';

import '../views/tutorial_inicio/tutorial_inicio.dart';

const tutorialInicio = '/tutorial-inicio/';
const loginView = '/login-view/';
const registerView = '/register-view/';
const ajustesCuenta = '/ajustes-cuenta/';
const homepageView = '/homepage-view/';
const crearObjetivoUno = '/crearobjetivouno-view/';
//const crearObjetivoDos = '/crearobjetivodos-view';
const homepageVacioView = '/homepagevacio-view';
const crearTareaUno = 'creartareauno-view';
const crearTareaDos = 'creartareados-view';
const crearTareaTres = 'creartareatres-view';
const crearTareaCuatro = 'creartareacuatro-view';
const tareaCreadaView = 'tareacreada-view';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case tutorialInicio:
      return buildFadeRoute(const TutorialInicio());
    case loginView:
      return buildFadeRoute(const LoginView());
    case registerView:
      return buildFadeRoute(const RegisterView());
    case ajustesCuenta:
      return buildFadeRoute(const AjustesCuenta());
    case homepageView:
      return buildFadeRoute(const HomepageView());
    case crearObjetivoUno:
      return buildFadeRoute(const CrearObjetivoUnoView());
    case crearTareaUno:
      return buildFadeRoute(const CreaTareaUnoView());
    case crearTareaDos:
      return buildFadeRoute(const CreaTareaDosView());
    case crearTareaTres:
      return buildFadeRoute(const CreaTareaTresView());
    case crearTareaCuatro:
      return buildFadeRoute(const CreaTareaCuatroView());
    case tareaCreadaView:
      return buildFadeRoute(const TareaCreadaView());
    default:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
        settings: settings,
      );
  }
}

PageRouteBuilder buildFadeRoute(Widget page) {
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
  );
}
