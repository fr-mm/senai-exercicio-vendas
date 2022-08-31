import 'dart:io';

import '../entidades/cliente.dart';
import '../erros/erro_de_validacao.dart';
import 'acao.dart';

class CadastrarCliente extends Acao {
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
    nome.trim();
    return nome;
  }

  void _validarNomePreenchido(String nome) {
    if (nome.isEmpty) {
      print('Nome do cliente não pode ser vazio');
      throw ErroDeValidacao();
    }
  }

  void _validarNomeUnico(String nome) {
    bool nomeRepetido = clientes.any((cliente) => cliente.nome == nome);
    if (nomeRepetido) {
      print('Já existe um cliente chamado $nome');
      throw ErroDeValidacao();
    }
  }

  void _criarCliente(String nome) {
    Cliente cliente = Cliente(nome);
    clientes.add(cliente);
    print('Cliente ${cliente.nome} criado');
  }
}

// Abaixo está a mesma ação em formato de função
// deixei aqui para explicar por que prefiro fazer como classe
// é mais organizado e posso separara as responsabilidades
// de cada parte
/*
void cadastrarCliente(List<Cliente> clientes) {
  print('Nome do cliente: ');
  String nome = stdin.readLineSync()!;
  nome.trim();

  if (nome.isEmpty) {
    print('Nome do cliente não pode ser vazio');
    return;
  }

  bool nomeRepetido = clientes.any((cliente) => cliente.nome == nome);
  if (nomeRepetido) {
    print('Já existe um cliente chamado $nome');
    return;
  }

  Cliente cliente = Cliente(nome);
  clientes.add(cliente);
  print('Cliente ${cliente.nome} criado');
}
*/