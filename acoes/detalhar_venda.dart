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
    for (int i = 0; i < vendas.length; i++) {
      String opcao = _construirOpcao(i);
      opcoes[opcao] = () => _detalhar(vendas[i]);
    }
    Menu menu = Menu(
      opcoes: opcoes,
      fraseAntes: _tituloDeOpcoes,
      fraseDepois: 'Escolha uma venda:'
    );
    menu.executar();
  }

  void _detalhar(Venda venda) {
    print(venda.id);
  }

  String get _tituloDeOpcoes =>
    Formatar.colunas([
      'ID',
      'CLIENTE',
      'VALOR'
    ]);

  String _construirOpcao(int codigo) {
      Venda venda = vendas[codigo];
      String id = '${codigo.toString().padRight(2)} : ${venda.id}';
      String cliente = '${venda.cliente.nome} (${venda.cliente.id})';
      return Formatar.colunas([
        id,
        cliente,
        Formatar.dinheiro(venda.valorTotal)
      ]);
  }
}
