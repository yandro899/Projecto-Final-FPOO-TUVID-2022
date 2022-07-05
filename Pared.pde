/** Clase Pared:
Clase simple que solo detecta colisiones
*/

class Pared extends GameObject {
  private RectCollider collider;
  
  public Pared(float x, float y, float alto, float ancho) {
    super(x, y);
    this.collider = new RectCollider(x, y, alto, ancho, true);
  }
  
  // Dibuja la pared en pantalla  
  public void display() {
    this.collider.display();
  }
  
  /** Metodos accesores */
  public RectCollider getCollider() {
    return this.collider;
  }
}
