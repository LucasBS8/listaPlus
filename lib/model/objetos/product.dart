class Product {
  final int id;
  final int idCategoria;
  final String nome;
  final double preco;
  final String descricao;
  final String picture;

  Product(
      {
      required this.id,
      required this.idCategoria,
      required this.nome,
      required this.preco,
      required this.descricao,
      required this.picture});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      idCategoria: json['idCategoria'],
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idCategoria': idCategoria,
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
      'picture': picture,
    };
  }
}
