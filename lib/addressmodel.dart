class Address{
  String cep;
  String bairro;
  String localidade;
  String uf;

  Address({
    required this.cep,
    required this.bairro,
    required this.localidade,
    required this.uf
  });

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
    cep: json['cep'],
    bairro: json['bairro'], 
    localidade: json['localidade'], 
    uf: json['uf']);
  }
}