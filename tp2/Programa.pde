class Programa {
  //Clases
  String estado;
  String[] estadosPosibles = {"Acoso", "Vanidad", "Desinteres", "Mediacion", "Xenofobia", "Timidez", "Proteccion", "Desamparo", "Empatia"};
  Caratula caratula;
  Menu menu;
  Vanidad vanidad;
  Desamparo desamparo;
  Timidez timidez;
  Acoso acoso; 
  Desinteres desinteres;  
  NavigationButtons navigationButtons;
  Empatia empatia;
  Mediacion mediacion;

  Programa() {
    estado = "caratula";
    caratula = new Caratula();
    menu = new Menu();
    vanidad = new Vanidad();
    desamparo = new Desamparo();
    timidez = new Timidez();
    desinteres = new Desinteres();
    acoso = new Acoso();
    empatia = new Empatia();
    mediacion = new Mediacion();
    
    //botones
    navigationButtons = new NavigationButtons();
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
    if(estado.equals("Empatia")){
      empatia.actualizar();
    }
    if(estado.equals("Mediación")){
      mediacion.actualizar();
    }
    if(estado != "menu" && estado != "caratula"){
      navigationButtons.goBack();
      navigationButtons.goNext();
      navigationButtons.reset();
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

    if(estado != "menu"){
       navigationButtons.handleClick();
    }
  }

  
  class NavigationButtons {
    int x = width-65;
    int y = 10;
    
    boolean isClicked(int localX, int localY) {
      println(x,y, mouseX, mouseY );
      return mouseX > localX && mouseX < localX + 50  && mouseY > localY && mouseY < localY +50 ;
    }
    
    void goBack() {
      pushStyle();
      imageMode(CORNER);
      image(arrow, x, y, 50, 50);      
      popStyle();
    }
    
    void goNext() {
      pushStyle();
      imageMode(CORNER);
      image(arrow2, x, y+60 , 50, 50);      
      popStyle();
    }
    
    void reset() {
      pushStyle();
      imageMode(CORNER);
      image(reset, x, y+120 , 50, 50);      
      popStyle();
    }
    
    void handleClick() {  
      //Goback
      if (isClicked(x, y)) {
        estado = "menu";
        //RESETS
        desamparo.reset();
        println("entro estado menu" );
      }
      //GoNext
      if (isClicked(x, y+60)) { 
        //return to start
        if (estado.equals("Empatia")) {
          estado = "menu";
        }
        //Navigate
        for (int i = 0; i < estadosPosibles.length-1; i++) {        
          if (estadosPosibles[i].equals(estado)){
            estado = estadosPosibles[i+1];
            println("estado", estado);
            return;            
          }          
        }       
        
        println("estado", estado );
      }
    }
  }
}
