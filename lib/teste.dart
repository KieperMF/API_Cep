import 'package:search_cep/search_cep.dart';

void main() async {
  final viaCepSearchCep = ViaCepSearchCep();
  final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: '01001000');
  print(infoCepJSON);
}