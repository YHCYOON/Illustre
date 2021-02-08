package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NicknameCheckAction")
public class NicknameCheckAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String userNickname = request.getParameter("userNickname").trim();
		UserDAO userDAO = new UserDAO();
		int isExist = userDAO.userNicknameCheck(userNickname);
		
		PrintWriter out = response.getWriter();
		out.println(isExist);
		out.flush();
		out.close();
	
	}

}
