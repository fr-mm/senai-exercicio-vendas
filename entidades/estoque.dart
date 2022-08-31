import 'repositorio_de_produto.dart';

class Estoque extends RepositorioDeProduto {
  bool contemProdutoComNome(String nome) {
    return produtos.keys.where((produto) => produto.nome == nome).isNotEmpty;
  }
}
