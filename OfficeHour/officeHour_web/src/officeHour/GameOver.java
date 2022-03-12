package officeHour;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/GameOver")
public class GameOver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GameOver() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		int uid = Integer.parseInt(request.getParameter("uid"));
	
		System.out.println("In GameOver Servlet, User id is: " + uid);

		request.setAttribute("UID", uid);
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/gameover.jsp");
		dispatch.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
