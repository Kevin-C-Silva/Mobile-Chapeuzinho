import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_chapeuzinho/filme.dart';
import 'package:trabalho_chapeuzinho/curiosidades.dart';
import 'package:trabalho_chapeuzinho/elenco.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PagInicial(),
    );
  }
}

class PagInicial extends StatefulWidget {
  const PagInicial({super.key});

  @override
  State<PagInicial> createState() => _PagInicialState();
}

class _PagInicialState extends State<PagInicial> {
  List<dynamic> titulos = [];
  List<dynamic> botoes = [];


  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/midias.json');

    final List<dynamic> data = json.decode(response);

    setState(() {
      titulos = data[0]['conteudo'][0]['titulos'];
      botoes = data[0]['conteudo'][0]['botoes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (titulos.isEmpty || botoes.isEmpty) {
      return Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        leading: Icon(Icons.movie, color: Colors.white),
        title: Text(
          titulos[0],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade800,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[500],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 18,
                    ),
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Filme()),
                    );
                  },
                  child: Text(
                    botoes[0],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[500],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 18,
                    ),
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Elenco()),
                    );
                  },
                  child: Text(
                    botoes[1],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[500],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 18,
                    ),
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Curiosidades(),
                      ),
                    );
                  },
                  child: Text(
                    botoes[2],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
