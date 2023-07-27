class Programa {
  //Clases
  String estado;
  Menu menu;
  Vanidad vanidad;
  Desamparo desamparo;
  Timidez timidez;
  Acoso acoso; 

  Programa() {
    estado = "menu";
    menu = new Menu();
    vanidad = new Vanidad();
    desamparo = new Desamparo();
    timidez = new Timidez();
    acoso = new Acoso();
  }

  //Funciones
  void actualizar() {
    if(estado.equals("menu")){
      menu.actualizar();
    }
    if(estado.equals("Vanidad")){
      vanidad.actualizar();
    }
    if(estado.equals("Desamparo")){
      desamparo.actualizar();
    }
    if(estado.equals("Timidez")){
      timidez.actualizar();
    }
        if(estado.equals("Acoso")){
      acoso.actualizar();
    }
  }

  void click() {
    
     if(estado.equals("menu")){
       menu.clickBoton();
    }
      if(estado.equals("Vanidad")){
       vanidad.click();
    }
      if(estado.equals("Desamparo")){
       desamparo.click();
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
