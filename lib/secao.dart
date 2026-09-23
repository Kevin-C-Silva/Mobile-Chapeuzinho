import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Secao extends StatelessWidget {
  final List<String> endereco;
  final String texto;
  final double tamanho;
  final String? link;

  const Secao({
    super.key,
    required this.endereco,
    required this.texto,
    required this.tamanho,
    this.link,
  });

  Future<void> abrirLink() async {
    if (link == null || link!.isEmpty) {
      return;
    }

    final Uri url = Uri.parse(link!);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool possuiLink = link != null && link!.isNotEmpty;

    return Row(
      children: [
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

        Expanded(
          flex: 1,
          child: possuiLink
              ? GestureDetector(
                  onTap: abrirLink,
                  child: Text(
                    texto,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              : Text(
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
