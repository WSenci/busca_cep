import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController cep = TextEditingController();
  String resultado = '';

  Future<void> buscaCEP() async {
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/${cep.text}/json/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        resultado = 'CEP: ${data['cep']}\n'
            'Logradouro: ${data['logradouro']}\n'
            'Complemento: ${data['complemento']}\n'
            'Bairro: ${data['bairro']}\n'
            'Localidade: ${data['localidade']}\n'
            'UF: ${data['uf']}';
      });
    } else {
      setState(() {
        resultado = 'CEP não encontrado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP - Wesley Senciani - 30/11/2024'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: cep,
                decoration: const InputDecoration(labelText: 'CEP'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: buscaCEP,
                child: const Text('Buscar'),
              ),
              const SizedBox(height: 25),
              Text(
                resultado,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
