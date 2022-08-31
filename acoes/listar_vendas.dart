import '../entidades/venda.dart';
import '../formatar.dart';
import 'acao.dart';

class ListarVendas extends Acao {
  final List<Venda> vendas;

  ListarVendas({
    required this.vendas
  });

  @override
  void executar() {
    if (vendas.isNotEmpty) {
      _printTitulo();
      _printVendas();
    }
    else {
      print('Não existem vendas cadastradas');
    }
  }

  void _printTitulo() {
    print(Formatar.colunas([
      'ID',
      'CLIENTE',
      'ITENS',
      'VALOR TOTAL'
    ]));
  }

  void _printVendas() {
    for (Venda venda in vendas) {
      _printVenda(venda);
    }
  }

  void _printVenda(Venda venda) {
    String cliente = '${venda.cliente.nome} (${venda.cliente.id})';

    print(Formatar.colunas([
      venda.id,
      cliente,
      venda.quantidadeDeItens.toString(),
      Formatar.dinheiro(venda.valorTotal)
    ]));
  }
}
