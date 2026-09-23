import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_chapeuzinho/secao.dart';

class Curiosidades extends StatefulWidget {
  const Curiosidades({super.key});

  @override
  State<Curiosidades> createState() => _CuriosidadesState();
}

class _CuriosidadesState extends State<Curiosidades> {
  // Listas que irão armazenar os dados do JSON
  List<dynamic> imagens = [];
  List<dynamic> titulos = [];
  List<dynamic> legendas = [];


  @override
  void initState() {
    super.initState();
    // Carrega os dados assim que a página é iniciada
    readJson();
  }

  // Método responsável por ler o arquivo JSON unificado
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/midias.json');

    final List<dynamic> data = json.decode(response);

    setState(() {
      imagens = data[0]['imagens'];
      titulos = data[0]['conteudo'][0]['titulos'];
      legendas = data[0]['conteudo'][0]['textos'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Exibe um indicador de progresso enquanto os dados não carregam
    if (titulos.isEmpty || imagens.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.red),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text(
          titulos[0],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 15),

            Text(
              titulos[4],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              height: 4,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 25),

            // Cartão das curiosidades
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF292929),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.red.shade700,
                  width: 2,
                ),
              ),
              child: Secao(
                endereco: [imagens[0]['misc'][0]['url']],
                texto: legendas[1],
                tamanho: 300,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}