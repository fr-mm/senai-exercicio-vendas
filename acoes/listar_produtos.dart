import '../entidades/estoque.dart';
import '../entidades/produto.dart';
import '../entidades/repositorio_de_produto.dart';
import '../formatar.dart';
import 'acao.dart';

class ListarProdutos extends Acao {
  final Estoque estoque;
  final RepositorioDeProduto produtosVendidos;

  ListarProdutos({required this.estoque, required this.produtosVendidos});

  @override
  void executar() {
    if (estoque.contemProdutos) {
      _printTitulo();
      _printProdutos();
    }
    else {
      print('Não existem produtos cadastrados');
    }
  }

  void _printTitulo() {
    print(Formatar.colunas([
      'PRODUTO',
      'PREÇO',
      'EM ESTOQUE',
      'VENDIDOS'
    ]));
  }
  
  void _printProdutos() {
    for (Produto produto in estoque.todosOsProdutos) {
      _printProduto(produto);
    }
  }
  
  void _printProduto(Produto produto) {
    print(Formatar.colunas([
      produto.nome,
      Formatar.dinheiro(produto.preco),
      estoque.quantidadeDe(produto).toString(),
      produtosVendidos.quantidadeDe(produto).toString()
    ]));
  } 
}
