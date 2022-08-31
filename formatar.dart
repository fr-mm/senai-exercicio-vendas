class Formatar {
  static const int _pad = 30;
  static const int _tamanhoDaLinha = 120;
  
  static String colunas(List<String> textos, {int pad = 0}) {
    List<String> formatados = [];
    for (String texto in textos) {
      texto = (' ' * pad) + texto;
      formatados.add(texto.padRight(_pad));
    }
    return formatados.join();
  }

  static String dinheiro(double quantia) {
    return 'R\$${quantia.toStringAsFixed(2)}';
  }

  static void quebrarLinha(){
     print('-' * _tamanhoDaLinha);
  }
}
