import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_chapeuzinho/secao.dart';

class Filme extends StatefulWidget {
  const Filme({super.key});

  @override
  State<Filme> createState() => _FilmeState();
}

class _FilmeState extends State<Filme> {
  List<dynamic> imagens = [];
  List<dynamic> titulos = [];
  List<dynamic> legendas = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/midias.json');

    final List<dynamic> data = json.decode(response);

    setState(() {
      imagens = data[0]['imagens'];
      titulos = data[0]['conteudo'][0]['titulos'];
      legendas = data[0]['conteudo'][0]['textos'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (titulos.isEmpty || legendas.isEmpty || imagens.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),

      appBar: AppBar(
        title: Text(
          titulos[0],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade800,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da página
            Center(
              child: Text(
                titulos[1],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            Center(
              child: Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Ficha técnica
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF292929),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red.shade700, width: 2),
              ),
              child: Secao(
                endereco: [imagens[0]['misc'][0]['url']],
                texto: legendas[0],
                tamanho: 300,
              ),
            ),

            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
