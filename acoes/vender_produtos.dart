import 'dart:io';

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
  final Acao cadastrarVenda;
  late final Menu _menuContinuar;
  bool _vendendo = false;

  VenderProdutos({
    required this.vendas,
    required this.estoque,
    required this.produtosVendidos,
    required this.cadastrarVenda
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
      _validarProdutosExistem();
      Venda venda = _criarVenda();
      _vendendo = true;
      while (_vendendo) {
        try {
          _escolherProduto(venda);
        }
        on ErroDuranteVenda{};
        _menuContinuar.executar();
      }
      _finalizar();
    }
    on ErroDeValidacao {
      return;
    }
  }
  
  Venda _criarVenda() {
    Venda? venda = cadastrarVenda.executar();
    if (venda == null) {
      throw ErroDeValidacao();
    }
    return venda;
  }

  void _escolherProduto(Venda venda) {
    String titulo = Formatar.colunas([
      'PRODUTO',
      'PREÇO',
      'EM ESTOQUE'
    ]);
    Menu menu = Menu(
      opcoes: _construirOpcoesDeProduto(venda),
      fraseAntes: titulo,
      fraseDepois: 'Escolha um produto:'
    );
    menu.executar();
  }
  
  Map<String, Function> _construirOpcoesDeProduto(Venda venda) {
    Map<String, Function> opcoes = {};
    for (Produto produto in estoque.todosOsProdutos){
      if (estoque.quantidadeDe(produto) > 0) {
        String opcao = _construirOpcaoDeProduto(produto);
        opcoes[opcao] = () {_vender(venda, produto);};
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
  
  void _vender(Venda venda, Produto produto) {
    int quantidade = _perguntarQuantidade(produto);
    estoque.retirarProduto(produto, quantidade);
    venda.adicionarProduto(produto: produto, quantidade: quantidade);
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
    //TODO: relatorio
    print('Venda finalizada');
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
      print('Não é possível vender $quantidade unidades de ${produto.nome}, só tem $emEstoque em estoque');
      throw ErroDuranteVenda();
    }
  }
}
