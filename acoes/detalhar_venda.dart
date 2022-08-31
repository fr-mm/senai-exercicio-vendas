import '../entidades/produto.dart';
import '../entidades/venda.dart';
import '../formatar.dart';
import '../menu.dart';
import 'acao.dart';


class DetalharVenda extends Acao {
  final List<Venda> vendas;

  DetalharVenda({
    required this.vendas
  });

  @override
  void executar() {
    if (vendas.isEmpty) {
      print('Não existem vendas cadastradas');
      return;
    }

    Map<String, Function> opcoes = {};
    for (Venda venda in vendas) {
      String opcao = _construirOpcao(venda);
      opcoes[opcao] = () => _detalhar(venda);
    }
    Menu menu = Menu(
      opcoes: opcoes,
      fraseAntes: _tituloDeOpcoes,
      fraseDepois: 'Escolha uma venda:'
    );
    menu.executar();
  }

  String get _tituloDeOpcoes =>
    Formatar.colunas([
      'ID',
      'CLIENTE',
      'VALOR'
    ], pad: Menu.tamanhoDoId);

  String _construirOpcao(Venda venda) {
      String cliente = '${venda.cliente.nome} (${venda.cliente.id})';
      return Formatar.colunas([
        venda.id,
        cliente,
        Formatar.dinheiro(venda.valorTotal)
      ]);
  }

  void _detalhar(Venda venda) {
    print('ID: ${venda.id}');
    print('Cliente: ${venda.cliente.nome} (${venda.cliente.id})');
    print('Itens: ${venda.quantidadeDeItens}');
    print('Valor total: ${Formatar.dinheiro(venda.valorTotal)}');
    print(Formatar.colunas([
      'PRODUTO',
      'PREÇO',
      'QUANTIDADE',
      'TOTAL'
    ]));
    for (Produto produto in venda.todosOsProdutos) {
      _detalharProduto(venda, produto);
    }
  }

  void _detalharProduto(Venda venda, Produto produto) {
    int quantidade = venda.quantidadeDe(produto);
    double total = produto.preco * quantidade;
    print(Formatar.colunas([
      produto.nome,
      Formatar.dinheiro(produto.preco),
      quantidade.toString(),
      Formatar.dinheiro(total)
    ]));
  }
}
