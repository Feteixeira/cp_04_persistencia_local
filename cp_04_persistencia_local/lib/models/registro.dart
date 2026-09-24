class Registro {
  final int? id;
  final String nome;
  final String descricao;

  Registro({this.id, required this.nome, required this.descricao});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
    };
  }

  factory Registro.fromMap(Map<String, dynamic> map) {
    return Registro(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'] ?? '',
    );
  }
}
