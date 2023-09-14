import 'package:flutter/material.dart';

class HesaplamaEkrani extends StatefulWidget {
  @override
  _HesaplamaEkraniState createState() => _HesaplamaEkraniState();
}

class _HesaplamaEkraniState extends State<HesaplamaEkrani> {
  final TextEditingController boyutController = TextEditingController();
  final TextEditingController hizController = TextEditingController();
  String sonuc = '';

  // Dosya boyutu birimleri
  List<String> boyutBirimleri = ['KB', 'MB', 'GB', 'TB'];
  String secilenBoyutBirimi = 'GB';

  // İnternet hızı birimleri
  List<String> hizBirimleri = ['Kbps', 'Mbps', 'Gbps', 'Tbps'];
  String secilenHizBirimi = 'Mbps';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.teal],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.calculate,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: TextField(
                      controller: boyutController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Dosya Boyutu',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: secilenBoyutBirimi,
                    onChanged: (String? yeniBirim) {
                      if (yeniBirim != null) {
                        setState(() {
                          secilenBoyutBirimi = yeniBirim;
                        });
                      }
                    },
                    items: boyutBirimleri.map((String birim) {
                      return DropdownMenuItem<String>(
                        value: birim,
                        child: Text(birim),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: TextField(
                      controller: hizController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'İnternet Hızı',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: secilenHizBirimi,
                    onChanged: (String? yeniBirim) {
                      if (yeniBirim != null) {
                        setState(() {
                          secilenHizBirimi = yeniBirim;
                        });
                      }
                    },
                    items: hizBirimleri.map((String birim) {
                      return DropdownMenuItem<String>(
                        value: birim,
                        child: Text(birim),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String boyutText = boyutController.text;
                  String hizText = hizController.text;

                  // Kullanıcı girişlerini kontrol edin
                  if (boyutText.isEmpty || hizText.isEmpty) {
                    setState(() {
                      sonuc = 'Lütfen tüm alanları doldurun';
                    });
                    return;
                  }

                  double boyut = double.tryParse(boyutText) ?? 0.0;
                  double hiz = double.tryParse(hizText) ?? 0.0;

                  if (boyut <= 0 || hiz <= 0) {
                    setState(() {
                      sonuc = 'Dosya boyutu ve hız pozitif olmalıdır';
                    });
                    return;
                  }

                  double sure = Hesaplama.hesaplaSure(boyut, hiz, secilenBoyutBirimi, secilenHizBirimi);

                  int saniye = sure.toInt();

                  int saat = saniye ~/ 3600; // Saati hesaplayın (3600 saniye bir saat)
                  int dakika = (saniye % 3600) ~/ 60; // Dakikayı hesaplayın (60 saniye bir dakika)
                  saniye = saniye % 60; // Saniyeyi hesaplayın

                  setState(() {
                    sonuc = 'İndirme Süresi Yaklaşık olarak : $saat saat $dakika dakika $saniye saniye';

                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Text(
                    'Hesapla',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                sonuc,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Hesaplama {
  static double hesaplaSure(double boyut, double hiz, String boyutBirimi, String hizBirimi) {
    double boyutKatsayisi = 1.0;
    double hizKatsayisi = 1.0;

    if (boyutBirimi == 'KB') {
      boyutKatsayisi = 1024.0;
    } else if (boyutBirimi == 'MB') {
      boyutKatsayisi = 1024.0 * 1024.0;
    } else if (boyutBirimi == 'GB') {
      boyutKatsayisi = 1024.0 * 1024.0* 1024.0;
    }else if (boyutBirimi == 'TB') {
      boyutKatsayisi = 1024.0 * 1024.0 * 1024.0 * 1024.0;
    }

    if (hizBirimi == 'Kbps') {
      hizKatsayisi =1024.0;
    } else if (hizBirimi == 'Mbps') {
      hizKatsayisi = 1024.0* 1024.0;
    }else if (hizBirimi == 'Gbps') {
      hizKatsayisi = 1024.0* 1024.0 * 1024.0;
    } else if (hizBirimi == 'Tbps') {
      hizKatsayisi = 1024.0 * 1024.0* 1024.0* 1024.0;
    }

    // Hesaplama doğru sonucu döndürüyor
    return (boyut * boyutKatsayisi) / ((hiz * hizKatsayisi)/8);
  }
}
