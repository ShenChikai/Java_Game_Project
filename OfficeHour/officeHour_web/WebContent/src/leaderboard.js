var entry1 = new Entry(69, "12345678901234567890", 10, 40); //20 chars fit
var entry2 = new Entry(2, "Billy Bruin", 10, 120);
var entry3 = new Entry(3, "HairyChest", 10, 200);
var entry4 = new Entry(4, "Jhin", 10, 280);
var entry5 = new Entry(5, "Tirebiter", 10, 360);
var entries = Array(entry1, entry2, entry3, entry4, entry5);


function startLeaderboard() {
    //yes, this function is one line
    myLeaderboard.start();
}

var myLeaderboard = {
    canvas : document.createElement("canvas"),
    start : function() {
        this.canvas.id = "leaderboard";
        this.canvas.width = 350;
        this.canvas.height = 400;
        this.context = this.canvas.getContext("2d");
        document.body.insertBefore(this.canvas, document.body.childNodes[0]);
        this.frameNo = 0;
        this.interval = setInterval(updateLeaderboardArea, 5000); //leaderboard updates every 5 seconds
    },
    clear : function() {
        this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
    },
    stop : function() {
        clearInterval(this.interval);
    }
}

function updateLeaderboardArea() {
    //clear the last set of data
    myLeaderboard.clear();

    //get the new set of data
    queryDatabase(entries);

    //display the new set of data
    for(let i=0; i < entries.length; ++i) {
        entries[i].update();
    }
}

function queryDatabase(entries) {
    let request = new XMLHttpRequest();
    let response = "No Response";
    let url = "GetLB";
    request.open("GET", url, true);
    request.onreadystatechange = function() {
        if ( this.readyState == XMLHttpRequest.DONE ) {
            response = this.responseText;
        }
        if ( response != "No Response" ) {
            //use the response to update the entry values
            updateEntries(response, entries);
        }
//        console.log(response);
    }
    request.send();
}

function updateEntries(response, entries) {
    topScores = JSON.parse(response).topScores;
    for( let i=0; i < 5; ++i ) {
        entries[i].user = topScores[i].user;
        entries[i].score = topScores[i].score;
    }
}