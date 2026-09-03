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

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/midias.json');

    final List<dynamic> data = json.decode(response);

    setState(() {
      imagens = data[0]['imagens'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text(
          "Sobre Deu a Louca na Chapeuzinho",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Ficha técnica',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
            
            Secao(
              urls: imagens.isNotEmpty
                  ? [imagens[0]['url']]
                  : [],
              texto: '''
Título: Hoodwinked! (Original)
Ano de produção: 2005
Dirigido por: Cory Edwards
Estreia: 16 de Dezembro de 2005
Duração: 80 minutos
Classificação: Livre para todos os públicos
Gênero(s): Animação, Comédia, Família
Países de Origem: Estados Unidos da América''',
              tamanho: 300,
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                'Elenco',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Geração dinâmica de cada imagem no Json
            if (imagens.isNotEmpty) ...[
              ...imagens.skip(1).map((personagem) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Secao(
                    urls: [personagem['url']],
                    texto: personagem['legenda'],
                    tamanho: 100,
                  ),
                );
              }),
            ],

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}