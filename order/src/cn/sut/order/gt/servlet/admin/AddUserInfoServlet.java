package cn.sut.order.gt.servlet.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




import net.sf.json.JSONObject;
import cn.sut.order.gt.dao.UserInfoDao;
import cn.sut.order.gt.tool.MD5;

/**
 * Servlet implementation class AddUserInfoServlet
 */
@WebServlet("/AddUserInfoServlet")
public class AddUserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUserInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String userAccount = request.getParameter("userAccount");
		String userPass = MD5.getInstance().md5(request.getParameter("userPass"));
		int roleId =Integer.parseInt(request.getParameter("roleId"));
		String faceimgname = request.getParameter("faceimgname");
		
		JSONObject json = new JSONObject();
		json.put("msg", "");
		
		UserInfoDao ud= new UserInfoDao();
		if(ud.addUser(userAccount, userPass, roleId, faceimgname)){
			json.put("confirm", "修改成功！");
		}else{
			json.put("msg", "修改失败！");
		}
		
		PrintWriter out = response.getWriter();
		out.print(json.toString());
		out.flush();
		out.close();
	}

}
