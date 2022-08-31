import 'dart:io';

import '../entidades/estoque.dart';
import '../entidades/produto.dart';
import '../erros/erro_de_validacao.dart';
import '../formatar.dart';
import 'acao.dart';

class CadastrarProduto extends Acao {
  static const String _msgCadastroCancelado = 'CADASTRO CANCELADO:';
  final Estoque estoque;

  CadastrarProduto({required this.estoque});

  @override
  void executar() {
    try {
      String nome = _perguntarNome();
      _validarNomePreenchido(nome);
      _validarNomeUnico(nome);
      double preco = _perguntarPreco();
      _validarPrecoMaiorQueZero(preco);
      int quantidade = _perguntarQuantidade();
      _validarQuantidadePositiva(quantidade);
      Produto produto = Produto(nome: nome, preco: preco);
      estoque.adicionarProduto(produto: produto, quantidade: quantidade);
      print('$nome (${Formatar.dinheiro(preco)}) criado, $quantidade unidades adicionadas ao estoque');
    }
    on ErroDeValidacao {
      return;
    }
  }

  String _perguntarNome() {
    print('Nome do produto: ');
    String nome = stdin.readLineSync()!;
    return nome.trim();
  }

  void _validarNomePreenchido(String nome) {
    if (nome.isEmpty) {
      print('$_msgCadastroCancelado Nome não pode ser vazio');
      throw ErroDeValidacao();
    }
  }

  void _validarNomeUnico(String nome) {
    if (estoque.contemProdutoComNome(nome)) {
      print('$_msgCadastroCancelado Já existe um produto chamado $nome');
      throw ErroDeValidacao();
    }
  }

  double _perguntarPreco() {
    print('Preço: ');
    try {
      return double.parse(stdin.readLineSync()!);
    }
    on FormatException {
      print('$_msgCadastroCancelado Preço deve ser um número real separado por ponto');
      throw ErroDeValidacao();
    }
  }

  void _validarPrecoMaiorQueZero(double preco) {
    if (preco <= 0) {
      print('$_msgCadastroCancelado Preço deve ser maior que zero');
      throw ErroDeValidacao();
    }
  }

  int _perguntarQuantidade() {
    print('Quantidade: ');
    try {
      return int.parse(stdin.readLineSync()!);
    }
    on FormatException {
      print('$_msgCadastroCancelado Quantidade deve ser um número inteiro');
      throw ErroDeValidacao();
    }
  }

  void _validarQuantidadePositiva(int quantidade) {
    if (quantidade < 0) {
      print('$_msgCadastroCancelado Quantidade deve ser um número positivo');
      throw ErroDeValidacao();
    }
  }
}
