import 'package:flutter/material.dart';
import 'downloadSpeedPage.dart';

void main() {
  runApp(GirisEkrani());
}

class GirisEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug yazısını kaldırın
      home: Scaffold(
        appBar: null, // App bar'ı kaldırın
        body: GirisForm(),
      ),
    );
  }
}

class GirisForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.teal], // Arka planın renk geçişi
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.calculate, // İstenilen bir icon
              size: 80,
              color: Colors.white, // Icon rengi
            ),
            Text(
              'Download Speed Calculation',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white, // Metin rengi
              ),
            ),
            SizedBox(height: 20), // Boşluk eklemek için
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HesaplamaEkrani()),
                );
                // Hesaplama işlemleri burada yapılabilir.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent, // Saydam arka plan
                elevation: 0, // Gölgeyi kaldırın
                padding: EdgeInsets.all(20), // Düğme içeriği yükseklik ve genişlik
              ),
              child: Text(
                'Calculation',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white, // Düğme metin rengi
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

