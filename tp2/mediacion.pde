class Mediacion {
  FWorld mundo;
  FBox caja;
  
  Mediacion() {
    mundo = new FWorld();
    mundo.setEdges(100);
    
    caja = new FBox(100, 100);
    caja.setPosition(width/2, height/2);
    caja.setFill(50,50,255);
    
    
    
    mundo.add(caja);
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
