// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

LlaveModel llaveModelFromJson(String str) =>
    LlaveModel.fromJson(json.decode(str));

String llaveModelToJson(LlaveModel data) => json.encode(data.toJson());

/// modelo para el manejo de los datos referentes a llaves.
class LlaveModel {
  String id;
  String colorUno;
  String colorDos;
  String patron;
  String uso;
  bool disponible;
  String fotoUrl;

  /// @id codigo generado automaticamente por firebase
  /// @colorUno color de la base de la llave, no aplica para todas las llaves.
  /// @colorDos color de la llave (dorada,plateada,cobre)
  /// @patron patron de la llave(cerrucho, inglesa, etc)
  /// @uso utilidad de la llave
  /// @disponible estado de busquedad de la llave, true corresponde a llave encontrada.
  /// @fotoUrl imagen del objeto encontrado.
  LlaveModel({
    this.id,
    this.colorUno = '',
    this.colorDos = '',
    this.patron = '',
    this.uso = '',
    this.disponible = true,
    this.fotoUrl,
  });

  ///convierte archivo json a modelo LlaveModel
  factory LlaveModel.fromJson(Map<String, dynamic> json) => new LlaveModel(
        id: json["id"],
        colorUno: json["colorUno"],
        colorDos: json["colorDos"],
        patron: json["patron"],
        uso: json["uso"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
      );

  /// convierte a json cualquier objeto de la clase llaveModel
  Map<String, dynamic> toJson() => {
        "colorUno": colorUno,
        "colorDos": colorDos,
        "patron": patron,
        "uso": uso,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
      };
}
