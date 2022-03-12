package officeHour;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.Database;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		int pin = 0;
		try {
			pin = Integer.parseInt(password);
		} catch(NumberFormatException nfe) {
			out.println("2\n*Password must be number*");
		}
		
		Database db = new Database();
		int error = db.login(username, pin);
		
		if(error == -1) {
			//generic error occurred...
			out.println("-1\n*An unknown error occurred*");
		} else if(error == 0) {
			//user was not found
			out.println("0\n*User not found*");
		} else if(error == 1) {
			//incorrect password
			out.println("1\n*Incorrect password*");
		} else if(error == 2) {
			//continue to game
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
