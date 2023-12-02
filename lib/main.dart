import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StreamControllerExample(),
    );
  }
}

class StreamControllerExample extends StatefulWidget {
  const StreamControllerExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StreamControllerExampleState createState() => _StreamControllerExampleState();
}

class _StreamControllerExampleState extends State<StreamControllerExample> {
  late StreamController<String> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<String>();

    // Emitir nuevos elementos en el Stream cada 2 segundos
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _streamController.add("Nuevo elemento");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StreamControllerExample"),
      ),
      body: StreamBuilder<String>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          // Manejar los estados de conexión del Stream
          if (snapshot.connectionState == ConnectionState.active) {
            // El Stream está activo, mostrar los elementos
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index]);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // El Stream está esperando datos, mostrar un mensaje
            return const Text("Esperando datos...");
          } else if (snapshot.connectionState == ConnectionState.done) {
            // El Stream se ha cerrado, mostrar un mensaje
            return const Text("El Stream se ha cerrado");
          } else {
            // El Stream ha producido un error, mostrar un mensaje
            return const Text("Ha ocurrido un error");
          }
        },
      ),
    );
  }
}
