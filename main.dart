import 'dart:io';

import 'acoes/acao.dart';
import 'acoes/cadastrar_poduto.dart';
import 'acoes/cadastrar_cliente.dart';
import 'acoes/listar_clientes.dart';
import 'entidades/cliente.dart';
import 'entidades/estoque.dart';
import 'entidades/produto.dart';
import 'entidades/venda.dart';
import 'menu.dart';


class Main {
  final Estoque estoque = Estoque();
  final List<Cliente> clientes = [];
  final List<Venda> vendas = [];
  late final Menu menuPrincipal;
  late final Acao
      cadastrarCliente,
      listarClientes,
      cadastrarProduto;

  Main() {
    _construirAcoes();
    _construirMenus();
    _adicionarItensPadrao();
  }

  void _construirAcoes() {
    cadastrarCliente = CadastrarCliente(clientes: clientes);
    listarClientes = ListarClientes(clientes: clientes, vendas: vendas);
    cadastrarProduto = CadastrarProduto(estoque: estoque);
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
        'Cadastrar produto': cadastrarProduto.executar
      },
      fraseAntes: 'ESTOQUE',
      fraseDepois: fraseDepoisPadrao
    );

    menuPrincipal = Menu(
      opcoes: {
        'Sair': sair,
        'Clientes': menuClientes.executar,
        'Estoque': menuEstoque.executar
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

  void executar() {
    while (true) {
      menuPrincipal.executar();
    }
  }
}


void main() {
  Main().executar();
}
