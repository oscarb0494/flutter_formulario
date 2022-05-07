// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

DocumentosModel documentosModelFromJson(String str) => DocumentosModel.fromJson(json.decode(str));

String documentosModelToJson(DocumentosModel data) => json.encode(data.toJson());

class DocumentosModel {

    String cedula;

    DocumentosModel({
        this.cedula,
    });

    factory DocumentosModel.fromJson(Map<String, dynamic> json) => new DocumentosModel(
        cedula     : json["cedula"],
    );

    Map<String, dynamic> toJson() => {
        "cedula"     : cedula,
    };
}