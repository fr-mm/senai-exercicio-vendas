import '../../compras_old/entidades/produto.dart';
import 'cliente.dart';


class Venda {
  final Map<Produto, int> produtos = {};
  final Cliente cliente;
  
  Venda(this.cliente);

  double get valorTotal {
    double total = 0;
    produtos.forEach((produto, quantidade) {total += produto.preco * quantidade;});
    return total;
  }

  double valorTotalDeProduto(Produto produto) {
    return produto.preco * quantidadeDe(produto);
  }

  void adicionarProduto(Produto produto, int quantidade) {
    produtos[produto] = quantidade + quantidadeDe(produto);
  }

  int quantidadeDe(Produto produto) {
    return produtos[produto] ?? 0;
  }
}
