class Mediacion {
  FWorld mundo;
  
  FBox main2;
  FCircle main;
  int anchoPersonaje = 120;
  int altoPersonaje = 130;
  //FPoly myBlob = new FPoly();
  
  
  
  Mediacion() {
    personaje.resize(120, 130);
    mundo = new FWorld();
    mundo.setEdges(100);
    
   
    //myBlob.vertex(0, 0);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/4);
    //myBlob.vertex(-anchoPersonaje/2, altoPersonaje/1.5);
    //myBlob.vertex(600, 400); 
    //myBlob.setStatic(true);  

    
    
    //
    main = new FCircle(anchoPersonaje);
    main.setPosition(width/2, height/2);
    main.setStatic(true);
    main.setStroke(255);
    main.attachImage(personaje);
    main.setFill(50,50,255);
    //
    main2 = new FBox(anchoPersonaje, altoPersonaje);
    main2.setPosition(width/2, height/2);
    main2.setStatic(true);
    main2.setStroke(255);
    main2.setFill(50,50,255);
    
    mundo.add(main2);
    mundo.add(main);
  }
  
  void actualizar() {
    
    fill(0,0,0,80);
    rect(0,0,width,height);
    //background(255);
    //println("entro mediacion");
    mundo.step();
    mundo.draw();
  }
}
