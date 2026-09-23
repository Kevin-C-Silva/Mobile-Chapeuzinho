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
          titulos[0],
          style: const TextStyle(
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

            // Título "Curiosidades"
            Text(
              titulos[7],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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

            // Imagem do filme
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF292929),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              child: Secao(
                endereco: [
                  imagens[0]['misc'][0]['caminho'] as String
                ],
                texto: '',
                tamanho: 300,
              ),
            ),

            const SizedBox(height: 35),

            // Curiosidades
            ...curiosidades.asMap().entries.map((entrada) {
              final int indice = entrada.key;
              final Map<String, dynamic> curiosidade = entrada.value;

              // Pega o título correspondente à curiosidade
              final String tituloCuriosidade =
                  titulos[indiceTituloCuriosidade + indice] as String;

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF292929),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade700,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título da curiosidade
                    Text(
                      tituloCuriosidade,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Imagem
                    Secao(
                      endereco: [
                        curiosidade['caminho'] as String
                      ],
                      texto: '',
                      tamanho: 200,
                    ),

                    const SizedBox(height: 15),

                    // Texto
                    Text(
                      curiosidade['legenda'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Fonte
                    Text(
                      'Fonte: ${curiosidade['origem']}',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}