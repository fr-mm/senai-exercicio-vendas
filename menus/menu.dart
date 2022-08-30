/*
Pede:
- Map contendo nome da opçao e função a ser executada

Responsabiblidades:
- Mostrar as opções
- Pedir input do usuário referente a cada opção
- Repetir a pergunta até a resposta ser válida
- Executar função referente à opção escolhida
*/

import 'dart:io';


class Menu {
  late final Map<String, Function> _opcoes;
  late final String? _fraseAntes;
  late final String? _fraseDepois;
  late final List<String> _nomesDasOpcoes;

  Menu(this._opcoes, [this._fraseAntes, this._fraseDepois]) {
    _nomesDasOpcoes = _opcoes.keys.toList();
  }

  void executar() {
    String resposta;
    do {
      _imprimirOpcional(_fraseAntes);
      _mostrarOpcoes();
      _imprimirOpcional(_fraseDepois);
      resposta = stdin.readLineSync()!;
    }
    while (!_respostaValida(resposta));
    _executarOpcaoDeId(resposta);
  }

  void _imprimirOpcional(String? frase) {
    if (frase != null) {
      print(frase);
    }
  }

  void _mostrarOpcoes() {
    for (int i = 0; i < _opcoes.length; i++) {
      final String id = i.toString().padLeft(2);
      final String opcao = _nomesDasOpcoes[i];
      print('$id : $opcao');
    }
  }

  bool _respostaValida(String resposta) {
    try {
      final int id = int.parse(resposta);
      return 0 <= id && id < _opcoes.length;
    }
    on FormatException {
      return false;
    }
  }

  void _executarOpcaoDeId(String id) {
    String opcao = _nomesDasOpcoes[int.parse(id)];
    _opcoes[opcao]!();
  }
}
