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
  Xenofobia xenofobia;
  Proteccion proteccion;
 

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
    xenofobia = new Xenofobia();
    proteccion = new Proteccion();
    
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
    if(estado.equals("Desinteres")){
      desinteres.actualizar();
    }
    if(estado.equals("Empatia")){
      empatia.actualizar();
    }
    if(estado.equals("Mediacion")){
      mediacion.actualizar();
    }
    if(estado.equals("Xenofobia")){
      xenofobia.actualizar();
    }
       if(estado.equals("Proteccion")){
      proteccion.actualizar();
    }
    if(estado != "menu" && estado != "caratula"){
      navigationButtons.goBack();
      //navigationButtons.goNext();
      navigationButtons.reset();
    }
  }

  void click() {    
    if(estado.equals("menu")){
       menu.clickBoton();
    }
    if(estado.equals("Vanidad")){
       vanidad.touch();
       
    }
    if(estado.equals("Desamparo")){
      
    }

    if(estado != "menu"){
       navigationButtons.handleClick();
    }
  }
  
  void release(){
   if(estado.equals("Vanidad")){
       vanidad.release();
    }
  }

  
  class NavigationButtons {
    int x = width-120;
    int y = 20;
    
    boolean isClicked(int localX, int localY) {
      println(x,y, mouseX, mouseY );
      return mouseX > localX && mouseX < localX + 100  && mouseY > localY && mouseY < localY +100 ;
    }
    
    void goBack() {
      pushStyle();
      imageMode(CORNER);
      image(arrow, x, y, 100, 100);      
      popStyle();
    }
    
    /*void goNext() {
      pushStyle();
      imageMode(CORNER);
      image(arrow2, x, y+60 , 50, 50);      
      popStyle();
    }*/
    
    void reset() {      
      pushStyle();
      imageMode(CORNER);
      image(reset, x, y+120 , 100, 100);      
      popStyle();
    }
    
    void handleClick() {  
      //Goback
      if (isClicked(x, y)) {
        estado = "menu";
        //RESETS
        desinteres.reset();
        vanidad.reset();
        acoso.reset();
        xenofobia.reset();
        empatia.reset();
        timidez.reset();
        proteccion.reset();
        desamparo.reset();
        println("entro estado menu" );
      }
      if (isClicked(x, y+120)) {
        println("entro reset");
        vanidad.reset();
        acoso.reset();
        xenofobia.reset();
        empatia.reset();
        timidez.reset();
        proteccion.reset();
        desamparo.reset();
        desinteres.reset();
        mediacion.reset();        
      }
      //GoNext
      /*if (isClicked(x, y+60)) { 
        //return to start
        if (estado.equals("Empatia")) {
          estado = "menu";
        }/*
        //Navigate
        for (int i = 0; i < estadosPosibles.length-1; i++) {        
          if (estadosPosibles[i].equals(estado)){
            estado = estadosPosibles[i+1];
            println("estado", estado);
            return;            
          }          
        }       
        
        println("estado", estado );
      }*/
    }
  }
}
