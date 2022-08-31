import '../erros/erro_quantidade_de_produto_indisponivel.dart';
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
    if (!produtos.containsKey(produto) || quantidadeDe(produto) < quantidade) {
      throw ErroQuantidadeDeProdutoIndisponivel();
    }
    produtos[produto] = quantidadeDe(produto) - quantidade;
  }

  int quantidadeDe(Produto produto) {
    return produtos[produto] ?? 0;
  }
}
