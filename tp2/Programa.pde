class Programa {
  //Clases
  String estado;
  Caratula caratula;
  Menu menu;
  Vanidad vanidad;
  Desamparo desamparo;
  Timidez timidez;
  Acoso acoso; 
  Desinteres desinteres;

  Programa() {
    estado = "caratula";
    caratula = new Caratula();
    menu = new Menu();
    vanidad = new Vanidad();
    desamparo = new Desamparo();
    timidez = new Timidez();
    acoso = new Acoso();
    desinteres = new Desinteres();
  }

  //Funciones
  void actualizar() {
    if(estado.equals("caratula")){
      caratula.actualizar();
    }
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
    if(estado.equals("Desinterés")){
      desinteres.actualizar();
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
      desamparo.reset();
      println("Estado:" + programa.estado);
    }
  }
}
