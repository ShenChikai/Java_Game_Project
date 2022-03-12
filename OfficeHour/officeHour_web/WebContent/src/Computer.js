class Computer extends ImageNew {
    
    constructor(x, y, positionName) {
        super(80, 70, "images/computer.png", x, y, "image", "no flip");

        this.buffer = 50;
        this.positionName = positionName;
        this.loadingBar = new Bar(this.x+15, this.y-10, 0);
        this.state = "idle";
        this.info = "";
    }

    clicked() {
        var dis = Math.sqrt(Math.pow(this.centerX-mouseX,2) + Math.pow(this.centerY-mouseY,2));
        if(dis < 70){
            myGamePiece.targetX = this.x;
            myGamePiece.targetY = this.y + this.buffer;
            myGamePiece.position = this.positionName;
            if(this.state == "idle"){
                this.state = "clicked"; 
            }
            else if(this.state == "waiting"){
                this.state = "ready";
            }
        }
    }
    updateLoad() {
        if(this.state=="loading"){
            this.loadingBar.raise();
        }
        this.loadingBar.newPos();
        this.loadingBar.update();

        if(this.loadingBar.starting >=50 && this.state=="loading"){
            this.state = "waiting";
        }
    }
}