import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visionary/services/objects/tarea_class.dart';
import 'package:visionary/utilities/progressbar.dart';
import 'package:visionary/views/homepage/homepage_widgets/progreso_container.dart';

Tarea task(int done, int needed) => Tarea.desdeRef(
      'test/tasks/example',
      name: 'Example',
      priority: 1,
      needDone: needed,
      timesDone: done,
      dates: [],
    );

Widget progress(Future<List<Tarea>> future) => MaterialApp(
      home: Scaffold(body: ProgresoContainer(tareasFuture: future)),
    );

// Supply the decorative background locally: these tests never access Firebase
// or the image server.
Future<void> cacheBackground(WidgetTester tester) async {
  final image = await tester.runAsync(() async {
    final recorder = ui.PictureRecorder();
    Canvas(recorder).drawColor(Colors.white, BlendMode.src);
    final picture = recorder.endRecording();
    final image = await picture.toImage(1, 1);
    picture.dispose();
    return image;
  });
  const provider = NetworkImage(
    'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
  );
  PaintingBinding.instance.imageCache.putIfAbsent(
    provider,
    () => OneFrameImageStreamCompleter(Future.value(ImageInfo(image: image!))),
  );
}

void main() {
  testWidgets('Progress retains its values and 500 ms animation on updates',
      (tester) async {
    await cacheBackground(tester);
    await tester.pumpWidget(progress(Future.value([task(1, 2)])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(tester.widget<ProgressBar>(find.byType(ProgressBar)).porcentaje,
        closeTo(0.25, 0.01));
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('50.0%'), findsOneWidget);

    await tester.pumpWidget(progress(Future.value([task(2, 2)])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('100.0%'), findsOneWidget);

    await tester.pumpWidget(progress(Future.value([])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('0.0%'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('A pending progress load can complete after disposal',
      (tester) async {
    await cacheBackground(tester);
    final pending = Completer<List<Tarea>>();
    await tester.pumpWidget(progress(pending.future));
    await tester.pumpWidget(const SizedBox.shrink());
    pending.complete([task(1, 2)]);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
