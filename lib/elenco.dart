import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_chapeuzinho/secao.dart';

class Elenco extends StatefulWidget {
  const Elenco({super.key});

  @override
  State<Elenco> createState() => _ElencoState();
}

class _ElencoState extends State<Elenco> {
  List<dynamic> produtores = [];
  List<dynamic> elenco = [];
  List<dynamic> titulos = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/midias.json');

    final List<dynamic> data = json.decode(response);

    setState(() {
      produtores = data[0]['imagens'][0]['producao'];
      elenco = data[0]['imagens'][0]['elenco'];
      titulos = data[0]['conteudo'][0]['titulos'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (titulos.isEmpty || elenco.isEmpty || produtores.isEmpty) {
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
                titulos[3],
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

            SizedBox(height: 25),

            if (produtores.isNotEmpty)
              ...produtores.map((producao) {
                return Center(
                  child: Container(
                    width: 1000,
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF292929),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Secao(
                      endereco: [producao['url']],
                      texto: producao['legenda'],
                      tamanho: 100,
                    ),
                  ),
                );
              }),

            SizedBox(height: 35),

            // Título do elenco
            Center(
              child: Text(
                titulos[2],
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

            if (elenco.isNotEmpty)
              ...elenco.map((personagem) {
                return Center(
                  child: Container(
                    width: 1000,
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF292929),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Secao(
                      endereco: [personagem['url']],
                      texto: personagem['legenda'],
                      tamanho: 100,
                    ),
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
