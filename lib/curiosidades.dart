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
  // Lista que irá armazenar as imagens do JSON
  List<dynamic> imagens = [];

  @override
  void initState() {
    super.initState();

    // Carrega as imagens assim que a página é iniciada
    readJson();
  }

  // Método responsável por ler o arquivo JSON
  Future<void> readJson() async {
    // Lê o arquivo JSON
    final String response = await rootBundle.loadString('assets/midias.json');

    // Converte o JSON de String para uma lista
    final List<dynamic> data = json.decode(response);

    // Pega a imagem presente no JSON
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
        backgroundColor: Colors.red.shade700,
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'Curiosidades',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Primeira seção
                      Secao(
                        urls: imagens.isNotEmpty ? [imagens[0]['url']] : [],
                        texto: '''
Orçamento independente: O filme foi produzido de forma independente com recursos limitados comparado aos gigantes da época, como Pixar e DreamWorks.

Personagem salvo por crianças: O personagem Japeth seria cortado da versão final, mas testes com o público infantil mostraram que as crianças adoravam o personagem, garantindo sua permanência no filme.

Inspiração: A estrutura narrativa de 'Deu a Louca na Chapeuzinho' é inspirado no filme Rashomon (1950), onde o mesmo evento é contado sob a perspectiva de diferentes personagens.

Título brasileiro: A inclusão de "Deu a Louca" no título brasileiro seguiu uma forte estratégia de marketing dos anos 2000 para associar comédias estrangeiras ao estilo de paródia pastelão.
''',
                        tamanho: 300,
                      ),
                    ],
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
