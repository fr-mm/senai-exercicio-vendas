import 'dart:io';

import 'acoes/cadastrar_cliente.dart';
import 'entidades/cliente.dart';
import 'entidades/estoque.dart';
import 'entidades/venda.dart';
import 'menu.dart';


void foo() {}


class Main {
  final Estoque estoque = Estoque();
  final List<Cliente> clientes = [];
  final List<Venda> vendas = [];
  late final Menu menuPrincipal;

  Main() {
    final cadastrarCliente = CadastrarCliente(clientes: clientes);

    Menu menuClientes = Menu(
      opcoes: {
        'Voltar': voltar,
        'Cadastrar': cadastrarCliente.executar
      },
      fraseAntes: 'CLIENTES',
      fraseDepois: 'Escolha uma ação'
    );

    menuPrincipal = Menu(
      opcoes: {
        'Sair': sair,
        'Clientes': menuClientes.executar
      },
      fraseAntes: 'MENU PRINCIPAL',
      fraseDepois: 'Escolha uma ação'
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
