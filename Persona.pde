/** Clase Persona:
Clase de la que heredan los enemigos y el jugador.
Ambos se mueven, disparan y mueren
*/

abstract class Persona extends GameObject {
  protected boolean isPlayer;          // Este objeto es el jugador?
  protected int vida;                  // Vida de la entidad
  protected int magVelocidad;          // Velocidad (magnitud)
  protected int alto;                  // Alto entidad
  protected int ancho;                 // Ancho entidad
  protected Nivel onNivel;             // En que nivel esta ubicado la entidad?
  protected RectCollider collider;     // Collider de la entidad
  
  /** Constructor paramentrizado */
  public Persona(float x, float y, int vida, int velocidad, int alto, int ancho, Nivel nivel) {
    super(x, y+Interfaz.altoInterfaz);
    this.vida = vida;
    this.magVelocidad = velocidad;
    this.alto = alto;
    this.ancho = ancho;
    this.onNivel = nivel;
    this.collider = new RectCollider(this.posicion.x, this.posicion.y, alto, ancho, true);
  }
  
  /** Declaracion de la existencia de accion de disparar */
  public abstract void shoot();
  
  /** Declaracion de la existencia de accion de moverse */
  public abstract void move();
  
  /** Declaracion de la existencia de accion de sufrir daño */
  public abstract void damage(int dano);
  
  /** Declaracion de la existencia de definir vector direccion de disparo */
  public abstract PVector direccionDisparo();
  
  /** Metodos accesores */
  public int getVida() {
    return this.vida;
  }
  
  public int getVelocidad() {
    return this.magVelocidad;
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
    this.magVelocidad = velocidad;
  }
  
  public void setNivel(Nivel nivel) {
    this.onNivel = nivel;
  }
}
