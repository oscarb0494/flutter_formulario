// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

DocumentosModel documentosModelFromJson(String str) => DocumentosModel.fromJson(json.decode(str));

String documentosModelToJson(DocumentosModel data) => json.encode(data.toJson());

/**
 * modelo para el manejo de los datos referentes a documentos.
 */
class DocumentosModel{

    String id;
    String cedula;
    String responsable;
    String celular;
    double latitud;
    double longitud;
    String fotoUrl;

  /**
   * 
   * @id codigo generado automaticamente por firebase
   * @cedula codigo de identificación del documento, (aplica por el momento a documentos que no sean cedulas)
   * @responsable nombre de la personas que encontro el documento.
   * @latitud latitud del lugar de la persona que encontro el documento
   * @longitud longitud del lugar de la persona que encontro el documento
   * @fotoUrl imagen del objeto encontrado, no aplica para cedulas
   * 
   */
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