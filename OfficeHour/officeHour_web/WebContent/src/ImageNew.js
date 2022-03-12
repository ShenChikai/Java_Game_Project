class ImageNew extends Actor {

    constructor(width, height, color, x, y, type, flipCheck) {
        super(width, height, color, x, y, "image", flipCheck);

        this.image = new Image();
        this.image.src = color;
    }
    
    update() {
        let ctx = myGameArea.context;
        ctx.save();

        // Changing the drawImage values for each chair so students
        // sit in them properly
        if (this.flip == "flip"){
        	ctx.translate(this.x, this.y);        
            ctx.rotate(Math.PI);
            ctx.drawImage(this.image, this.width/-2, -this.height,this.width, this.height);
        }else if(this.flip == "mirror1"){ //
            ctx.translate(this.x, this.y);
            ctx.scale(-1, 1);
            ctx.drawImage(this.image, this.width/-2-5, -this.height+110,this.width, this.height);
        }else if(this.flip == "mirror2"){
            ctx.translate(this.x, this.y);
            ctx.scale(-1, 1);
            ctx.drawImage(this.image, this.width/-2-3, -this.height+110,this.width, this.height);
        }else if(this.flip == "chair1"){
            ctx.drawImage(this.image, this.x-10,this.y+8,this.width, this.height);
        }else if(this.flip == "chair3"){
            ctx.drawImage(this.image, this.x-7,this.y+6,this.width, this.height);
        }else if(this.flip == "chair5"){
            ctx.drawImage(this.image, this.x-5,this.y+6,this.width, this.height);
        }else if(this.flip == "mirrorstudent"){
            ctx.translate(this.x, this.y);
            ctx.scale(-1, 1);
            ctx.drawImage(this.image, this.width/-2-10, -this.height+70,this.width, this.height);
        }else{
            ctx.drawImage(this.image, this.x,this.y,this.width, this.height);
        }
         ctx.restore();
    }
}