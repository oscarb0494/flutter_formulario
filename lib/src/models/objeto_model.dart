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
        //"id"         : id,
        "colorUno"   : colorUno,
        "colorDos"   : colorDos,
        "forma"      : forma,
        "texto"      : texto,
        "disponible" : disponible,
        "fotoUrl"    : fotoUrl,
    };
}