class Actor {

    constructor(width, height, color, x, y, type, flipCheck) {
        this.type = type;
        this.width = width;
        this.height = height;
        this.velocity = 4;

           
        this.x = x;
        this.y = y;
        this.targetX = x;
        this.targetY = y;

        
        this.centerX = x+(width/2);
        this.centerY = y+(height/2);
        this.flip = flipCheck;
    }  
    
    newPos() { //
        if(Math.abs(this.targetX - this.x) < 10 && Math.abs(this.targetY - this.y) < 10){
            this.speedX = 0;
            this.speedY = 0;  
        }
        else{
            var dx = this.targetX - this.x;
            var dy = this.targetY - this.y;
            var angle = Math.atan2(dy, dx);
            this.speedX = this.velocity * Math.cos(angle);
            this.speedY = this.velocity * Math.sin(angle);
        }
        

        this.x += this.speedX;
        this.y += this.speedY;        
    }

    setTarget(x,y) {
        this.targetX = x;
        this.targetY = y;
    }
}