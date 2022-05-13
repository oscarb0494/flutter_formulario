// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

DocumentosModel documentosModelFromJson(String str) => DocumentosModel.fromJson(json.decode(str));

String documentosModelToJson(DocumentosModel data) => json.encode(data.toJson());

class DocumentosModel{

    String id;
    String cedula;
    String responsable;
    String celular;
    double latitud;
    double longitud;
    String fotoUrl;

    DocumentosModel({
        this.id,
        this.cedula = '',
        this.responsable = '',
        this.celular = '',
        this.latitud = 0.0,
        this.longitud = 0.0,
        this.fotoUrl,
    });

    factory DocumentosModel.fromJson(Map<String, dynamic> json) => new DocumentosModel(
        id         : json["id"],
        cedula     : json["cedula"],
        responsable    : json["responsable"],
        celular    : json["celular"],
        latitud: json['latitud'],
        longitud: json['longitud'],
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "cedula"     : cedula,
        "responsable": responsable,
        "celular": celular,
        "latitud": latitud,
        "longitud": longitud,
        "fotoUrl"    : fotoUrl,
    };
}