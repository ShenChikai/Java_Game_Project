class Student extends ImageNew {
	
    constructor(x, y, chairNumber) {
        super(70, 70, "images/student1_stand.png", x, y, "image", "no flip");
        this.chairNumber = chairNumber;
        if(chairNumber == 1 || chairNumber == 3) {
            this.patience = new Bar(this.x-10, this.y-20, 1);
        }else{
            this.patience = new Bar(this.x+5, this.y-10, 1);
        }
        this.moving = true;
        this.leaving = false;
    }

    checkMoving() {
        if(this.speedX == 0 && this.speedY == 0){
            this.moving = false; 
        }
    }
    
    follow() {
        if(this.patience.width <= 0 && !this.leaving){
            chairArray[this.chairNumber].removeStudent();
            for(var i = lifeArray.length -1; i>= 0; i--) {
                if (lifeArray[i].state == "full") {
                    lifeArray[i].loseLife();
                    if (lifeArray[0].state == "lost") {
                        // gameover page
                        console.log("gameover");
                        gameoverQuery();
                    }
                    break;
                } 
            }
            this.patience.width = 0;
        }
        else if(this.patience.width > 0 ){
            if(this.chairNumber == 1 || this.chairNumber == 3) {
                if(this.x > 475){
                    this.patience.x = this.x-10;
                }else{
                    this.patience.x = this.x+10;
                }
            }else{
                this.patience.x = this.x+5;
            }
            this.patience.y = this.y-10;
            this.patience.newPos();
            this.patience.update();
            this.patience.lower();
        }
    }
}
function gameoverQuery() {
    let request = new XMLHttpRequest();
    let url = "newScore?";
    let uid = document.querySelector("#uid").value;
//    userID = "userID=" + uid;
//    score = "score=" + score;
    url += "userID=" + uid + "&score=" + score;
    console.log(url);
    request.open("GET", url, false);
    request.send();
    //window.location.pathname = "/gameover.html";
    document.querySelector("#uid-form").submit();
}