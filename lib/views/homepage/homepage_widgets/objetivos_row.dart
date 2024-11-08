import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';

class ObjetivosRow extends StatefulWidget {
  final VoidCallback
      onEmptyObjectives; // Callback para notificar cuando no haya objetivos

  const ObjetivosRow({super.key, required this.onEmptyObjectives});

  @override
  State<ObjetivosRow> createState() => _ObjetivosRowState();
}

class _ObjetivosRowState extends State<ObjetivosRow> {
  late TextEditingController controller;
  late Future<VisionaryUser> _futureUser;
  var selectedObjetivoRef;
  int? selectedObjetivoIndex;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    reloadData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void reloadData() {
    setState(() {
      _futureUser = VisionaryUser.fromLogin().then((user) {
        if (user.objectives.isNotEmpty) {
          selectedObjetivoIndex = 0;
          selectedObjetivoRef = user.objectives[0].$2;
        } else {
          widget.onEmptyObjectives(); // Llama al callback si no hay objetivos
        }
        return user;
      });
    });
  }

  // Modifica la función que elimina el objetivo para llamar a `onEmptyObjectives` si es el último objetivo
  void deleteObjective(Objetivo objetivo) async {
    await objetivo.deleteObjective();
    VisionaryUser u = await VisionaryUser.fromLogin();
    u.updateObjectives();

    if (u.objectives.isEmpty) {
      widget.onEmptyObjectives(); // Llama al callback si no hay más objetivos
    } else {
      reloadData(); // De lo contrario, recarga los datos
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VisionaryUser>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFEFCEE)),
              strokeWidth: 3.0,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          final objectives = user.objectives;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: ClipRect(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.1, 0.9, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < objectives.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedObjetivoIndex = i;
                                    selectedObjetivoRef = objectives[i].$2;
                                  });
                                },
                                onLongPress: () async {
                                  Objetivo obj =
                                      await Objetivo.fromRef(objectives[i].$2);
                                  if (context.mounted) {
                                    showAlertBottomEditarObjetivo(
                                        context, obj, controller, reloadData);
                                    reloadData();
                                  }
                                },
                                child: Opacity(
                                  opacity: selectedObjetivoRef == null ||
                                          objectives[i].$2 ==
                                              selectedObjetivoRef
                                      ? 1.0 // Objetivo seleccionado o sin selección
                                      : 0.4, // Objetivo no seleccionado
                                  child: Text(
                                    objectives[i].$1,
                                    style: TextStyle(
                                      color: objectives[i].$2 ==
                                              selectedObjetivoRef
                                          ? const Color.fromARGB(201, 254, 252,
                                              238) // Color resaltado para seleccionado
                                          : const Color.fromARGB(201, 254, 252,
                                              238), // Color normal
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () async {
                          if (context.mounted) {
                            Navigator.of(context)
                                .pushReplacementNamed(crearObjetivoUno);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFEFCEE).withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text('Añadir objetivo',
                            style: GoogleFonts.poppins(
                                color: const Color(0xFFFEFCEE),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Text('ERROR AL CARGAR');
        }
      },
    );
  }
}

void showAlertBottomEditarObjetivo(BuildContext context, Objetivo objetivo,
    TextEditingController controller, Function reloadData) {
  String nombreObjetivo = objetivo.name;
  controller.text = objetivo.name;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: const Color(0xFFFEFCEE),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Editar objetivo "$nombreObjetivo"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: const Color(0xFF26272C),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Cambiar nombre al objetivo $nombreObjetivo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: const Color.fromARGB(183, 40, 40, 40),
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                    label: "",
                    inputType: TextInputType.name,
                    hintText: "Escribe el nuevo nombre",
                    maxWords: 20,
                    controller: controller),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    VisionaryUser u = await VisionaryUser.fromLogin();
                    objetivo.edit(controller.text, objetivo.motive);
                    u.updateObjectives();
                    if (context.mounted) {
                      Navigator.of(context).pop(); // Cerrar el modal
                    }
                  },
                  child: Text(
                    'Guardar',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: Divider(color: Colors.black38),
                ),
                const SizedBox(height: 25),
                Text(
                  'Eliminar objetivo $nombreObjetivo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: const Color.fromARGB(183, 40, 40, 40),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancelar',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D97AC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        objetivo.deleteObjective();
                        VisionaryUser u = await VisionaryUser.fromLogin();
                        u.updateObjectives();
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Cerrar el modal
                        }
                      },
                      child: Text(
                        'Borrar',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      );
    },
  ).then((_) {
    reloadData();
  });
}

Widget _buildInputField(
    {required String label,
    String? hintText,
    bool obscureText = false,
    required TextInputType inputType,
    int? maxWords,
    required TextEditingController controller}) {
  TextInputType keyboardType = TextInputType.text;

  if (inputType == TextInputType.emailAddress) {
    keyboardType = TextInputType.emailAddress;
  } else if (inputType == TextInputType.visiblePassword) {
    keyboardType = TextInputType.visiblePassword;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(66, 254, 252, 238),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: TextField(
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
              color: const Color(0xFFFEFCEE),
              fontWeight: FontWeight.bold,
            ),
            maxLength: maxWords,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(66, 76, 76, 76),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: const Color(0xFFFEFCEE),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
