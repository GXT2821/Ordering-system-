<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>${ORDER_SYS_NAME}-餐厅管理员</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/dashboard.css">


<link rel="stylesheet" href="css/font-awesome.min.css">

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="bootstrap/js/jquery-1.11.1.min.js"></script>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/jquery-ui-1.8.20.js"></script>
<script src="jquery/syq-pagination1.0.js" type="text/javascript"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/ajax.js"></script>
<script type="text/javascript">
function usersAjax(pageIndex,everyPageDataCount){//初始化数据
	$.ajax({
        type: "POST",
        url: "/order/SelectUserInfoServlet",
        data: {
       	 pageIndex: pageIndex,//当前第几页（0序列）
       	 everyPageDataCount:everyPageDataCount,//每一页多少条数据
        },
        dataType: "json",
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //window.location.href = "/paging/PagingServlet";
        },
        success: function (json) {
        	if(json.myData!=""){
        		var listHtml="";
      			for(var i=0;i<json.myData.length;i++){
      				listHtml += "<tr><td>"+json.myData[i].userId
      				+ "</td><td>"+json.myData[i].userAccount
      				+"</td><td>"+json.myData[i].roleName 
      				+"</td>";
      				
      				var newLine = "<td>";
      				newLine += "<i style='cursor: pointer; font-size: 14;'";
      				newLine += "onmouseover='this.style.color=\"orange\"'";
      				newLine += "onmouseout='this.style.color=\"black\"'";
      				newLine += "class='icon-cogs icon-large' title='修改人员信息'  onclick=\"window.location.href='UpdateUserServlet?userId=" 
      						+json.myData[i].userId + "'\"></i>&nbsp;&nbsp;";

      				newLine += "<i style='cursor: pointer; font-size: 14;'";
      				newLine += "onmouseover='this.style.color=\"orange\"'";
      				newLine += "onmouseout='this.style.color=\"black\"'";
      				newLine += "class='icon-sitemap icon-large' onclick='userinfo("
      						+ json.myData[i].userId +")' title='查看人员详情'></i>&nbsp;&nbsp;";

      				newLine += "<i style='cursor: pointer; font-size: 14;'";
      				newLine += "onmouseover='this.style.color=\"orange\"'";
      				newLine += "onmouseout='this.style.color=\"black\"'";
      				newLine += "class='icon-remove-sign icon-large' title='删除人员' onclick='deleteuser("
      						+ json.myData[i].userId + ")'></i>";

      				newLine += "</td></tr>";
      				
      				listHtml += newLine;
      			}
      			$("#orderTable").html(listHtml);
      			pagingAjax(json.dataCount,everyPageDataCount,json.pageIndex)
        	}else{
        		alert("aaaa");
        	}
        	
	       

        }
    });
}


function pagingAjax(dataCount,everyPageDataCount,nowPage){
	$("#pagingDivId").zcPage({
	     allDataCount: dataCount,//一共有多少条数据
	     everyPageDataCount: everyPageDataCount,//每一页显示多少条数据
	     nowPageCataCount:nowPage,//当前是第几页
	     success: function (nowPageCataCount/*当前是第几页*/) {
	    	 usersAjax(nowPageCataCount,everyPageDataCount)
	    	 
	     },
	 });
}

$(document).ready(function () {
	usersAjax(0,3);//初始化页面数据（当前是第1页，每一页显示5条数据）
});


function userinfo(userId){//初始化数据
	$.ajax({
        type: "POST",
        url: "/order/UserDetailedServlet",
        data: {
       	 userId : userId,
        },
        dataType: "json",
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //window.location.href = "/paging/PagingServlet";
        },
        success: function (json) {
        	if(json.msg==""){
      			$("#faceimg").attr("src",json.data.faceimg);
      			$("#userAccount").html(json.data.userAccount);
      			$("#role").html(json.data.roleName);
      			$("#myModal").modal("show");
        	}else{
        		alert("信息错误！");
        	}
        }
    });
}

function reloadPage()
{
  setTimeout(function(){window.location.reload();},1000);
 
}
function deleteuser(userId){
	like=window.confirm("是否删除此人员？");
	if(like==true){
		$.ajax({
	        type: "POST",
	        url: "/order/DeleteUserServlet",
	        data: {
	       	 userId : userId,
	        },
	        dataType: "json",
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            //window.location.href = "/paging/PagingServlet";
	        },
	        success: function (json) {
	        	if(json.msg==""){
	        		alert("操作成功！");
	        		reloadPage();
	        	}else{
	        		alert("操作失败！");
	        	}
	        }
	    });
	}
	
}

</script>
</head>

<body style="font-family: 微软雅黑">
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<img src="img/logo.png" class="navbar-brand" /> <span
				class="navbar-brand">${ORDER_SYS_NAME}</span>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><span class="navbar-brand">餐厅管理界面</span></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><img
						src="${user.faceimg }" width="24" height="24"
						class="img-circle" style="border:1px solid #FFF" />&nbsp;&nbsp;当前用户:【${user.userAccount
						}】,身份为管理员 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li style="text-align: center;padding-top: 15px"><img
							src="${user.faceimg }" width="128" height="128"
							class="img-circle"
							style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);margin-bottom: 20px" /></li>
						<li><a href="pages/users/modifyuser.jsp">修改我的密码</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="SelectKitchenServlet">查看当前在线的厨师 </a></li>
						<li><a href="SelectWaiterServlet">查看当前在线的点餐员</a></li>


					</ul></li>
				<li><a href="pages/login.jsp">退出登录</a></li>
			</ul>



			<form class="navbar-form navbar-right" method="post"
				action="sendbord.order" target="formtarget">
				<input type="text" class="form-control" placeholder="公告"
					style="width:300px" name="bord"><input
					class="btn btn-default" type="submit" value="发送" />
				<iframe name="formtarget" width="0" height="0" style="display: none"></iframe>
			</form>
		</div>
	</div>
	</nav>


	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="nav-header"
						style="font-size: 18;margin-bottom: 10px;margin-left: 10px"><i
						class="icon-credit-card icon-large"></i>&nbsp;运营功能</li>
					<li ><a href="OrderInfoServlet"><i
							class="icon-money icon-large"></i>&nbsp; 顾客结账界面 <span
							class="sr-only">(current)</span></a></li>


				</ul>
				<ul class="nav nav-sidebar">
					<li class="nav-header"
						style="font-size: 18;margin-bottom: 10px;margin-left: 10px"><i
						class="icon-cog icon-large"></i>&nbsp;餐厅管理</li>
					<li  class="active"><a href="pages/admin/useradmin.jsp"><i
							class="icon-group icon-large"></i>&nbsp;员工管理</a></li>
					<li><a href="pages/admin/dishesadmin.jsp"><i
							class="icon-coffee icon-large"></i>&nbsp;菜品管理</a></li>
					<li><a href="pages/admin/operatedata.jsp"><i
							class="icon-bar-chart icon-large"></i>&nbsp;查看经营数据 </a></li>

				</ul>
			</div>







			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<ol class="breadcrumb">
					<li><a href="OrderInfoServlet">首页</a></li>
					<li>管理员</li>
					<li class="active">员工管理界面</li>
				</ol>






				<div class="panel panel-danger">
					<div class="panel-heading">
						<h3 class="panel-title">员工列表</h3>
					</div>
					<div style="text-align: right;">
						如果您需要在系统中添加一名员工，请点击右边的按钮：<a href="pages/admin/adduser.jsp"
							class="btn btn-success"
							style="width:120px;margin-top: 10px;margin-right: 10px">添加员工</a>
					</div>
					<div class="panel-body">

						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>员工编号</th>
										<th>员工帐号</th>
										<th>员工角色</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="orderTable">

								</tbody>
							</table>

							<nav>
							<ul class="pager" id="pagingDivId">
							</ul>
							</nav>

						</div>

					</div>
				</div>

				<div
					style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
				<footer>
				<p>&copy; ${ORDER_SYS_NAME}-中软国际ETC 2017</p>
				</footer>

			</div>
		</div>
	</div>

	<br>






	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">详细信息</h4>
				</div>
				<div class="modal-body"
					style="background-image: url('img/body-bg.png')">










					<div class="panel panel-danger" style="margin-top: 10px">
						<div class="panel-heading">
							<h3 class="panel-title">员工详情</h3>
						</div>
						<div class="panel-body" style="text-align: center;">

							<img src="#" id="faceimg" width="200px"
								height="200px" class="img-circle"
								style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);" />
							<p><h2>员工帐号：
							
								<span id="userAccount"></span>
							</h2>
							</p>
							<p><h3>
								员工角色：<span id="role"></span></h3>
							</p>


						</div>



					</div>











				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>

				</div>
			</div>
		</div>
	</div>














</body>
</html>
