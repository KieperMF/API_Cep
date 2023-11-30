import 'dart:convert';
import 'package:api_cep/addressmodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController cepText = TextEditingController();
  Address? address;

  @override
  Widget build(BuildContext context)  {
    return Scaffold (
      body: Center (
        child: Column (
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            TextField(
              controller: cepText,
              canRequestFocus: true,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: (){
              httpRequest();
            },
            child: const Text('Pesquisar')),
            if(address != null) ...[
              Text('CEP: ${address!.cep}\nRua: ${address!.rua}\nUF: ${address!.uf}\nLocalidade: ${address!.localidade}\nBairro: ${address!.bairro}'),
            ]
            
          ],
        ),
      ),
    );
  }

  void httpRequest() async{
    String cep = cepText.text;
    Uri url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final decode = jsonDecode(response.body);
      address = Address.fromJson(decode);
    }else{
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Erro carregar dados')));
    }
    setState(() {});
  }
}

