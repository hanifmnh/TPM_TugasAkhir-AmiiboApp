import 'package:flutter/material.dart';

class KesanPesanScreen extends StatelessWidget {
  const KesanPesanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testimonial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Kesan :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              'Terima kasih telah memberi tugas yang lumayan banyak pak'
            ),
            SizedBox(height: 30.0),
            Text(
              'Pesan :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              'Semangat terus untuk mengajarnya pak'
            ),
          ],
        ),
      ),
    );
  }
}
