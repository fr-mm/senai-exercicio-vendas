import 'dart:io';

import '../entidades/cliente.dart';
import '../erros/erro_de_validacao.dart';
import 'acao.dart';

class CadastrarCliente extends Acao {
  static const _msgCadastroCancelado = 'CADASTRO CANCELADO:';
  final List<Cliente> clientes;

  CadastrarCliente({
    required this.clientes
  });

  @override
  void executar() {
    String nome = _perguntarNome();
    try {
      _validarNomePreenchido(nome);
      _validarNomeUnico(nome);
      _criarCliente(nome);
    }
    on ErroDeValidacao {
      return;
    }
  }

  String _perguntarNome() {
    print('Nome do cliente: ');
    String nome = stdin.readLineSync()!;
    return nome.trim();
  }

  void _validarNomePreenchido(String nome) {
    if (nome.isEmpty) {
      print('$_msgCadastroCancelado Nome do cliente não pode ser vazio');
      throw ErroDeValidacao();
    }
  }

  void _validarNomeUnico(String nome) {
    bool nomeRepetido = clientes.any((cliente) => cliente.nome == nome);
    if (nomeRepetido) {
      print('$_msgCadastroCancelado Já existe um cliente chamado $nome');
      throw ErroDeValidacao();
    }
  }

  void _criarCliente(String nome) {
    Cliente cliente = Cliente(nome);
    clientes.add(cliente);
    print('Cliente ${cliente.nome} criado');
  }
}
