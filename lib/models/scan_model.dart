import 'dart:convert';
 
ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
 
String scanModelToJson(ScanModel data) => json.encode(data.toJson());
 
class ScanModel {
  int? id;
  String? tipo;
  String valor;
  
 
  ScanModel({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    if (valor.contains('aceptado')) {
      tipo = 'aceptado';
    } else {
      tipo = 'denegado';
    }
  }
 
  factory ScanModel.fromJson(Map<String, dynamic> json) =>  ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );
 
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}