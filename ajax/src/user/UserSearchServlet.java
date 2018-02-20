package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {	//index.jsp 에서 요청한 결과를 json으로 응답해주는 역할을 해주는 서블릿임. 
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));
	}
	
	public String getJSON(String userName) {
		if(userName == null) userName="";
		StringBuffer result = new StringBuffer("");
		result.append("{ \"result\": [");
		UserDAO userDAO = new UserDAO();
		ArrayList<User> userList = userDAO.search(userName);
		for(int i = 0 ; i < userList.size(); i ++) {
			result.append("[{ value : \""+ userList.get(i).getUserName() +"\" },");
			result.append("{ value : \""+ userList.get(i).getUserAge() +"\" },");
			result.append("{ value : \""+ userList.get(i).getUserGender() +"\" },");
			result.append("{ value : \""+ userList.get(i).getUserEmail() +"\" }],");
		}
		result.append("]}");
		return result.toString();
	}

}
