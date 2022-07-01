/** Clase SpriteRenderer:
Clase que dibuja en pantalla los sprites.
Acoplable a otras clases
*/

// TODO: Que dependa de GameObject
class SpriteRenderer {
  protected PImage sprite;    // Imagen a usar en sprite
  protected int widthFrame;   // Ancho sprite
  protected int heightFrame;  // Alto sprite
  protected float posicionX;  // Posicion en x
  protected float posicionY;  // Posicion en y
  
  /** Constructor paramentrizado */
  public SpriteRenderer(String str_image, int widthFrame, int heightFrame, float posX, float posY) {
    this.sprite = requestImage(str_image);
    this.widthFrame = widthFrame;
    this.heightFrame = heightFrame;
    this.posicionX = posX;
    this.posicionY = posY;
  }
  
  /** Dibuja el sprite en pantalla */
  public void displaySprite() {
    imageMode(CENTER);
    image(this.sprite, this.posicionX, this.posicionY, this.widthFrame, this.heightFrame);
  }
  
  /* Comprueba si el sprite fue cargado con exito */
  public boolean isSpriteCharged() {
    if (this.sprite.width > 0) return true;
    else return false;
  }
}
