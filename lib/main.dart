import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> sorular = [
    'Flutter nedir?',
    'Dart programlama dili hangi şirket tarafından geliştirilmiştir?',
    'Flutter hot reload nedir?',
  ];

  List<String> dogruCevaplar = [
    'Google tarafından geliştirilen bir UI toolkit',
    'Google',
    'Anında kodu güncelleme özelliği',
  ];

  List<String> cevaplar = List.filled(3, '');

  TextEditingController cevapController = TextEditingController();
  Color animationColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Uygulaması'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Soruları ve cevap alanlarını liste halinde göster
            Expanded(
              child: ListView.builder(
                itemCount: sorular.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(sorular[index]),
                        ),
                        // Cevap alanı
                        TextField(
                          onChanged: (value) {
                            cevaplar[index] = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Cevabınızı yazın',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            // Cevapları kontrol et butonu
            ElevatedButton(
              onPressed: () {
                cevaplariKontrolEt();
              },
              child: Text('Cevapları Kontrol Et'),
            ),
          ],
        ),
      ),
    );
  }

  void cevaplariKontrolEt() {
    // Kullanıcının girdiği cevapları ve doğru cevapları alın
    List<String> kullaniciCevaplar = cevaplar;
    List<String> dogruCevaplar = [
      'Google tarafından geliştirilen bir UI toolkit',
      'Google',
      'Anında kodu güncelleme özelliği',
    ];

    // Cevapları kontrol et
    int dogruSayisi = 0;
    for (int i = 0; i < sorular.length; i++) {
      if (kullaniciCevaplar[i].toLowerCase() ==
          dogruCevaplar[i].toLowerCase()) {
        // Cevap doğru ise doğru sayısını artır
        dogruSayisi++;
      }
    }

    // Kullanıcıya sonuçları göster
    if (dogruSayisi == sorular.length) {
      // Eğer bütün cevaplar doğru ise animasyonu oynat
      setState(() {
        animationColor = Colors.green; // Renk değişimi animasyonu
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tebrikler!'),
            content: Text('Bütün soruları doğru cevapladınız!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      // Doğru sayısı 0 değilse, sadece doğru sayısını göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cevap Kontrolü'),
            content: Text('Doğru Sayısı: $dogruSayisi / ${sorular.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }
}
