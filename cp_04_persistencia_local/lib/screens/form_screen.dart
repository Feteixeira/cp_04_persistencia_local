import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/registro.dart';

class FormScreen extends StatefulWidget {
  final VoidCallback onSaved;

  const FormScreen({super.key, required this.onSaved});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final registro = Registro(
      nome: _nomeController.text,
      descricao: _descricaoController.text,
    );

    await DatabaseHelper.instance.insertRegistro(registro.toMap());

    _nomeController.clear();
    _descricaoController.clear();

    widget.onSaved();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro salvo com sucesso')),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descricao'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvar,
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
