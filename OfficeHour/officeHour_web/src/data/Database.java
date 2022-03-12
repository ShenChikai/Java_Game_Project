package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Database {
	
	Connection conn;
	Statement st;
	PreparedStatement ps;
	ResultSet rs;
	
	public Database() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		}
		conn = null;
		st = null;
		ps = null;
		rs = null;
	}
	
	private int JDBCUpdate(String s) throws SQLException {
		conn = DriverManager.getConnection("jdbc:mysql://localhost/OfficeHour?user=root&password=root&serverTimezone=UTC"); //dependent on DB
		st = conn.createStatement();
		ps = conn.prepareStatement(s);
		return ps.executeUpdate();
	}
	
	private void JDBCQuery(String s) throws SQLException {
		conn = DriverManager.getConnection("jdbc:mysql://localhost/OfficeHour?user=root&password=root&serverTimezone=UTC"); //dependent on DB
		st = conn.createStatement();
		ps = conn.prepareStatement(s);
		rs = ps.executeQuery();
	}
	
	private void closeConnections() {
		try {
			if(rs != null) {
				rs.close();
			}
			if (st != null) {
				st.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
	
	public int register(String username, int password) {
		try {
			String insert = "INSERT INTO Users (username, passwrd)\n"
						+ "SELECT * FROM (SELECT \'" + username + "\', " + password + ") AS usr\n"
						+ "WHERE NOT EXISTS (\n"
							+ "SELECT username FROM Users WHERE username=\'" + username + "\'\n"
						+ ");";			
			int update = JDBCUpdate(insert);			
			if(update == 0) {
				System.out.println("Account already exists!");
				return update;
			} else if (update == 1) {
				System.out.println("Registration successful!");
				return update;
			}
		} catch (SQLException sqle) {
			System.out.println("SQLException in registering: " + sqle.getMessage());
		} finally {
			closeConnections();
		}
		return -1;
		
	}
	public int login(String username, int password) {
		try {
			String check = "SELECT * FROM Users WHERE username = \'" + username + "\';";
			JDBCQuery(check);
			
			int dataPass = -1;
			int userID = 0;
			String dataUsr = null;
			while(rs.next()) {
				dataUsr = rs.getString("username");
				userID = rs.getInt("userID");
				dataPass = rs.getInt("passwrd");
			}
			if(dataUsr == null) {
				System.out.println("User not found!");
				return 0;
			}
			else if(dataPass != password) {
				System.out.println("Incorrect password!");
				return 1;
			}
			else {
				System.out.println("Login successful!");
				return 2;
			}
		} catch (SQLException sqle) {
			System.out.println("SQLException in logging in: " + sqle.getMessage());
		} finally {
			closeConnections();
		}
		return -1;
	}
	

	
	public void newAttempt(int userID, int score) {
		try {
//			String insert = "INSERT INTO Scores (userID, score) VALUES (" + userID + ", " + score + ");";
			String insert = "INSERT INTO Scores (userID, score) " + 
					"SELECT * FROM (SELECT " + userID + ", " + score + ") AS s " + 
					"WHERE EXISTS (" + 
						"SELECT userID FROM Users WHERE userID=" + userID +  
					");";
			int update = JDBCUpdate(insert);
			if(update == 1) {
				System.out.println("Inserted new score for user " + userID);
			}
			else if (update == 0) {
				System.out.println("User doesn't exist!");
			}	
		} catch (SQLException sqle) {
			System.out.println("SQLException in entering new score into DB: " + sqle.getMessage());
		} finally {
			closeConnections();
		}
	}
	public void updateAttempt(int attemptID, int newScore) {
		try {
			String sqlUpdate = "UPDATE Scores SET score = " + newScore + " WHERE attemptID = " + attemptID + ";";
			int update = JDBCUpdate(sqlUpdate);
			if(update == 1) {
				System.out.println("Updated score for attempt " + attemptID);
			}
			else if (update == 0) {
				System.out.println("attempt ID does not exist");
			}
		} catch (SQLException sqle) {
			System.out.println("SQLException in entering new score into DB: " + sqle.getMessage());
		} finally {
			closeConnections();
		}
	}
	
	public Leaderboard retrieveLeaderboard() {
		Leaderboard lb;
		try {
			String query = "SELECT s.attemptID, s.userID, u.username, s.score" + 
					" FROM Scores s" + 
					" RIGHT JOIN Users u ON s.userID = u.userID" + 
					" ORDER BY score DESC;";
			JDBCQuery(query);
			
			lb = new Leaderboard();
			for(int i = 0; i < Leaderboard.TOPNUM && rs.next(); i++) {
				String user = rs.getString("username");
				int score = rs.getInt("score");
				lb.addEntry(new Entry(user, score), i);
			}
			return lb;
		} catch (SQLException sqle) {
			System.out.println("SQLException in logging in: " + sqle.getMessage());
		} finally {
			closeConnections();
		}
		return null;
	}
	
	public int retrieveUID(String username, String password) {
		int UID = 0;
		try {
			String query = "SELECT userID FROM Users"
					+ " WHERE username = \'" + username + "\'"
				    + " AND passwrd = " + password + ";";
			JDBCQuery(query);
			
			rs.next();
			UID = rs.getInt("userID");			
		} catch (SQLException sqle) {
			System.out.println("SQLException in logging in: " + sqle.getMessage());
		} finally {
			closeConnections();
		}
		return UID;
	}
	
}