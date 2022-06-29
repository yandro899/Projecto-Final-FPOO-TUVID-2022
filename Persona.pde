abstract class Persona extends GameObject {
  protected boolean isPlayer;
  protected int vida;
  protected int velocidad;
  protected int alto;
  protected int ancho;
  protected Nivel onNivel;
  protected RectCollider collider;
  
  public Persona(float x, float y, int vida, int velocidad, int alto, int ancho, Nivel nivel) {
    super(x, y);
    this.vida = vida;
    this.velocidad = velocidad;
    this.alto = alto;
    this.ancho = ancho;
    this.onNivel = nivel;
    this.collider = new RectCollider(this.posicion.x, this.posicion.y, alto, ancho, true);
  }
  
  public abstract void shoot();
  
  public abstract void move();
  
  public abstract void damage(int dano);
  
  public abstract PVector direccionDisparo();
  
  /** Metodos accesores */
  public int getVida() {
    return this.vida;
  }
  
  public int getVelocidad() {
    return this.velocidad;
  }
  
  public RectCollider getCollider() {
    return this.collider;
  }
  
  public Nivel getNivel() {
    return this.onNivel;
  }
  
  public boolean isPlayer() {
    return this.isPlayer;
  }
  
  public void setVida(int vida) {
    this.vida = vida;
  }
  
  public void setVelocidad(int velocidad) {
    this.velocidad = velocidad;
  }
  
  public void setNivel(Nivel nivel) {
    this.onNivel = nivel;
  }
}
