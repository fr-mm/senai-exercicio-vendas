import 'cliente.dart';
import 'produto.dart';
import 'repositorio_de_produto.dart';


class Venda extends RepositorioDeProduto {
  final Cliente cliente;

  Venda(this.cliente);

  double get valorTotal {
    double total = 0;
    produtos.forEach((produto, quantidade) {
      total += produto.preco * quantidade;
    });
    return total;
  }

  double valorTotalDeProduto(Produto produto) {
    return produto.preco * quantidadeDe(produto);
  }

  @override
  void retirarProduto(Produto produto, int quantidade) {
    super.retirarProduto(produto, quantidade);
    if (quantidadeDe(produto) == 0) {
      produtos.remove(produto);
    }
  }
}
