import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaDos extends StatelessWidget {
  const PantallaDos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("App Veterinaria"),
      ),
      body: const ConsultarUsuarios(),
    ));
  }
}

class ConsultarUsuarios extends StatefulWidget {
  const ConsultarUsuarios({Key? key}) : super(key: key);

  @override
  State<ConsultarUsuarios> createState() => _ConsultarUsuariosState();
}

class _ConsultarUsuariosState extends State<ConsultarUsuarios> {
  final Stream<QuerySnapshot> consulta =
      FirebaseFirestore.instance.collection("usuario").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: consulta,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.hasError) return const Text("Existe error");
  
            if (snapshots.connectionState == ConnectionState.waiting) return const Text("Cargando...");

            return ListView(
                children: snapshots.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                  color: Colors.blue,
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                      title: Text(data["Usuario"]), subtitle: Text(data["Rol"])));
            }).toList());
        });
  }
}
