abstract class Enemigo extends Persona {
  protected boolean isDead;
  protected int puntos;
  protected Arma arma;
  protected ArrayList<PVector> recorrido;
  protected PVector velocidad;
  
  public Enemigo(float x, float y, int vida, int velocidad, int alto, int ancho, Nivel nivel, int puntos, Arma arma) {
    super(x, y, vida, velocidad, alto, ancho, nivel);
    this.puntos = puntos;
    this.arma = arma;
    this.isDead = false;
    this.isPlayer = false;
    this.recorrido = new ArrayList<PVector>();
    this.velocidad = new PVector();
  }
  
  public boolean enAlgunPunto() {
    for (int i=0; i<this.recorrido.size(); i++) {
      if(this.recorrido.get(i).dist(this.posicion)<20) return true;
    }
    return false;
  }
  
  /** Metodos accesores */
  public void addRecorrido(PVector punto) {
    this.recorrido.add(punto);
  }
  
  public boolean isDead() {
    return this.isDead;
  }
  
  public int getPuntos() {
    return this.puntos;
  }
  
  public Arma getArma() {
    return this.arma;
  }
  
  public ArrayList<PVector> getRecorrido() {
    return this.recorrido;
  }
}
