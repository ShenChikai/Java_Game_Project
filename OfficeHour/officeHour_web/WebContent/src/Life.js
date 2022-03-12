class Life extends ImageNew {

    constructor(x, y, positionName) {
        super(30, 30, "images/heart.jpg", x, y, "image", "no flip");
        
        var position = "start";
        this.state = "full";
        this.info = " ";
    }

    loseLife() {
        this.width = 0;
        this.height = 0;
        this.state = "lost"
        this.newPos();
        this.update();

    }
}