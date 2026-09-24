import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/registro.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  List<Registro> _registros = [];

  @override
  void initState() {
    super.initState();
    reloadRegistros();
  }

  Future<void> reloadRegistros() async {
    final data = await DatabaseHelper.instance.getRegistros();
    setState(() {
      _registros = data.map((e) => Registro.fromMap(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_registros.isEmpty) {
      return const Center(child: Text('Nenhum registro cadastrado'));
    }

    return ListView.builder(
      itemCount: _registros.length,
      itemBuilder: (context, index) {
        final registro = _registros[index];
        return ListTile(
          title: Text(registro.nome),
          subtitle: Text(registro.descricao),
        );
      },
    );
  }
}
