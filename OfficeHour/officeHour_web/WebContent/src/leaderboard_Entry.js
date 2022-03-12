class Entry {

	constructor(score, user, x, y) {
		this.score = score;
		this.user = user;
		this.x = x;
		this.y = y;
	}

	update() {
		var ctx = myLeaderboard.context;
		ctx.font = "30px Consolas";
		ctx.fillStyle = "black";

		//print the user
		ctx.fillText(this.user, this.x, this.y);

		//print the score
		ctx.fillText(this.score, this.x, this.y + 25)
	}
}