import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class DatabaseManager {
  // Singleton
  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  Future<void> checkAndSyncDatabase(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      // Sincronização automática quando conectado ao Wi-Fi
      await syncDatabase();
    } else if (connectivityResult == ConnectivityResult.mobile) {
      // Pergunte ao usuário se deseja sincronizar ao usar dados móveis
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sincronizar com dados móveis?"),
            content: Text(
                "Você está usando dados móveis. Deseja sincronizar o banco de dados agora?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Sincronizar"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await syncDatabase();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> syncDatabase() async {
    // Implemente aqui a lógica para sincronizar o banco de dados
    // Isso pode envolver a transferência de dados para um servidor, por exemplo.
    // Certifique-se de lidar com erros e exibir feedback ao usuário.
  }
}
