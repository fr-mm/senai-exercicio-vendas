import 'dart:io';

import '../entidades/cliente.dart';
import '../entidades/venda.dart';
import '../erros/erro_de_validacao.dart';
import 'acao.dart';

class CadastrarVenda extends Acao {
  static const _msgCadastroCancelado = 'CADASTRO CANCELADO:';
  final List<Venda> vendas;
  final List<Cliente> clientes;

  CadastrarVenda({
    required this.vendas,
    required this.clientes
  });

  @override
  void executar() {
    try {
      _listarClientes();
      Cliente cliente = _perguntarCliente();
      _criarVenda(cliente);
    }
    on ErroDeValidacao {
      return;
    }
  }

  void _listarClientes() {
    for (int i = 0; i < clientes.length; i++) {
      String id = i.toString().padRight(2);
      print('$id : ${clientes[i].nome}');
    }
  }

  Cliente _perguntarCliente() {
    print('Escolha o cliente:');
    try {
      int codigo = int.parse(stdin.readLineSync()!);
      return clientes[codigo];
    }
    on FormatException {
      print('$_msgCadastroCancelado Deve digitar um número inteiro');
      throw ErroDeValidacao();
    }
    on RangeError {
      print('$_msgCadastroCancelado Cliente não encontrado');
      throw ErroDeValidacao();
    }
  }

  void _criarVenda(Cliente cliente) {
    Venda venda = Venda(cliente);
    vendas.add(venda);
    print('Venda cadastrada: ID ${venda.id}, cliente: ${cliente.nome} (${cliente.id})');
  }
}
