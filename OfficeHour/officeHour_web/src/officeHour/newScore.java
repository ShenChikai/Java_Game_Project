package officeHour;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.Database;


@WebServlet("/newScore")
public class newScore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public newScore() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("userID"));
		int score = Integer.parseInt(request.getParameter("score"));
		
		Database db = new Database();
		db.newAttempt(uid, score);
		
		PrintWriter out = response.getWriter();
		out.println();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
