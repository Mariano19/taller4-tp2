class Programa {
  //Clases
  String estado;
  Menu menu;


  Programa() {
    estado = "menu";
    menu = new Menu();
  }

  //Funciones
  void actualizar() {
    menu.actualizar();
  }

  void click() {
    menu.clickBoton();
  }
}
