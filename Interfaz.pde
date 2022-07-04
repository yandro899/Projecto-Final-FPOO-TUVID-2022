/**
Clase Interfaz:
Sirve de HUD para indicar la salud, puntos, y otras cosas en el juego
*/

class Interfaz extends GameObject {
  public static final int altoInterfaz = 30;
  
  public void display() {
    // Cuadro
    rectMode(CORNER);
    noStroke();
    rect(0, 0, width, Interfaz.altoInterfaz);
    rectMode(CENTER);
    stroke(1);
    // Vida
    fill(#ff0000);
    textSize(20);
    text(String.format("Vida: %d", jugador.getVida()), 20, 20);
    
    // Nivel
    text(String.format("Nivel: %d", jugador.getNivel().getNumNivel()), width-100, 20);
    
    // Enemigos restantes
    text(String.format("Enem. restantes: %d", jugador.getNivel().getEnemigos().size()), width/2-200, 20);
    
    // Puntaje
    text(String.format("Puntos: %d", jugador.getPuntaje()), width/2+50, 20);
    fill(255);
  }
}
