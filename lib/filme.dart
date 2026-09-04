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
  List<dynamic> conteudo = [];

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
      conteudo = data[0]['conteudo'];
    });
  }

  @override
  Widget build(BuildContext context) {
        if (conteudo.isEmpty || imagens.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.red),
        ),
      );
    }

    final txtConteudo = conteudo[0];

    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),

      appBar: AppBar(
        title: Text(
          "Sobre: Deu a Louca na Chapeuzinho",
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
                txtConteudo['titulo'],
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
                urls: [imagens[0]['url']],
                texto: txtConteudo['texto'],
                tamanho: 300,
              ),
            ),

            SizedBox(height: 35),

            // Título do elenco
            Center(
              child: Text(
                conteudo[1]['titulo'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            Center(
              child: Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Geração dinâmica de cada imagem no JSON
            if (imagens.isNotEmpty)
              ...imagens.skip(1).map((personagem) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade700),
                  ),
                  child: Secao(
                    urls: [personagem['url']],
                    texto: personagem['legenda'],
                    tamanho: 100,
                  ),
                );
              }),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
