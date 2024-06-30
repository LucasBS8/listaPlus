class Category {
  final int id;
  final String titulo;
  final String descricao;
  final String picture;

  Category(
      {
      required this.id,
      required this.titulo,
      required this.descricao,
      required this.picture});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'picture': picture,
    };
  }
}
