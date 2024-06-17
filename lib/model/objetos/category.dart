class Category {
  final String titulo;
  final String descricao;
  final String picture;

  Category(
      {
      required this.titulo,
      required this.descricao,
      required this.picture});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      titulo: json['titulo'],
      descricao: json['descricao'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'picture': picture,
    };
  }
}
