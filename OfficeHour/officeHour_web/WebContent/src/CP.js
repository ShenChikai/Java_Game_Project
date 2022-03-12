class CP extends ImageNew {
    
    constructor() {
        super(95, 95, "images/CP.png", 330, 20, "image", "no flip");

        var position = "start";
        this.moving = false;
        this.info = " ";
    }

    checkMoving() {
        if(this.speedX == 0 && this.speedY == 0){
            this.moving = false; 
        }
        else{
            this.moving = true;
        }
    }
}