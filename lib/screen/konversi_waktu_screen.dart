import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonversiWaktuScreen extends StatefulWidget {
  const KonversiWaktuScreen({Key? key}) : super(key: key);

  @override
  _KonversiWaktuScreenState createState() => _KonversiWaktuScreenState();
}

class _KonversiWaktuScreenState extends State<KonversiWaktuScreen> {
  final DateTime _today = DateTime.now();
  int state = 0;

  final StreamController _wibController = StreamController();
  final StreamController _witaController = StreamController();
  final StreamController _witController = StreamController();
  final StreamController _londonController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Conversion'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(_today),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      state = 1;
                    });
                    _wibController.add(1);
                  },
                  style: ElevatedButton.styleFrom(primary: state == 0 || state == 1 ? Colors.green : Colors.blue),
                  child: const Text('WIB'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      state = 2;
                    });
                    _witaController.add(2);
                  },
                  style: ElevatedButton.styleFrom(primary: state == 2 ? Colors.green : Colors.blue),
                  child: const Text('WITA'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      state = 3;
                    });
                    _witController.add(3);
                  },
                  style: ElevatedButton.styleFrom(primary: state == 3 ? Colors.green : Colors.blue),
                  child: const Text('WIT'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      state = 4;
                    });
                    _londonController.add(4);
                  },
                  style: ElevatedButton.styleFrom(primary: state == 4 ? Colors.green : Colors.blue),
                  child: const Text('London'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: _wibController.stream,
              builder: (context, snapshot) {
                if (state == 0 || state == 1) {
                  return StreamBuilder(
                    stream: Stream.periodic(
                        const Duration(seconds: 1), (int count) => count
                    ),
                    builder: (context, snapshot) {
                      return Text(
                        DateFormat('HH:mm:ss WIB').format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            StreamBuilder(
              stream: _witaController.stream,
              builder: (context, snapshot) {
                if (state == 2) {
                  return StreamBuilder(
                    stream: Stream.periodic(
                        const Duration(seconds: 1), (int count) => count
                    ),
                    builder: (context, snapshot) {
                      return Text(
                        DateFormat('HH:mm:ss WITA').format(
                            DateTime.now().add(const Duration(hours: 1))
                        ),
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            StreamBuilder(
              stream: _witController.stream,
              builder: (context, snapshot) {
                if (state == 3) {
                  return StreamBuilder(
                    stream: Stream.periodic(
                        const Duration(seconds: 1), (int count) => count
                    ),
                    builder: (context, snapshot) {
                      return Text(
                        DateFormat('HH:mm:ss WIT').format(
                            DateTime.now().add(const Duration(hours: 2))
                        ),
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),StreamBuilder(
              stream: _londonController.stream,
              builder: (context, snapshot) {
                if (state == 4) {
                  return StreamBuilder(
                    stream: Stream.periodic(
                        const Duration(seconds: 1), (int count) => count
                    ),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('HH:mm:ss').format(
                                DateTime.now().subtract(const Duration(hours: 6))
                            ),
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            ' BST',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
