class Programa {
  //Clases
  String estado;
  Menu menu;
  Vanidad vanidad;


  Programa() {
    estado = "menu";
    menu = new Menu();
    vanidad = new Vanidad();
  }

  //Funciones
  void actualizar() {
    if(estado.equals("menu")){
      menu.actualizar();
    }
    if(estado.equals("Vanidad")){
      vanidad.actualizar();
    }
  }

  void click() {
    
     if(estado.equals("menu")){
       menu.clickBoton();
    }
      if(estado.equals("Vanidad")){
       vanidad.click();
    }
   
  }
  
  void teclado(){
    //Para volver al menu apretar tecla B
     if (key == 'b' || key == 'B') {
      estado = "menu";
      println("Estado:" + programa.estado);
    }
  }
}
