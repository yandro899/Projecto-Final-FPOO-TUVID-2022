class Interfaz extends GameObject {
  
  public void display() {
    // Cuadro
    rectMode(CORNER);
    noStroke();
    rect(0,0,width, 35);
    rectMode(CENTER);
    stroke(1);
    // Vida
    fill(#ff0000);
    textSize(20);
    text(String.format("Vida: %d", jugador.getVida()), 20, 20);
    
    // Nivel
    text(String.format("Nivel: %d", jugador.getNivel().getNumNivel()), width-100, 20);
    
    // Enemigos restantes
    text(String.format("Enem. restantes: %d", jugador.getNivel().getEnemigos().size()), width/2-100, 20);
    fill(255);
  }
}
