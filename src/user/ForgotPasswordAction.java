package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordAction")
public class ForgotPasswordAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String userID = request.getParameter("userID").trim();
		String userName = request.getParameter("userName").trim();
		String userEmail = request.getParameter("userEmail").trim();
		UserDAO userDAO = new UserDAO();
		String userPassword = userDAO.getPassword(userID, userName, userEmail);
		
		PrintWriter out = response.getWriter();
		out.println(userPassword);
		out.flush();
		out.close();
	
	}

}
