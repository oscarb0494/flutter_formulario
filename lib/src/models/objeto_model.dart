// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ObjetoModel objetoModelFromJson(String str) =>
    ObjetoModel.fromJson(json.decode(str));

String objetoModelToJson(ObjetoModel data) => json.encode(data.toJson());

class ObjetoModel {
  String id;
  String colorUno;
  String colorDos;
  String categoria;
  String descripcion;
  bool disponible;
  String fotoUrl;
  String responsable;
  String celular;
  String direccion;

  ///
  /// @id código generado automaticamente por firebase
  /// @colorUno color principal del objeto
  /// @colorDos color secundario del objeto, no aplicable para todos los objetos.
  /// @texto posible texto de la llave
  /// @disponible estado de búsquedad del objeto, true corresponde a llave encontrada.
  /// @fotoUrl imagen del objeto encontrado.
  ObjetoModel({
    this.id,
    this.colorUno = '',
    this.colorDos = '',
    this.categoria = '',
    this.descripcion = '',
    this.disponible = true,
    this.fotoUrl,
    this.responsable = '',
    this.celular = '',
    this.direccion = '',
  });

  ///convierte archivo json a modelo objetoModel
  factory ObjetoModel.fromJson(Map<String, dynamic> json) => new ObjetoModel(
        id: json["id"],
        colorUno: json["colorUno"],
        colorDos: json["colorDos"],
        categoria: json["categoria"],
        descripcion: json["descripcion"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
        responsable: json["responsable"],
        celular: json["celular"],
        direccion: json["direccion"],
      );

  /// convierte a json cualquier objeto de la clase objetoModel
  Map<String, dynamic> toJson() => {
        "colorUno": colorUno,
        "colorDos": colorDos,
        "categoria": categoria,
        "descripcion": descripcion,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
        "responsable": responsable,
        "celular": celular,
        "direccion": direccion,
      };
}
