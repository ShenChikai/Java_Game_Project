package officeHour;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import data.Database;
import data.Leaderboard;


@WebServlet("/GetLB")
public class GetLB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetLB() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		
		Database db = new Database();
		
		Leaderboard lb = db.retrieveLeaderboard();
		
		String lbJsonString = gson.toJson(lb);
				
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		out.println(lbJsonString);
        out.flush();  
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
