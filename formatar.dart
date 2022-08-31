class Formatar {
  static const int _pad = 30;
  
  static String colunas(List<String> textos) {
    List<String> formatados = [];
    for (String texto in textos) {
      formatados.add(texto.padRight(_pad));
    }
    return formatados.join();
  }

  static String dinheiro(double quantia) {
    return 'R\$${quantia.toStringAsFixed(2)}';
  }
}
