class Chair extends ImageNew {

    constructor(x, y , flip, buffer, positionName) {
        super(100, 100, "images/chair.png", x, y, "image", flip);

        this.buffer = buffer;
        this.positionName = positionName;
        this.empty = true;
        this.student = null;
        this.state = "idle";
    }

    clicked() {
        var dis = Math.sqrt(Math.pow(this.centerX-mouseX,2) + Math.pow(this.centerY-mouseY,2));
        if(dis < 70){
            
            myGamePiece.targetX = this.x + this.buffer;
            myGamePiece.targetY = this.y;
            myGamePiece.position = this.positionName;
            if(this.state == "idle"){
                this.state = "clicked"; 
            }
            else if(this.state == "waiting_for_answer"){
                if(myGamePiece.info == (this.student.chairNumber+"answer")){
                    this.state = "got_answer";
                }
            }
        }
    }

    addStudent(stu) {
        this.empty = false;
        this.student = stu;
    }

    removeStudent() {
        this.empty = true;
        this.student.image.src = "images/student1_stand.png";
        this.student.setTarget(1000,470);
        this.student.leaving = true;
    }

    updateStudent() {
        if(!this.empty) {
            if(!this.student.moving) {
                this.student.image.src = "images/student1_sit.png";
                if(this.student.x > 470){
                    this.student.flip = "mirrorstudent";               
                }
            }
        }
    }
}