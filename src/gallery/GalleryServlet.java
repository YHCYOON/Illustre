package gallery;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/GalleryServlet")
public class GalleryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		MultipartRequest multi = null;
		int fileMaxSize = 10 * 1024 * 1024;
		String savePath = request.getRealPath("/upload").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch(Exception e) {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "파일 크기는 10MB를 넘을 수 없습니다");
			response.sendRedirect("galleryRegist.jsp");
			return;
		}
		String userID = multi.getParameter("UserID");
		HttpSession session = request.getSession();
		if(!userID.equals((String)session.getAttribute("UserID"))) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "접근할 수 없습니다");
			response.sendRedirect("login.jsp");
			return;
		}
		String fileName = "";
		File file = multi.getFile("galleryImage");
		if(file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			if(ext.equals("jpg") || ext.equals("png") || ext.equals("gif")) {
			}else {
				
			}
		}
	}

}
