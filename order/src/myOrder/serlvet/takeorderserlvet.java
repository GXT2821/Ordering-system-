package myOrder.serlvet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import myOrder.dao.dishDao;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class takeorderserlvet
 */
@WebServlet("/takeorderserlvet")
public class takeorderserlvet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public takeorderserlvet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		JSONObject object=new JSONObject();
		object.put("myData", "");
		int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
		int everyPageDataCount=Integer.parseInt(request.getParameter("everyPageDataCount"));
		dishDao pd=new dishDao();
	//	int waiterId=Integer.parseInt(request.getParameter("id"));
		int intCount=pd.dishesnum();
		object.put("dataCount", intCount);
		int intallPage = 1;
		// 计算总页数
				if ((intCount % everyPageDataCount) == 0) {
					intallPage = intCount / everyPageDataCount;
				} else {
					intallPage = intCount / everyPageDataCount + 1;
				}
				// 防止页码越界
				if (pageIndex < 0) {
					pageIndex = 0;
				} else if (pageIndex >= intallPage) {
					pageIndex = intallPage - 1;
				}
			//	System.out.print(pd.selectPage(pageIndex * everyPageDataCount, everyPageDataCount));
				object.put("pageIndex", pageIndex);
				object.put("myData",pd.selectOrder(pageIndex, everyPageDataCount));
				PrintWriter out = response.getWriter();
				out.write(object.toString());
				out.flush();
				out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
