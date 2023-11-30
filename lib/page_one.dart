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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            Container(
              width: 200,
              child: TextField(
              controller: cepText,
              canRequestFocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Informe um CEP', ),
            ),
            ),
            
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
              httpRequest();
            },
            child: const Text('Pesquisar')),
            SizedBox(width: 10,),
            ElevatedButton(onPressed: (){
              address!.bairro = '';
              address!.cep = '';
              address!.localidade = '';
              address!.rua = '';
              address!.uf = '';
              setState(() {
              });
            }, child:const Text('Limpar')),
              ],
            ),
            
            const SizedBox(height: 12,),
            if(address != null) ...[
              Text('CEP: ${address!.cep}\nBairro: ${address!.bairro}\nRua: ${address!.rua}\nUF: ${address!.uf}\nLocalidade: ${address!.localidade}',
              style: TextStyle(fontSize: 16),
              ),
            ],
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

