import 'package:flutter/material.dart';

class Secao extends StatelessWidget {
  final List<String> endereco;
  final String texto;
  final double tamanho;

  const Secao({
    super.key,
    required this.endereco,
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
            children: endereco.map((image) {
              return Expanded(
                child: Image.asset(
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
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}