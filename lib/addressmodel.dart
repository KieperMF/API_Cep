class Address{
  String cep;
  String rua;
  String bairro;
  String localidade;
  String uf;
  //construtor
  Address({
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.localidade,
    required this.uf
  });

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
    cep: json['cep'],
    rua: json['logradouro'],
    bairro: json['bairro'], 
    localidade: json['localidade'], 
    uf: json['uf']);
  }
}