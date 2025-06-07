import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/objetivo_class.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObjetivosRow extends StatefulWidget {
  final Function(String, int)
      onObjectiveSelected; // Callback para pasar el nombre del objetivo seleccionado
  final VoidCallback onObjectiveDeleted; // Callback para actualizar HomePage
  final int? selectedObjectiveIndex;

  const ObjetivosRow(
      {super.key,
      required this.onObjectiveSelected,
      required this.onObjectiveDeleted,
      required this.selectedObjectiveIndex});

  @override
  State<ObjetivosRow> createState() => _ObjetivosRowState();
}

class _ObjetivosRowState extends State<ObjetivosRow> {
  late Future<VisionaryUser> _futureUser;
  var selectedObjetivoRef;
  int? selectedObjetivoIndex;

  @override
  void initState() {
    super.initState();
    selectedObjetivoIndex = widget.selectedObjectiveIndex;

    _futureUser = VisionaryUser.fromLogin();
    reloadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reloadData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedIndex = prefs.getInt('selectedObjetivoIndex');

    setState(() {
      _futureUser = VisionaryUser.fromLogin().then((user) {
        if (user.objectives.isNotEmpty) {
          // Si hay un índice almacenado y es válido, úsalo
          if (storedIndex != null && storedIndex < user.objectives.length) {
            selectedObjetivoIndex = storedIndex;
            selectedObjetivoRef = user.objectives[storedIndex].$2.key;
          } else {
            // Si no es válido, selecciona el primer objetivo
            selectedObjetivoIndex = 0;
            selectedObjetivoRef = user.objectives[0].$2.key;
            prefs.setInt(
                'selectedObjetivoIndex', 0); // Actualiza el índice almacenado
          }
          widget.onObjectiveSelected(
              user.objectives[selectedObjetivoIndex!].$2.ref.path,
              selectedObjetivoIndex!);
        } else {
          // Si no hay objetivos, limpia el índice almacenado y llama al callback
          selectedObjetivoIndex = 0;
          selectedObjetivoRef = null;
          prefs.remove('selectedObjetivoIndex');
          widget.onObjectiveDeleted();
        }
        if (selectedObjetivoRef == null) {
          selectedObjetivoIndex = 0;
        }
        return user;
      });
    });
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
                    stops: [0.0, 0.03, 0.97, 1.0], // Más pegado a los bordes
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < objectives.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    selectedObjetivoIndex = i;
                                    selectedObjetivoRef = objectives[i].$2;
                                  });
                                  await prefs.setInt('selectedObjetivoIndex',
                                      i); // Guarda el índice seleccionado
                                  widget.onObjectiveSelected(
                                      objectives[i].$2.ref.path, i);
                                },
                                onLongPress: () async {
                                  Objetivo obj =
                                      await Objetivo.fromRef(objectives[i].$2);
                                  final localController =
                                      TextEditingController(text: obj.name);

                                  if (context.mounted) {
                                    showAlertBottomEditarObjetivo(
                                        context,
                                        obj,
                                        localController,
                                        reloadData,
                                        widget.onObjectiveDeleted);
                                    reloadData();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: selectedObjetivoIndex == i
                                        ? const Color(0xFFFEFCEE)
                                            .withOpacity(0.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Opacity(
                                    opacity:
                                        selectedObjetivoIndex == i ? 1.0 : 0.5,
                                    child: Text(
                                      objectives[i].$1,
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 254, 252, 238),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () async {
                          if (context.mounted) {
                            Navigator.of(context)
                                .pushReplacementNamed(crearObjetivoUno);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Añadir',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFEFCEE),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                                width:
                                    4), // Ajusta este valor según lo que busques
                            const Icon(
                              CupertinoIcons.plus_circle_fill,
                              color: Color(0xFFFEFCEE),
                              size: 15,
                            ),
                          ],
                        ),
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

void showAlertBottomEditarObjetivo(
    BuildContext context,
    Objetivo objetivo,
    TextEditingController controller,
    Function reloadData,
    VoidCallback onObjectiveDeleted) {
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
                    maxWords: 16,
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
                    String nuevoNombre = controller.text.trim();
                    nuevoNombre = nuevoNombre.replaceAll(RegExp(r'\s+'),
                        ' '); // Reemplazar múltiples espacios por uno solo

                    // Verificar si el nuevo nombre no está vacío
                    if (nuevoNombre.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'El nombre de la tarea no puede estar vacío.',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 106, 106, 106),
                        ),
                      );
                      return;
                    }
                    objetivo.edit(nuevoNombre, objetivo.motive);
                    u.updateObjectives();

                    if (context.mounted) {
                      Navigator.of(context).pop(); // Cerrar el modal
                    }
                    onObjectiveDeleted();
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

                        reloadData();

                        final prefs = await SharedPreferences.getInstance();
                        prefs.remove('selectedObjetivoIndex');
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Cerrar el modal
                        }

                        onObjectiveDeleted();
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
