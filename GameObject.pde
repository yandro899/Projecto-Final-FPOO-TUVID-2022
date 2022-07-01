/** Clase abstracta GameObject:
Clase de la que nacen las otras clases.
*/

abstract class GameObject {
  protected PVector posicion;
  
  /** Constructor por defecto */
  public GameObject() {
    this.posicion = new PVector(width/2, height/2);
  }
  
  /** Constructor parametrizado */
  public GameObject(float x, float y) {
    this.posicion = new PVector(x,y);
  }
  
  /** Dibuja el objeto en pantalla. La implementación dependerá de sus clases hijas */
  public abstract void display();
  
  /** Metodos accesores */
  public PVector getPosicion() {
    return this.posicion;
  }
  
  public void setPosicion(float x, float y) {
    this.posicion = new PVector(x,y);
  }
}
