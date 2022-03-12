package data;

public class Leaderboard {
	public static int TOPNUM = 5;
	
	private Entry[] topScores;
	
	public Leaderboard() {
		topScores = new Entry[TOPNUM];
	}
	public void addEntry(Entry e, int pos) {
		topScores[pos] = e;
	}
	
	//for testing
	public void printLB() {
		for(int i = 0; i < TOPNUM; i++) {
			System.out.println((i+1) + ":\t" + topScores[i].getUser() + "\t" + topScores[i].getScore());
		}
	}
}

class Entry {
	private String user;
	private int score;
	
	public Entry(String user, int score) {
		this.user = user;
		this.score = score;
	}
	public String getUser() {
		return user;
	}
	public int getScore() {
		return score;
	}
}