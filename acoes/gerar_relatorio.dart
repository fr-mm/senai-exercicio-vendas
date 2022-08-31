import '../entidades/cliente.dart';
import '../entidades/estoque.dart';
import '../entidades/produto.dart';
import '../entidades/repositorio_de_produto.dart';
import '../entidades/venda.dart';
import '../formatar.dart';
import 'acao.dart';


class GerarRelatorio extends Acao {
  static const int pad = 30;
  final Estoque estoque;
  final RepositorioDeProduto produtosVendidos;
  final List<Cliente> clientes;
  final List<Venda> vendas;

  GerarRelatorio({
    required this.estoque,
    required this.produtosVendidos,
    required this.clientes,
    required this.vendas
  });

  @override
  executar() {
    Formatar.quebrarLinha();
    _printTitulo();
    _printPar('Clientes cadastrados', clientes.length);
    _printPar('Produtos cadastrados', estoque.todosOsProdutos.length);
    _printPar('Vendas realizadas', vendas.length);
    _printPar('Itens em estoque', _itensEmEstoque);
    _printPar('Valor do estoque', Formatar.dinheiro(_valorDoEstoque));
    _printPar('Itens vendidos', _itensVendidos);
    _printPar('Lucro', Formatar.dinheiro(_lucro));
  }

  void _printTitulo() {
    String titulo = 'RELATÓRIO';
    print(titulo.padLeft(pad + ((titulo.length + 4) ~/ 2))
    );
  }

  void _printPar(String chave, dynamic valor) {
    print('${chave.padLeft(pad)} : ${valor.toString()}');
  }

  int get _itensEmEstoque {
    int total = 0;
    for (Produto produto in estoque.todosOsProdutos) {
      total += estoque.quantidadeDe(produto);
    }
    return total;
  }

  int get _itensVendidos {
    int total = 0;
    for (Produto produto in produtosVendidos.todosOsProdutos) {
      total += produtosVendidos.quantidadeDe(produto);
    }
    return total;
  }

  double get _valorDoEstoque {
    double total = 0;
    for (Produto produto in estoque.todosOsProdutos) {
      double montante = produto.preco * estoque.quantidadeDe(produto);
      total += montante;
    }
    return total;
  }

  double get _lucro {
    double total = 0;
    for (Produto produto in produtosVendidos.todosOsProdutos) {
      total += produtosVendidos.quantidadeDe(produto);
    }
    return total;
  }
}
