import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionary/routes/routes.dart';
import 'package:visionary/services/objects/recordatorio.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/services/objects/visionary_user_class.dart';

class CreaTareaCuatroView extends StatefulWidget {
  final String objectiveRef;
  final String nombre;
  final int prioridad;
  final int vecesQueSeDebeDeHacer;

  const CreaTareaCuatroView(
      {super.key,
      required this.nombre,
      required this.prioridad,
      required this.vecesQueSeDebeDeHacer,
      required this.objectiveRef});

  @override
  State<CreaTareaCuatroView> createState() => _CreaTareaCuatroViewState();
}

class _CreaTareaCuatroViewState extends State<CreaTareaCuatroView>
    with SingleTickerProviderStateMixin {
  int? _selectedFrequency;
  final List<int> _selectedDays = []; // Lista para los días seleccionados
  late AnimationController _controller;
  late Animation<double> _animation;
  TipoRecordatorio _selectedPeriodicity =
      TipoRecordatorio.semanal; // Variable para periodicidad

  int _selectedNumberHour = 0;
  int _selectedNumberMinutes = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xFFFEFCEE),
        ),
        title: Text(
          'Visionary.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFEFCEE),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D97AC), Color.fromARGB(255, 207, 175, 148)],
            transform: GradientRotation(88 * pi / 180),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'Recordatorio',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  String label;
                  switch (index) {
                    case 0:
                      label = 'Recordar tarea';
                      break;
                    case 1:
                      label = 'No recordar';
                      break;
                    default:
                      label = '';
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedFrequency == index) {
                          _selectedFrequency = null;
                        } else {
                          _selectedFrequency = index;
                        }
                        if (_selectedFrequency == null) {
                          _selectedDays.clear();
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: _selectedFrequency == index
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF6D97AC),
                                  Color.fromARGB(255, 207, 175, 148)
                                ],
                              )
                            : LinearGradient(
                                colors: [Colors.grey[300]!, Colors.grey[400]!],
                              ),
                      ),
                      child: _selectedFrequency == index
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _animation.value * 2 * pi,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF6D97AC),
                                              Color.fromARGB(255, 207, 175, 148)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  label,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                label,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              _selectedFrequency == 0
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF6D97AC).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<TipoRecordatorio>(
                              value: _selectedPeriodicity,
                              onChanged: (TipoRecordatorio? newValue) {
                                setState(() {
                                  _selectedPeriodicity = newValue!;
                                });
                              },
                              items: TipoRecordatorio.values
                                  .map<DropdownMenuItem<TipoRecordatorio>>(
                                      (TipoRecordatorio value) {
                                return DropdownMenuItem<TipoRecordatorio>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                    child: Text(
                                      value.toString().split('.').last,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFFEFCEE),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Mostrar solo los días si no es "Diario"
                        _selectedPeriodicity == TipoRecordatorio.mensual ||
                                _selectedPeriodicity == TipoRecordatorio.semanal
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(7, (index) {
                                  String dayLabel;
                                  switch (index) {
                                    case 0:
                                      dayLabel = 'L';
                                      break;
                                    case 1:
                                      dayLabel = 'M';
                                      break;
                                    case 2:
                                      dayLabel = 'X';
                                      break;
                                    case 3:
                                      dayLabel = 'J';
                                      break;
                                    case 4:
                                      dayLabel = 'V';
                                      break;
                                    case 5:
                                      dayLabel = 'S';
                                      break;
                                    case 6:
                                      dayLabel = 'D';
                                      break;
                                    default:
                                      dayLabel = '';
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_selectedDays.contains(index)) {
                                          _selectedDays.remove(index);
                                        } else {
                                          _selectedDays.add(index);
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: _selectedDays.contains(index)
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xFF6D97AC),
                                                  Color.fromARGB(
                                                      255, 207, 175, 148),
                                                ],
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.grey[300]!,
                                                  Colors.grey[400]!
                                                ],
                                              ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          dayLabel,
                                          style: GoogleFonts.poppins(
                                            color: _selectedDays.contains(index)
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            : Container(),
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  _selectedFrequency == 0
                      ? ""
                      : _selectedFrequency == 1
                          ? "No te recordaremos tu tarea."
                          : "Selecciona un tipo de recordatorio si deseas que te recordemos esta tarea",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFEFCEE),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Mostrar solo la hora si "Diario" está seleccionado
              _selectedFrequency == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<int>(
                                value: _selectedNumberHour,
                                dropdownColor:
                                    const Color.fromARGB(112, 242, 241, 227),
                                borderRadius: BorderRadius.circular(40.0),
                                items: List.generate(24, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFFEFCEE),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNumberHour = value!;
                                  });
                                },
                              ),
                              const SizedBox(width: 30),
                              Text(
                                ":",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFEFCEE),
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 40),
                              DropdownButton<int>(
                                value: _selectedNumberMinutes,
                                dropdownColor:
                                    const Color.fromARGB(112, 242, 241, 227),
                                borderRadius: BorderRadius.circular(40.0),
                                items: List.generate(60, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFFEFCEE),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNumberMinutes = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const Text(""),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () async {
                  if (_selectedFrequency != 1) {
                    Tarea t = Tarea(widget.objectiveRef,
                        name: widget.nombre,
                        priority: widget.prioridad,
                        needDone: widget.vecesQueSeDebeDeHacer,
                        recordatorio: Recordatorio(
                            tipoRecordatorio: _selectedPeriodicity,
                            hora: (_selectedNumberHour, _selectedNumberMinutes),
                            codigo: "LMXJV"));
                    t.update();
                  } else {
                    VisionaryUser v = await VisionaryUser.fromLogin();
                    Tarea t = Tarea(widget.objectiveRef,
                        name: widget.nombre,
                        priority: widget.prioridad,
                        needDone: widget.vecesQueSeDebeDeHacer,
                        recordatorio: null);
                    t.print();
                    t.update();
                    v.updateObjectives();
                  }

                  Navigator.of(context).pushReplacementNamed(tareaCreadaView);
                },
                icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                color: const Color(0xFFFEFCEE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
