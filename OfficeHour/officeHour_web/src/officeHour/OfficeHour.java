package officeHour;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import data.Database;

@WebServlet("/OfficeHour")
public class OfficeHour extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OfficeHour() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("UID", 0);
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/game.jsp");
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userID = request.getParameter("uid");
		int uid = 0;
		if(userID == null) { //just logged in
			String name = request.getParameter("uname");
			String password = request.getParameter("psw");
			
			if(name == null) name = "Guest";
			
			Database db = new Database();
			uid = db.retrieveUID(name, password);			
		}
		else { //playing again
			uid = Integer.parseInt(userID);
		}
		
		request.setAttribute("UID", uid);
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/game.jsp");
		dispatch.forward(request, response);
	}

}
