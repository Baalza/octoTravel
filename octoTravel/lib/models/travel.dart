import 'package:flutter/material.dart';
import 'dart:io'; // Importa il pacchetto necessario per utilizzare immagini

class Travel {
  final String? where;
  final DateTime? startDate;
  final DateTime? finishDate;
  final String? how;
  final File? background; // Percorso dell'immagine di sfondo

  // Costruttore della classe Travel
  Travel({
    required this.where,
    required this.startDate,
    required this.finishDate,
    required this.how,
    required this.background,
  });
  // Costruttore senza parametri
  // Costruttore con valori di default
  Travel.empty()
      : where = '',
        startDate = DateTime.now(),
        finishDate = DateTime.now(),
        how = '',
        background = null;

  // Metodo per calcolare la durata del viaggio
  //Duration get duration => finishDate.difference(startDate);

  // Metodo per verificare se il viaggio è in corso
  /*bool get isInProgress {
    final now = DateTime.now();
    return startDate.isBefore(now) && finishDate.isAfter(now);
  }*/

  // Metodo per verificare se il viaggio è già terminato
  //bool get isCompleted => finishDate.isBefore(DateTime.now());

  // Metodo per ottenere l'immagine di sfondo come widget Image
  /*Image getBackgroundImage() {
    return Image.asset(
      background,
      fit: BoxFit.cover,
    );
  }*/

  // Aggiungi altri metodi necessari qui...
}
