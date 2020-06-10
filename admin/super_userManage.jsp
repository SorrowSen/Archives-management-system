<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理</title>
<link href="${pageContext.request.contextPath}/layui/css/layui.css"	rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.all.js"></script>
<style  type="text/css">
.layui-table, .layui-table-view{
	margin:0;
}
</style>
</head>
<body>
<div style="width:100%;margin-top:15px;">
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button type="button" class="layui-btn layui-btn-normal" style="float:right;margin-right:5%" id="searchuser"><i class="layui-icon">&#xe615;</i></button>
			<input type="text" id="searchtext" name="searchtext" required  lay-verify="required" placeholder="请输入要搜索的用户" class="layui-input" style="width:20%;float:right;">
		</div>
	</div>
</div>
<table id="userManage" lay-filter="btn"></table>

</body>
</html>

<script type="text/html" id="barbtn">
<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="change">权限更改</a>
<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除用户</a>
</script>

<script	 type="text/javascript">

layui.use('table', function(){
  var table = layui.table;
  //第一个实例
  table.render({
    elem: '#userManage'
    ,height: 'full-69'
    ,data: ${requestScope.data}	//传入数据
    ,page: true 	//开启分页
    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
    ,cols: [[ //表头
      {field: 'Id', title: 'ID', sort: true, fixed: 'left'}
      ,{field: 'userName', title: '用户名',sort: true}
      ,{field: 'nickName', title: '昵称', sort: true}
      ,{field: 'userType', title: '用户类型',sort: true} 
      ,{fixed: 'right', align:'left', width:'200', toolbar: '#barbtn'}
    ]]
  });
  
  table.on('tool(btn)', function(obj){
		//获取当前行数据
		var data = obj.data;
		//获取event对应的值
		var event = obj.event;
		//获取当前行的dom对象
		var tr=obj.tr;
		  
	    if(event === 'change'){		//如果点击了更改用户按钮
			//执行查看详情的方法
			layer.confirm('确定修改次用户权限？', function(index){
	        	/* obj.del();
	        	layer.close(index); */
	        	/* var flag = "${sessionScope.data}"; */
				if(data.userType == "管理员"){
					 data.userType = "1"; 
				}else{
					 data.userType = "2"; 
				}
				window.location.href="edituserType?id=" + data.Id + "&userType=" + data.userType;
				/* layer.msg("${requestScope.flag}"); */
	    	});
	    } else if(event === 'del'){	//如果点击了删除按钮
			//执行异步删除方法
			layer.confirm('确定删除此用户？', function(index){
	        	/* obj.del();
	        	layer.close(index); */
	        	/* var flag = "${sessionScope.data}"; */
				window.location.href="deluser?id=" + data.Id + "&userType=" + ${requestScope.userType};
				/* layer.msg("${requestScope.flag}"); */
	    	});
	    }
	});
  
});

$("#searchuser").click(function(){
	var searchtext = $("#searchtext").val()
	if(searchtext==""){
		layer.msg("搜索内容为空");
	}else{
		window.location.href="searchuser?search=" + searchtext + "&userType=" + ${requestScope.userType};
	}
});

var layer;
var flag="${requestScope.flag}";
if(flag!=""){
	layer.msg(flag);
} 

</script>