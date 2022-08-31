import 'dart:io';

import 'package:test/test.dart';

import '../entidades/estoque.dart';
import '../entidades/produto.dart';
import '../entidades/repositorio_de_produto.dart';
import '../entidades/venda.dart';
import '../erros/erro_de_validacao.dart';
import '../erros/erro_durante_venda.dart';
import '../formatar.dart';
import '../menu.dart';
import 'acao.dart';


class VenderProdutos extends Acao {
  final List<Venda> vendas;
  final Estoque estoque;
  final RepositorioDeProduto produtosVendidos;
  late final Menu _menuContinuar;
  Venda? _vendaSelecionada;
  bool _vendendo = false;

  VenderProdutos({
    required this.vendas,
    required this.estoque,
    required this.produtosVendidos
  }){
    _menuContinuar = Menu(
      opcoes: {
        'sim': (){_vendendo = true;},
        'não': (){_vendendo = false;}
      },
      fraseAntes: 'Continuar comprando?'
    );
  }

  @override
  void executar() {
    try {
      _validarVendasExistem();
      _validarProdutosExistem();
      _escolherVenda();
      _vendendo = true;
      while (_vendendo) {
        _escolherProduto();
        _menuContinuar.executar();
      }
      _finalizar();
    }
    on ErroDeValidacao {
      return;
    }
  }

  void _escolherVenda() {
    String titulo = Formatar.colunas([
      'VENDA',
      'CLIENTE',
      'VALOR'
    ]);
    Menu menu = Menu(
      opcoes: _opcoesDeVenda,
      fraseAntes: titulo,
      fraseDepois: 'Escolha uma venda:'
    );
    menu.executar();
  }
  
  Map<String, Function> get _opcoesDeVenda {
    Map<String, Function> opcoes = {};
    for (Venda venda in vendas){
      String opcao = _construirOpcaoDeVenda(venda);
      opcoes[opcao] = () {_vendaSelecionada = venda;};
    }
    return opcoes;
  }
  
  String _construirOpcaoDeVenda(Venda venda) {
    String cliente = '${venda.cliente.nome} (${venda.cliente.id})';
    return Formatar.colunas([
      venda.id,
      cliente,
      Formatar.dinheiro(venda.valorTotal)
    ]);
  }
  
  void _escolherProduto() {
    String titulo = Formatar.colunas([
      'PRODUTO',
      'PREÇO',
      'EM ESTOQUE'
    ]);
    Menu menu = Menu(
      opcoes: _opcoesDeProduto,
      fraseAntes: titulo,
      fraseDepois: 'Escolha um produto:'
    );
    menu.executar();
  }
  
  Map<String, Function> get _opcoesDeProduto {
    Map<String, Function> opcoes = {};
    for (Produto produto in estoque.todosOsProdutos){
      if (estoque.quantidadeDe(produto) > 0) {
        String opcao = _construirOpcaoDeProduto(produto);
        opcoes[opcao] = () {_vender(produto);};
      }
    }
    return opcoes;
  }
  
  String _construirOpcaoDeProduto(Produto produto) {
    return Formatar.colunas([
      produto.nome,
      Formatar.dinheiro(produto.preco),
      estoque.quantidadeDe(produto).toString()
    ]);
  }
  
  void _vender(Produto produto) {
    int quantidade = _perguntarQuantidade(produto);
    _vendaSelecionada!.adicionarProduto(produto: produto, quantidade: quantidade);
    produtosVendidos.adicionarProduto(produto: produto, quantidade: quantidade);
    double custo = produto.preco * quantidade;
    print('$quantidade unidades de ${produto.nome} vendidas por ${Formatar.dinheiro(custo)}');
  }

  int _perguntarQuantidade(Produto produto) {
    try {
      print('Quandas unidades de ${produto.nome} deseja vender?');
      int quantidade = int.parse(stdin.readLineSync()!);
      _validarQuantidadeMaiorQueZero(quantidade);
      _validarQuantidadeDisponivel(quantidade, produto);
      return quantidade;
    }
    on FormatException {
      print('Quantidade deve ser um número inteiro');
      throw ErroDuranteVenda();
    }
    on ErroDuranteVenda {
      rethrow;
    }
  }

  void _finalizar() {
    print('Venda finalizada');
    _vendaSelecionada = null;
  }

  void _validarVendasExistem() {
    if (vendas.isEmpty) {
      print('Crie uma venda atribuída a um cliente para poder vender produtos');
      throw ErroDeValidacao();
    }
  }

  void _validarProdutosExistem() {
    if (!estoque.contemProdutos) {
      print('Cadastre produtos para poder vender');
      throw ErroDeValidacao();
    }
  }

  void _validarQuantidadeMaiorQueZero(int quantidade) {
    if (quantidade <= 0) {
      print('Quantidade deve ser maior que zero');
      throw ErroDuranteVenda();
    }
  }
  
  void _validarQuantidadeDisponivel(int quantidade, Produto produto) {
    int emEstoque = estoque.quantidadeDe(produto);
    if (quantidade > emEstoque) {
      print('Não é possível comprar $quantidade unidades de ${produto.nome}, só tem $emEstoque em estoque');
      throw ErroDuranteVenda();
    }
  }
}
