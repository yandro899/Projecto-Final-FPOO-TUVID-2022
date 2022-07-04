class AnimatedSprite extends SpriteRenderer {
  private int cantFrames;
  //private int contFrames;
  private int frameX;
  private int frameY;
  private boolean isAnimated;
  private int fpsSprite;
  
  public AnimatedSprite(String str_image, int widthFrame, int heightFrame, float posX, float posY, int cantFrames, int fpsSprite, boolean isDisplay, boolean isAnimated) {
    super(str_image, widthFrame, heightFrame, posX, posY, isDisplay);
    this.cantFrames = cantFrames;
    //this.contFrames = 0;
    this.frameX = 0;
    this.frameY = 0;
    this.fpsSprite = fpsSprite;
    this.isAnimated = isAnimated;
  }
  
  public void displaySprite() {
    
    if (!this.isDisplay) return;
    
    imageMode(CENTER);
    image(this.sprite.get(this.frameX, this.frameY, this.widthFrame, this.heightFrame), this.posicionX, this.posicionY);
    if (frameCount%(60/this.fpsSprite)==0 && this.isAnimated) {
      this.frameX += this.widthFrame;
      if (this.frameX>=this.sprite.width) {
        this.frameX = 0;
        this.frameY += this.heightFrame;
        if (this.frameY>=this.sprite.height) this.frameY = 0;
      }
    }
  }
  
  /** Metodos accesores */
  public void animSprite(boolean isAnim) {
    this.isAnimated = isAnim;
  }
  
  public boolean isAnimated() {
    return this.isAnimated;
  }
}
