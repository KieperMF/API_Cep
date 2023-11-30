import 'dart:convert';
import 'package:api_cep/addressmodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:search_cep/search_cep.dart' as http;

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController cepText = TextEditingController();
  Address? address;
  String cep = '';

  @override
  Widget build(BuildContext context)  {
    return Scaffold (
      body: Center (
        child: Column (
          children: [
            TextField(
              controller: cepText,
            ),
            ElevatedButton(onPressed: (){
              httpRequest();
            },
            child: Text('Pesquisar')),
            if(address != null) ...[
              Text('Bairro:'+address!.bairro)
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
        .showSnackBar(SnackBar(content: Text('Erro carregar dados')));
    }
    setState(() {});
  }
}

