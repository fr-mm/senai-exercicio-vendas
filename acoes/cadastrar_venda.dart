import '../entidades/cliente.dart';
import '../entidades/venda.dart';
import '../erros/erro_de_validacao.dart';
import '../menu.dart';
import 'acao.dart';

class CadastrarVenda extends Acao {
  final List<Venda> vendas;
  final List<Cliente> clientes;

  CadastrarVenda({
    required this.vendas,
    required this.clientes
  });

  @override
  Venda? executar() {
    try {
      Cliente cliente = _perguntarCliente();
      return _criarVenda(cliente);
    }
    on ErroDeValidacao {
      return null;
    }
  }

  Cliente _perguntarCliente() {
    Menu menu = Menu(
      opcoes: _opcoesDeCliente,
      fraseAntes: 'Escolha um cliente: '
    );
    return menu.executar();
  }

  Map<String, Function> get _opcoesDeCliente {
    Map<String, Function> opcoes = {};
    for (Cliente cliente in clientes) {
      opcoes['${cliente.nome} (${cliente.id})'] = () => cliente;
    }
    return opcoes;
  }

  Venda _criarVenda(Cliente cliente) {
    Venda venda = Venda(cliente);
    vendas.add(venda);
    print('Venda criada: ID ${venda.id}, cliente: ${cliente.nome} (${cliente.id})');
    return venda;
  }
}
