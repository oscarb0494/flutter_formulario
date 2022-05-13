// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ObjetoModel objetoModelFromJson(String str) => ObjetoModel.fromJson(json.decode(str));

String objetoModelToJson(ObjetoModel data) => json.encode(data.toJson());

class ObjetoModel {

    String id;
    String colorUno;
    String colorDos;
    String forma;
    String texto;
    bool disponible;
    String fotoUrl;

/**
    * @id codigo generado automaticamente por firebase
     * @colorUno color principal del objeto
     * @colorDos color secundario del objeto, no aplicable para todos los objetos.
     * @texto posible texto de la llave
     * @disponible estado de busquedad del objeto, true corresponde a llave encontrada.
     * @fotoUrl imagen del objeto encontrado.
     * 
*/
    ObjetoModel({
        this.id,
        this.colorUno = '',
        this.colorDos = '',
        this.forma = '',
        this.texto = '',
        this.disponible = true,
        this.fotoUrl,
    });

    factory ObjetoModel.fromJson(Map<String, dynamic> json) => new ObjetoModel(
        id         : json["id"],
        colorUno   : json["colorUno"],
        colorDos   : json["colorDos"],
        forma      : json["forma"],
        texto      : json["texto"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "colorUno"   : colorUno,
        "colorDos"   : colorDos,
        "forma"      : forma,
        "texto"      : texto,
        "disponible" : disponible,
        "fotoUrl"    : fotoUrl,
    };
}