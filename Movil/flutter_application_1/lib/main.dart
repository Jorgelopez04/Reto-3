import 'package:flutter/material.dart';

bool validarLectura(int temperatura, int retrasoMinutos, int bateria) {
  if (temperatura < -20 || temperatura > 50) {
    return false;
  }

  if (retrasoMinutos < 0) {
    return false;
  }

  if (bateria < 0 || bateria > 100) {
    return false;
  }

  return true;
}

int calcularPuntajeRiesgo(
  String tipoCarga,
  int temperatura,
  int retrasoMinutos,
  int bateria,
  bool pendienteSync,
) {
  int puntaje = 0;
  if (temperatura < 0 || temperatura > 10) {
    puntaje += 18;
  } else if (temperatura < 2 || temperatura > 8) {
    puntaje += 8;
  } else {
    puntaje += 0;
  }
  if (retrasoMinutos >= 60) {
    puntaje += 12;
  } else if (retrasoMinutos >= 30) {
    puntaje += 8;
  } else if (retrasoMinutos >= 15) {
    puntaje += 4;
  } else {
    puntaje += 0;
  }
  if (bateria < 20) {
    puntaje += 8;
  } else if (bateria < 40) {
    puntaje += 4;
  } else {
    puntaje += 0;
  }
  if (tipoCarga == "Vacuna") {
    puntaje += 5;
  }
  if (pendienteSync) {
    puntaje += 3;
  }
  return puntaje;
}

String clasificarRiesgo(int puntaje) {
  if (puntaje >= 30) {
    return 'Critico';
  } else if (puntaje >= 20) {
    return 'Alto';
  } else if (puntaje >= 10) {
    return 'Medio';
  } else {
    return 'Bajo';
  }
}

String estadoSincronizacion(bool pendienteSync, bool confirmacionRemota) {
  if (pendienteSync && !confirmacionRemota) {
    return "Pendiente de sincronización";
  } else if (pendienteSync && confirmacionRemota) {
    return "Confirmado";
  } else if (!pendienteSync && confirmacionRemota) {
    return "Confirmado";
  } else {
    return "No requerido";
  }
}

void main() {
  // LISTAS PARALELAS:
  // Los valores que comparten el mismo indice pertenecen a una sola entrega.
  // Ejemplo: el indice 3 representa la entrega 504 en todas las listas.
  // Para agregar la entrega 508, agrega un valor al final de CADA lista.
  List<int> ids = [501, 502, 503, 504, 505, 506, 507, 508];

  List<String> tiposCarga = [
    'Vacuna',
    'Insulina',
    'Alimento',
    'Vacuna',
    'Muestra',
    'Insulina',
    'Vacuna',
    'Vacuna',
  ];

  List<int> temperaturas = [5, 11, -25, 1, 14, 7, 9, 5];
  List<int> retrasosMinutos = [10, 45, 20, 65, 35, -5, 90, 15];
  List<int> baterias = [70, 35, 50, 15, 80, 90, 10, 30];
  List<bool> pendientesSync = [
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    false,
  ];

  int validas = 0;
  int invalidas = 0;
  int sumaPuntajes = 0;
  int mayorPuntaje = 0;
  int idMayorPuntaje = 0;
  int pendientesValidas = 0;

  for (int i = 0; i < ids.length; i++) {
    if (!validarLectura(temperaturas[i], retrasosMinutos[i], baterias[i])) {
      invalidas++;

      if (temperaturas[i] < -20 || temperaturas[i] > 50) {
        print("Entrega ${ids[i]} inválida: temperatura fuera de rango");
      }

      if (retrasosMinutos[i] < 0) {
        print("Entrega ${ids[i]} inválida: retraso negativo");
      }

      if (baterias[i] < 0 || baterias[i] > 100) {
        print("Entrega ${ids[i]} inválida: batería fuera de rango");
      }

      continue;
    }

    validas++;

    int puntaje = calcularPuntajeRiesgo(
      tiposCarga[i],
      temperaturas[i],
      retrasosMinutos[i],
      baterias[i],
      pendientesSync[i],
    );

    String clasificacion = clasificarRiesgo(puntaje);

    String estado = estadoSincronizacion(pendientesSync[i], false);

    // Sumar el puntaje de las entregas válidas
    sumaPuntajes += puntaje;

    // Buscar el mayor puntaje
    if (puntaje > mayorPuntaje) {
      mayorPuntaje = puntaje;
      idMayorPuntaje = ids[i];
    }

    // Contar entregas válidas pendientes de sincronización
    if (pendientesSync[i]) {
      pendientesValidas++;
    }

    print(
      "Entrega ${ids[i]}: "
      "Puntaje=$puntaje, "
      "Clasificación=$clasificacion, "
      "Estado=$estado",
    );
  }
  double promedioPuntaje = 0;

  if (validas > 0) {
    promedioPuntaje = sumaPuntajes / validas;
  }

  print("");
  print("========== RESUMEN FINAL ==========");
  print("Entregas válidas: $validas");
  print("Entregas inválidas: $invalidas");
  print("Promedio de puntaje: ${promedioPuntaje.toStringAsFixed(2)}");
  print("ID con mayor puntaje: $idMayorPuntaje");
  print("Mayor puntaje: $mayorPuntaje");
  print("Entregas válidas pendientes de sincronización: $pendientesValidas");
  print("===================================");
}
