package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/IDCheckAction")
public class IDCheckAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String userID = request.getParameter("userID").trim();
		UserDAO userDAO = new UserDAO();
		int isExist = userDAO.userIDCheck(userID);
		
		PrintWriter out = response.getWriter();
		out.println(isExist);
		out.flush();
		out.close();
	
	}

}
