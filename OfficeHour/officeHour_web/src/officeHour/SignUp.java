package officeHour;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.Database;


@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SignUp() {
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
			out.println("3\n*Password must be number*");
		}
		
		Database db = new Database();
		int error = db.register(username, pin);
		
		if(error == -1) {
			//generic error message
			out.println("-1\n*An unknown error occurred*");
		} else if(error == 0) {
			//username already exists
			out.println("0\n*User already exists*");
		} else if (error == 1) {
			// continue to game
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
