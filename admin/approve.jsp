<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>申请管理</title>
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
			<button type="button" class="layui-btn layui-btn-normal" style="float:right;margin-right:5%" id="searchapproveorborrow"><i class="layui-icon">&#xe615;</i></button>
			<input type="text" id="searchtext" name="searchtext" required  lay-verify="required" placeholder="请输入要搜索的用户或档案或档案类型" class="layui-input" style="width:20%;float:right;">
		</div>
	</div>
</div>
<table id="approveManage" lay-filter="btn"></table>

</body>
</html>

<script type="text/html" id="barbtn">
<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="pass">同意申请</a>
<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="refuse">拒绝申请</a>
</script>

<script	 type="text/javascript">

layui.use('table', function(){
  var table = layui.table;
  //第一个实例
  table.render({
    elem: '#approveManage'
    ,height: 'full-69'
    ,data: ${requestScope.data}	//传入数据
    ,page: true 	//开启分页
    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
    ,cols: [[ //表头
      {field: 'id', title: 'ID', sort: true, fixed: 'left'}
      ,{field: 'userName', title: '申请者用户名',sort: true}
      ,{field: 'title', title: '申请档案标题',sort: true}
      ,{field: 'author', title: '申请档案作者',sort: true}
      ,{field: 'archivestype', title: '申请档案类型',sort: true}
      ,{field: 'date', title: '申请时间',sort: true}
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
		  
	    if(event === 'pass'){		
			
			layer.confirm('确定同意申请？', function(index){
				var userName = '${requestScope.userName}';
				window.location.href="passorrefuseapprove?id=" + data.id + "&userType=" +${requestScope.userType}+"&userName="+userName+"&pof=pass";
	    	});
	    } else if(event === 'refuse'){	
			
			layer.confirm('确定拒绝申请？', function(index){
				var userName = '${requestScope.userName}';
				window.location.href="passorrefuseapprove?id=" + data.id + "&userType=" +${requestScope.userType}+"&userName="+userName+"&pof=refuse";
	    	});
	    }
	});
  
});

$("#searchapproveorborrow").click(function(){
	var searchtext = $("#searchtext").val()
	if(searchtext==""){
		layer.msg("搜索内容为空");
	}else{
		var userName = '${requestScope.userName}';
		window.location.href="searchapproveorborrow?search=" + searchtext + "&userType=" + ${requestScope.userType} + "&userName="+userName;
	}
});

var layer;
var flag="${requestScope.flag}";
if(flag!=""){
	layer.msg(flag);
} 

</script>