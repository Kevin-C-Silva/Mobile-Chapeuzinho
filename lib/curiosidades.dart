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
  List<dynamic> imagens = [];
  List<dynamic> titulos = [];
  List<dynamic> curiosidades = [];

  // Índice onde começam os títulos das curiosidades
  final int indiceTituloCuriosidade = 8;

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
      titulos = data[0]['conteudo'][0]['titulos'];
      curiosidades = data[0]['imagens'][0]['curiosidades'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (titulos.isEmpty || imagens.isEmpty || curiosidades.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),

      appBar: AppBar(
        title: Text(
          titulos[0] as String,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...curiosidades.asMap().entries.map((entrada) {
              final int indice = entrada.key;

              final Map<String, dynamic> curiosidade =
                  entrada.value as Map<String, dynamic>;

              // Obtém o título correspondente
              final int indiceTitulo =
                  indiceTituloCuriosidade + indice;

              if (indiceTitulo >= titulos.length) {
                return const SizedBox.shrink();
              }

              final String tituloCuriosidade =
                  titulos[indiceTitulo] as String;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Título
                  Text(
                    tituloCuriosidade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  // Linha vermelha
                  Center(
                    child: Container(
                      height: 4,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 35),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292929),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Imagem + texto
                        Secao(
                          endereco: [
                            curiosidade['caminho'] as String,
                          ],
                          texto: curiosidade['legenda'] as String,
                          tamanho: 200,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}