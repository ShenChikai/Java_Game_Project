<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	int uid = (int) request.getAttribute("UID");
%>

<head>

	<style>
		#uid-form {
			display: none;
		}
	</style>
<meta charset="UTF-8">
<title>CSCI 201 Final Project</title>
<link rel="stylesheet" href="gameover.css">
</head>
<body>
	<div class=content>
		<div class="header-info">
		</div>
		<div class="header-content">
			<h1>Game Over!</h1>
		</div>
		
		<div class="leaderboard">
			<div class="leaderboard-header">
				<h2>Top Scores:</h2>
			</div>
			<div class="leaderboard-info clearfix">
				<div class="leaderboard-users">
					<ol>
					 	<li id="user0">Jeffrey Miller</li>
						<li id="user1">Head CP</li>
						<li id="user2">Jeffrey Miller</li>
						<li id="user3">Head CP</li>
						<li id="user4">Jeffrey Miller</li>
					</ol>
				</div>
				<div class="leaderboard-scores clearfix">
					<ul style="list-style-type:none;">
						<li id="score0">999,999</li>
						<li id="score1">999,999</li>
						<li id="score2">999,999</li>
						<li id="score3">999,999</li>
						<li id="score4">999,999</li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="btn-group">
			<br><br>
			<button class="playagain-button" onclick="submitToGame();">Play Again</button>
			<button class="quit-button" onclick="location.href = 'mainmenu.html'">Quit</button>
    	</div>
		
	</div>
	
<script>
	queryDatabase();

	function queryDatabase() {
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
	            updateEntries(response);
	        }
	    }
	    request.send();
	}
	function updateEntries(response) {
		topScores = JSON.parse(response).topScores;
	    for( let i=0; i < 5; ++i ) {
	    	currentUser = "#user" + i;
	    	currentScore  = "#score" + i;
	    	let user = document.querySelector(currentUser);
	    	let score = document.querySelector(currentScore);
	        user.innerHTML = topScores[i].user;
	        score.innerHTML = topScores[i].score;
	    }
	}
	function submitToGame() {
		let uid_form = document.querySelector("#uid-form");
		uid_form.action = "OfficeHour";
		uid_form.submit();
	}
	function submitToMainMenu() {
		let uid_form = document.querySelector("#uid-form");
		uid_form.action = "mainmenu.html";
		uid_form.submit();
	}
</script>
	<form id="uid-form" method="POST">
	    <input name="uid" type="text" id="uid" value="<%= uid %>">
	</form>
</body>
</html>
