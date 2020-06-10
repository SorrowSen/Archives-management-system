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
.formbox{
	margin-top: 30px;
	margin-bottom:30px;
    width: 70%;
    margin-left: 15%;
}
.wwFormTable{
	width:100%;
}
</style>
</head>
<body>
<div style="width:100%;margin-top:15px;">
	<div class="layui-form-item">
		<div class="layui-input-block">
			<div class="layui-btn-group"><button type="button" class="layui-btn layui-btn-sm" id="btn-add"><i class="layui-icon">&#xe608;</i> 添加</button></div>
			<button type="button" class="layui-btn layui-btn-normal" style="float:right;margin-right:5%" id="searcharchivesType"><i class="layui-icon">&#xe615;</i></button>
			<input type="text" id="searchtext" name="searchtext" required  lay-verify="required" placeholder="请输入要搜索的档案类型" class="layui-input" style="width:20%;float:right;">
		</div>
	</div>
</div>
<table id="archivesTypeManage" lay-filter="btn"></table>

</body>
</html>

<script type="text/html" id="barbtn">
<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script	 type="text/javascript">

/* 列表  */
layui.use('table', function(){
  var table = layui.table;
  //第一个实例
  table.render({
    elem: '#archivesTypeManage'
    ,height: 'full-69'
    ,data: ${requestScope.data}	//传入数据
    ,page: true 	//开启分页
    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
    ,cols: [[ //表头
        {field: 'Id', title: 'ID', sort: true, fixed: 'left'}
		,{field: 'archivesType', title: '档案类型',sort: true} 
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
		  
	    if(event === 'edit'){		//如果点击了更改用户按钮
			//执行查看详情的方法
	    	layer.open({
		        type: 1
		        ,title:'编辑档案类目'
		        ,content: addoredit("edit")
		        /* ,btn: ['确定', '取消'] */
		        ,btnAlign: 'c' //按钮居中
		        ,shade: 0 //不显示遮罩
		        ,area: '550px'
		      });
	    	$("#archivesTypeid").val(data.Id);
	    	$("#archivesType").val(data.archivesType);
	    
	    } else if(event === 'del'){	//如果点击了删除按钮
			//执行异步删除方法
			layer.confirm('确定删除此档案类目？', function(index){
				window.location.href="delarchivesType?archivesTypeid=" + data.Id + "&userType=" +${requestScope.userType};
	    	});
	    }
	});
  
});

/* 搜索 */
$("#searcharchivesType").click(function(){
	var searchtext = $("#searchtext").val()
	if(searchtext==""){
		layer.msg("搜索内容为空");
	}else{
		window.location.href="searcharchivesType?search=" + searchtext + "&userType=" + ${requestScope.userType};
	}
});

/* 提示窗 */
var layer;
var flag="${requestScope.flag}";
if(flag!=""){
	layer.msg(flag);
} 

$(function(){
	$("#btn-add").click(function(){
		layer.open({
	        type: 1
	        ,title:'添加档案类目'
	        ,content: addoredit("add")
	        ,btnAlign: 'c' //按钮居中
	        ,shade: 0 //不显示遮罩
	        ,area: '550px'
	      });
			
		});
})

/* 添加删除弹窗 */
function addoredit(obj){
	
	var html = '';
	
	html += '<div class="formbox layui-form">';
	if(obj == "edit"){
		html += '<form theme="xhtml" id="editarchivesType" name="editarchivesType" action="editarchivesType.action" method="post" enctype="multipart/form-data" onsubmit="return checkform()">';
	}
	if(obj == "add"){
		html += '<form theme="xhtml" id="addarchivesType" name="addarchivesType" action="addarchivesType.action" method="post" enctype="multipart/form-data" onsubmit="return checkform()">';
	}
	html += '<table class="wwFormTable" style="border-collapse:separate; border-spacing:0px 20px;">';
	html += '<tbody>';
	
	html += '<tr class="layui-form-item" hidden="hidden">';
	html += '<td class="tdLabel"><label for="archivesTypeid" class="layui-form-label">id：</label></td>';
	html += '<td><input type="text" name="archivesTypeid" value="" id="archivesTypeid" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item">';
	html += '<td class="tdLabel"><label for="archivesType" class="layui-form-label">档案类型：</label></td>';
	html += '<td><input type="text" name="archivesType" value="" id="archivesType" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item" hidden="hidden">';
	html += '<td class="tdLabel"><label for="userType" class="layui-form-label">用户类型：</label></td>';
	html += '<td><input type="text" name="userType" value="${requestScope.userType}" id="userType" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr>';
	html += '<td colspan="2"><div align="right"><input type="submit" id="submitarchivesbtn" value="确定"  class="layui-btn"></div></td>'
	html += '</tr>';
	 	
	html += '</tbody>';
	html += '</table>';
	html += '</form>';
	html += '</div>';
	
	return html;
}
/* 检查表单 */
function checkform(){
    var archivesType = $("#archivesType").val();
	
	if(archivesType == ""){
		layer.msg("档案类型不能为空！");
		return false;
	}
	return true;
}
</script>