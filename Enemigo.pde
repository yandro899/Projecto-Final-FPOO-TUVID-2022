abstract class Enemigo extends Persona {
  protected boolean isDead;
  protected int puntos;
  protected Arma arma;
  
  public Enemigo(float x, float y, int vida, int velocidad, int alto, int ancho, Nivel nivel, int puntos, Arma arma) {
    super(x, y, vida, velocidad, alto, ancho, nivel);
    this.puntos = puntos;
    this.arma = arma;
    this.isDead = false;
    this.isPlayer = false;
  }
  
  /** Metodos accesores */
  public boolean isDead() {
    return this.isDead;
  }
  
  public int getPuntos() {
    return this.puntos;
  }
  
  public Arma getArma() {
    return this.arma;
  }
}
