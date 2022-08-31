import 'produto.dart';


class RepositorioDeProduto {
  final Map<Produto, int> produtos = {};

  void adicionarProduto({
    required Produto produto,
    required int quantidade
  }) {
    produtos[produto] = quantidade + quantidadeDe(produto);
  }

  void retirarProduto(Produto produto, int quantidade) {
    produtos[produto] = quantidadeDe(produto) - quantidade;
  }

  int quantidadeDe(Produto produto) {
    return produtos[produto] ?? 0;
  }
  
  List<Produto> get todosOsProdutos => produtos.keys.toList();

  bool get contemProdutos => produtos.isNotEmpty;
}
