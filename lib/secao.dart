import 'package:flutter/material.dart';

class Secao extends StatelessWidget {
  final List<String> urls;
  final String texto;
  final double tamanho;

  const Secao({
    super.key,
    required this.urls,
    required this.texto,
    required this.tamanho,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Imagem(ns)
        Expanded(
          flex: 1,
          child: Row(
            // Lê e implementa cada url presente
            children: urls.map((image) {
              return Expanded(
                child: Image.network(
                  image,
                  height: tamanho,
                  fit: BoxFit.fitHeight,
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(width: 10),

        // Texto
        Expanded(
          flex: 1,
          child: Text(
            texto,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}