import '../entidades/cliente.dart';
import '../entidades/venda.dart';
import '../formatar.dart';
import 'acao.dart';


class ListarClientes extends Acao {
  final List<Cliente> clientes;
  final List<Venda> vendas;

  ListarClientes({
    required this.clientes,
    required this.vendas
  });

  @override
  void executar() {
    if (clientes.isNotEmpty) {
      _printTitulo();
      _printClientes();
    }
    else {
      print('Não exisetm clientes cadastrados');
    }
  }

  void _printTitulo() {
    print(Formatar.colunas([
      'NOME',
      'ID',
      'VENDAS ATRIBUÍDAS',
      'TOTAL COMPRADO'
    ]));
  }

  void _printClientes() {
    for (Cliente cliente in clientes) {
      _printCliente(cliente);
    }
  }

  void _printCliente(Cliente cliente) {
    List<Venda> vendasAtribuidas = _vendasAtribuidasAo(cliente);
    double valorTotal = _somarValorDeVendas(cliente);

    print(Formatar.colunas([
      cliente.nome,
      cliente.id,
      vendasAtribuidas.length.toString(),
      Formatar.dinheiro(valorTotal)
    ]));
  }

  List<Venda> _vendasAtribuidasAo(Cliente cliente) =>
      vendas.where((venda) => venda.cliente == cliente).toList();

  double _somarValorDeVendas(Cliente cliente) {
    List<Venda> vendasDoCliente = vendas.where((venda) => venda.cliente == cliente).toList();
    double total = 0;
    for (Venda venda in vendasDoCliente) {
      total += venda.valorTotal;
    }
    return total;
  }
}
