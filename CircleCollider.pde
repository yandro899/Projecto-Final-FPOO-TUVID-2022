/**
Clase colision circular:
Detecta las colisiones con otros objetos.
Es una clase suelta porque asi es mucho mas facil de implementar
y hacer pruebas de debugging
*/

class CircleCollider extends GameObject{
  private float radius;      // Radio del collider
  private boolean collideOn; // Indica si el collider detecta colisiones.
  
  /** Constructor paramentrizado */
  public CircleCollider(float x, float y, float radius, boolean active) {
    super(x, y);
    this.radius = radius;
    this.collideOn = active;
  }
  
  /** Detecta colisiones contra otro objeto de la misma clase */
  public boolean collideWith(CircleCollider collider) {
    // Si la colision esta desactivada, devuelve siempre falso
    if (!this.collideOn) return false;
    
    // Mide la distancia entre radios de los colliders
    float distancia = this.posicion.dist(collider.getPosicion());
    
    // Si esa distancia es menor a la suma de radios, HAY COLISION
    if (distancia < this.radius + collider.getRadius()) return true;
    else return false;
  }
  
  /** Detecta colisiones contra otro objeto de clase rectangular */
  public boolean collideWith(RectCollider rectangle){
    // Si la colision esta desactivada, devuelve siempre falso
    if (!this.collideOn) return false;
    
    // Crea un nuevo punto que se instancia donde esta el centro del circulo.
    PVector nearestPoint = new PVector(this.posicion.x, this.posicion.y);
    
    // Sucesion de ifs donde se reubica el punto creado al punto mas
    // cercano al circulo.
    if(nearestPoint.x < rectangle.getPosicion().x-rectangle.getAncho()/2){
      nearestPoint.x = rectangle.getPosicion().x-rectangle.getAncho()/2;
    }
    
    if(nearestPoint.x > rectangle.getPosicion().x+rectangle.getAncho()/2){
      nearestPoint.x = rectangle.getPosicion().x+rectangle.getAncho()/2;
    }
    
    if(nearestPoint.y < rectangle.getPosicion().y-rectangle.getAlto()/2){
      nearestPoint.y = rectangle.getPosicion().y-rectangle.getAlto()/2;
    }
    
    if(nearestPoint.y > rectangle.getPosicion().y+rectangle.getAlto()/2){
      nearestPoint.y = rectangle.getPosicion().y+rectangle.getAlto()/2;
    }
    
    // Distancia entre estte punto y el circulo
    float distance = nearestPoint.dist(this.posicion);
    
    // Si es menor al radio, HAY COLISION
    if(distance <= this.radius) return true;
    else return false;
  }
  
  /** Dibuja la colision en pantalla (Usar en pruebas) */
  public void display() {
    fill(#ffffff);
    circle(this.posicion.x, this.posicion.y, this.radius*2);
  }
  
  /** ----- Metodos accesores ----- */
  public float getRadius() {
    return this.radius;
  }
  
  public boolean isCollideActive() {
    return this.collideOn;
  }
  
  public void setRadius(float radius) {
    this.radius = radius;
  }
  
  public void setCollideActive(boolean active) {
    this.collideOn = active;
  }
  
}
