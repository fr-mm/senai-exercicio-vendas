class Cliente {
  static int _proximoId = 0;
  final String nome;
  late final String id;

  Cliente(this.nome){
    id = _proximoId.toString().padLeft(4, '0');
    _proximoId++;
  }
}
