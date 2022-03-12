<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	int uid = (int) request.getAttribute("UID");
%>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<style>
#game {
    border:1px solid #d3d3d3;
    background-color: #f1f1f1;
    background-image: url(images/background.png);
    position: fixed;
    top: 0;
    left: 0;
}
#leaderboard {
    border:2px dashed #d3d3d3;
    background-color: #f1f1f1;
    position: fixed;
    top: 35;
    left: 780px;
}
#uid {
    display: none;
}
.modal {
  text-align:center;
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
/* Modal Content */
.modal-content {
  text-align:center;
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 0;
  border: 1px solid #888;
  width: 80%;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  -webkit-animation-name: animatetop;
  -webkit-animation-duration: 0.4s;
  animation-name: animatetop;
  animation-duration: 0.4s
}
/* Add Animation */
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}
@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}
/* The Close Button */
.close {
  color: white;
  float: right;
  font-size: 28px;
  font-weight: bold;
}
.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
.modal-header {
  padding: 2px 16px;
  background-color: #8c0000;
  color: #FACC2E;
}
.modal-body {padding: 2px 16px;}    
.modal-footer {
  padding: 2px 16px;
  background-color: #8c0000;
  color: #FACC2E;
}
.button {
  background-color: #FACC2E;
  border: none;
  color: #8c0000;
  padding: 15px 25px;
  text-align: center;
  font-size: 16px;
  cursor: pointer;
}
.button:hover {
  background-color: rgb(255, 174, 0);
}
</style>
</head>
<body onload="startGame()">

<script src="src/leaderboard_Entry.js"></script>
<script src="src/leaderboard.js"></script>

<script src="src/Actor.js" type="text/javascript"></script>
<script src="src/ImageNew.js" type="text/javascript"></script>
<script src="src/CP.js" type="text/javascript"></script>
<script src="src/Student.js" type="text/javascript"></script>
<script src="src/Chair.js" type="text/javascript"></script>
<script src="src/Bar.js" type="text/javascript"></script>
<script src="src/Computer.js" type="text/javascript"></script>
<script src="src/Life.js" type="text/javascript"></script>
<script>
var myGamePiece;
var score;
var round;
var studentLeavingArray;
var studentLeft;
var studentQueueNum = 10;
var startingStudentQueueNum = 10;
var initialQueueLength = 10;
var chairArray;
var lifeArray;
var computerArray;
var mouseX;
var mouseY;
function startGame() {
    myGamePiece = new CP();
    studentLeavingArray = new Array();
    studentLeft = new Array();
    score = 0;
    round = 1;
    chair1 = new Chair(100,125, "chair1", 70, "chair1");
    chair2 = new Chair(510,185, "mirror1", -100, "chair2");
    chair3 = new Chair(97,220, "chair3", 70, "chair3");
    chair4 = new Chair(510,285, "mirror2", -100, "chair4");
    chair5 = new Chair(95,325, "chair5", 70, "chair5");
    chairArray = new Array(chair1,chair2,chair3,chair4,chair5);
    life1 = new Life(580, 10, "life1");
    life2 = new Life(610, 10, "life2");
    life3 = new Life(640, 10, "life3");
    lifeArray = new Array(life1, life2, life3);
  
    comp1 = new Computer(240, 20, "comp1");
    comp2 = new Computer(360, 20, "comp2");
    computerArray = new Array(comp1, comp2);
    table = new ImageNew(205, 80, "images/table.png", 240, 73, "image", "no flip");
    myGameArea.start();
}
var myGameArea = {
    canvas : document.createElement("canvas"),
    start : function() {
        this.canvas.id = "game";
        this.canvas.width = 680;
        this.canvas.height = 470;
        this.context = this.canvas.getContext("2d");
        document.body.insertBefore(this.canvas, document.body.childNodes[0]);
        startLeaderboard();
        this.frameNo = 0;
        this.interval = setInterval(updateGameArea, 20);
        window.addEventListener('click', function (e) {
            mouseX = e.pageX;
            mouseY = e.pageY;
            mousePressed();
        })
        },
    clear : function() {
        this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
    },
    stop : function() {
        clearInterval(this.interval);
    }
}
function mousePressed(){
    for(var i =0; i<chairArray.length; i++){
        chairArray[i].clicked();
    }
    for(var i =0; i<computerArray.length; i++){
        computerArray[i].clicked();
    }
}
var stateFlag = "starting"; // starting, between, during
var minusVal = 0.01;
function updateGameArea() {
    myGameArea.clear();
    if (stateFlag == "starting") {
        startingRound();
    } else if (stateFlag == "between") {
        betweenRound();
    } else if (stateFlag == "during") {
        duringRound();
    }
}
function startingRound() {
    if (minusVal == 0.01) {
            minusVal = 0.025
        } else {
            minusVal += 0.025;
    }
    if(studentQueueNum > 0 ){
        for (i = 0; i < chairArray.length; i++) {
               if(chairArray[i].empty){
                   spawnStudent();
                   studentQueueNum--;
                    if(studentQueueNum < 0 ) {
                        break;
                    }
                }
            }
    }
    stateFlag = "during";
}
function betweenRound() {
    openModal();
    
}
function newRound() {
    closeModal();
    studentLeft = [];
    startingStudentQueueNum += 2;
    studentQueueNum = startingStudentQueueNum;
    initialQueueLength = studentQueueNum;
    round += 1;
    stateFlag = "starting";
    console.log("new round. StudentNum: "+studentQueueNum );
}
function duringRound() {
    if(studentLeft.length == initialQueueLength){  
        stateFlag = "between";
    } else {
        table.update();
        // label the chairs	
        let ctxChair = myGameArea.context;	
        ctxChair.save();	
        ctxChair.font = "20px Comic Sans MS";	
        ctxChair.fillStyle = "Chocolate";	
        ctxChair.fillText("0", 90, 145);	
        ctxChair.fillText("1", 560, 200);	
        ctxChair.fillText("2", 90, 245);	
        ctxChair.fillText("3", 560, 300);	
        ctxChair.fillText("4", 90, 345);	
        ctxChair.restore();	
        // chairs labeled	
        // update score	
        let ctxScore = myGameArea.context; 
        ctxScore.save();	
        ctxScore.font = "20px Comic Sans MS";	
        ctxScore.fillStyle = "coral";	
        ctxScore.fillText("Your Score: " + score, 10, 20);	
        ctxScore.restore();	
        // update round	
        ctxScore.save();	
        ctxScore.font = "20px Comic Sans MS";	
        ctxScore.fillStyle = "coral";	
        ctxScore.fillText("Round: " + round, 10, 50);	
        ctxScore.restore();	
        
        if(studentQueueNum > 0 ){
            for (i = 0; i < chairArray.length; i++) {
                if(chairArray[i].empty){
                    spawnStudent();
                    studentQueueNum--;
                    if(studentQueueNum < 0 ) {
                        break;
                    }
                }
            }
        }
        for (i = 0; i < chairArray.length; i++) {
            chairArray[i].newPos();
            chairArray[i].update();
            chairArray[i].updateStudent();
        }
        for (i = 0; i < studentLeavingArray.length; i++) {
            studentLeavingArray[i].newPos();
            studentLeavingArray[i].update();
            studentLeavingArray[i].follow();
            studentLeavingArray[i].checkMoving();
            if(studentLeavingArray[i].x >= 680){
                studentLeavingArray.splice(i,1);    // remove if left
                studentLeft.push(1);
            }
        }
        for (i = 0; i < computerArray.length; i++) {
            computerArray[i].newPos();
            computerArray[i].update();
            computerArray[i].updateLoad();
        }
        for (i = 0; i < lifeArray.length; i++) {
            lifeArray[i].newPos();
            lifeArray[i].update();
        }
        myGamePiece.newPos();
        myGamePiece.update();
        myGamePiece.checkMoving();
        for (i = 0; i < computerArray.length; i++) {
            if(computerArray[i].state == "clicked" && !myGamePiece.moving){
                if (myGamePiece.info.indexOf("answer") == -1 && myGamePiece.info.indexOf(" ") == -1 ){
                    computerArray[i].state = "loading";
                    computerArray[i].info = myGamePiece.info+"answer";
                    myGamePiece.info = " ";
                }
                else{
                    computerArray[i].state = "idle";
                }
            }
            else if(computerArray[i].state == "ready"&& !myGamePiece.moving){
                if(myGamePiece.info.indexOf(" ") != -1){
                    myGamePiece.info = computerArray[i].info;
                    computerArray[i].info = " ";
                    computerArray[i].loadingBar.starting=0;
                    computerArray[i].loadingBar.width =0;
                    computerArray[i].state = "idle";
                }
                else{
                    var temp = myGamePiece.info;
                    myGamePiece.info = computerArray[i].info;
                    computerArray[i].info = temp+"answer";
                    computerArray[i].loadingBar.starting=0;
                    computerArray[i].loadingBar.width =0;
                    computerArray[i].state = "loading";
                }
            }
        }
        // Computer Label
        let ctxComputer = myGameArea.context;
        for (i = 0; i < computerArray.length; i++) {
            ctxComputer.save();	
            ctxComputer.font = "20px Comic Sans MS";	
            ctxComputer.fillStyle = "Chocolate";
            ctxComputer.fillText(computerArray[i].info.replace("answer",""), computerArray[i].x + 35, computerArray[i].y + 35);	
            ctxComputer.restore();
            //console.log(computerArray[i].info);
        }
        
        for (i = 0; i < chairArray.length; i++) {
            if(chairArray[i].state == "clicked" && !myGamePiece.moving){
                if (myGamePiece.info == " "){
                    myGamePiece.info = chairArray[i].student.chairNumber+"";
                    chairArray[i].state = "waiting_for_answer";
                }
                else{
                    chairArray[i].state = "idle";
                }
            }
            else if(chairArray[i].state == "got_answer" && !myGamePiece.moving){
                chairArray[i].state = "idle";
                myGamePiece.info = " ";
                chairArray[i].removeStudent();
                var scorePercentage = 1;	
                scorePercentage = chairArray[i].student.patience.now / 50;		
                if (scorePercentage > 0.8) {	
                    score += 100;	
                } else {	
                    score += Math.floor(100 * scorePercentage);	
                }
            }
            
        }    
    }
}
function spawnStudent(){
    for (i = 0; i < chairArray.length; i++) {
        if(chairArray[i].empty){
            student1 = new Student(340,430, i);
            student1.setTarget(chairArray[i].x,chairArray[i].y);
            student1.patience.addDifficulty(minusVal);  // add difficulty
            chairArray[i].addStudent(student1);
            studentLeavingArray.push(student1);
            break;
        }
    }
}
// deugging functions
function removeStudent(){
    for (i = 0; i < chairArray.length; i++) {
        if(!chairArray[i].empty && !chairArray[i].student.moving){
            removeStudentNum(i);
            break;
        }
    }
}
function removeStudentNum(studentNum){
    if(studentNum < chairArray.length && studentNum>=0){
        if(!chairArray[studentNum].empty && !chairArray[studentNum].student.moving){
            chairArray[studentNum].removeStudent();
        }
    }
}
</script>

<div id="myModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
      <div class="modal-header">
        <h2>Round Finished!</h2>
      </div>
      <div class="modal-body">
        <font face = "Comic sans MS" size =" 8" color ="#FACC2E" id="myScore"></font><br /><br />
        <font face = "Comic sans MS" size =" 6" color ="#FACC2E">Click the Button below to start the Next Round!</font><br /><br />
        <button class="button" onclick="newRound()"> Next Round </button>
      </div>
      <div class="modal-footer">
        <h3>Round Finished!</h3>
      </div>
    </div>

</div>

<script>
// script for modal
var modal = document.getElementById("myModal");
function openModal() {
    modal.style.display = "block";
    document.getElementById("myScore").innerHTML = "Your Score: " + score;
}
function closeModal() {
    modal.style.display = "none";
}
</script>
<form id="uid-form" action="GameOver" method="POST">
    <input name="uid" type="text" id="uid" value="<%= uid %>">
</form>

</body>
</html>