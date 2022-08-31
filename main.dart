import 'dart:io';

import 'acoes/acao.dart';
import 'acoes/cadastrar_poduto.dart';
import 'acoes/cadastrar_cliente.dart';
import 'acoes/cadastrar_venda.dart';
import 'acoes/listar_clientes.dart';
import 'acoes/listar_produtos.dart';
import 'acoes/listar_vendas.dart';
import 'entidades/cliente.dart';
import 'entidades/estoque.dart';
import 'entidades/produto.dart';
import 'entidades/repositorio_de_produto.dart';
import 'entidades/venda.dart';
import 'menu.dart';


class Main {
  final Estoque estoque = Estoque();
  final RepositorioDeProduto produtosVendidos = RepositorioDeProduto();
  final List<Cliente> clientes = [];
  final List<Venda> vendas = [];
  late final Menu menuPrincipal;
  late final Acao
      cadastrarCliente,
      listarClientes,
      cadastrarProduto,
      listarProdutos,
      cadastrarVenda,
      listarVendas;

  Main() {
    _construirAcoes();
    _construirMenus();
    _adicionarItensPadrao();
  }

  void executar() {
    while (true) {
      menuPrincipal.executar();
    }
  }

  void _construirAcoes() {
    cadastrarCliente = CadastrarCliente(
        clientes: clientes
    );
    listarClientes = ListarClientes(
        clientes: clientes,
        vendas: vendas
    );
    cadastrarProduto = CadastrarProduto(
        estoque: estoque
    );
    listarProdutos = ListarProdutos(
        estoque: estoque,
        produtosVendidos: produtosVendidos
    );
    cadastrarVenda = CadastrarVenda(
        vendas: vendas,
        clientes: clientes
    );
    listarVendas = ListarVendas(
        vendas: vendas
    );
  }

  void _construirMenus() {
    String fraseDepoisPadrao = 'Escolha uma opção';

    Menu menuClientes = Menu(
        opcoes: {
          'Voltar': voltar,
          'Cadastrar': cadastrarCliente.executar,
          'Listar': listarClientes.executar
        },
        fraseAntes: 'CLIENTES',
        fraseDepois: fraseDepoisPadrao
    );

    Menu menuEstoque = Menu(
        opcoes: {
          'Voltar': voltar,
          'Cadastrar': cadastrarProduto.executar,
          'Listar': listarProdutos.executar
        },
        fraseAntes: 'ESTOQUE',
        fraseDepois: fraseDepoisPadrao
    );

    Menu menuVendas = Menu(
        opcoes: {
          'Voltar': voltar,
          'Cadastrar': cadastrarVenda.executar,
          'Listar': listarVendas.executar
        },
        fraseAntes: 'VENDAS',
        fraseDepois: fraseDepoisPadrao
    );

    menuPrincipal = Menu(
        opcoes: {
          'Sair': sair,
          'Clientes': menuClientes.executar,
          'Estoque': menuEstoque.executar,
          'Vendas': menuVendas.executar
        },
        fraseAntes: 'MENU PRINCIPAL',
        fraseDepois: fraseDepoisPadrao
    );
  }

  void _adicionarItensPadrao() {
    clientes.addAll([
      Cliente('Anildo'),
      Cliente('Chico')
    ]);
    estoque.adicionarProduto(
        produto: Produto(
            nome: 'Orégano',
            preco: 200
        ),
        quantidade: 50
    );
  }

  void voltar() {
    return;
  }

  void sair() {
    exit(0);
  }
}


void main() {
  Main().executar();
}
