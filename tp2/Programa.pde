class Programa {
  //Clases
  String estado;
  Menu menu;
  Acoso acoso;


  Programa() {
    estado = "menu";
    menu = new Menu();
    acoso = new Acoso();
  }

  //Funciones
  void actualizar() {
    if(estado.equals("menu")){
      menu.actualizar();
    }
    if(estado.equals("Acoso")){
      acoso.actualizar();
    }
  }

  void click() {
    
     if(estado.equals("menu")){
       menu.clickBoton();
    }
   
  }
}
