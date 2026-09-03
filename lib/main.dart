import 'package:flutter/material.dart';
import 'package:trabalho_chapeuzinho/filme.dart';
import 'package:trabalho_chapeuzinho/curiosidades.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PagInicial(),
    );
  }
}

class PagInicial extends StatelessWidget {
  const PagInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        appBar: AppBar(
          leading: Icon(Icons.movie),
          title: const Text("Sobre Deu a Louca na Chapeuzinho", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red.shade700,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Filme(),
                          ),
                      );
                    },
                    child: Text("Sobre o filme"),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Curiosidades(),
                          ),
                      );
                    },
                    child: Text("Curiosidades"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
