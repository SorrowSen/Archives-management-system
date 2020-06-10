<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<link href="${pageContext.request.contextPath}/layui/css/layui.css"	rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.all.js"></script>
<style  type="text/css">
/* input,select{
    margin: 10px;
} */
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
.layui-form-select dl{
	max-height:140px;
}
</style>
</head>
<body>
<div style="width:100%;margin-top:15px;">
	<div class="layui-form-item">
		<div class="layui-input-block" id="bartop">
			<button type="button" class="layui-btn layui-btn-normal" style="float:right;margin-right:5%" id="searcharchives"><i class="layui-icon">&#xe615;</i></button>
			<input type="text" id="searchtext" name="searchtext" required  lay-verify="required" placeholder="请输入要搜索的档案" class="layui-input" style="width:20%;float:right;">
		</div>
	</div>
</div>
<table id="archivesManage" lay-filter="btn"></table>

</body>
</html>

<script type="text/html" id="barbtn">
{{#  if(d.userType == 2){ }}
	<a class="layui-btn layui-btn-xs" lay-event="apply">申请借阅</a>
{{#  } }}
{{#  if(d.userType != 2){ }}
	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="check">查看</a>
	<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
{{#  } }}
</script>

<script type="text/html" id="toolbarDemo">
</script>

<script	 type="text/javascript">
layui.use('element');

layui.use(['table','form'], function(){
  var table = layui.table;
  var form = layui.form;
  //第一个实例
  table.render({
    elem: '#archivesManage'
    ,height: 'full-69'
    ,data: ${requestScope.data}	//传入数据
    ,page: true 	//开启分页
    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
    ,cols: [[ //表头
      {field: 'Id', title: 'ID', sort: true, fixed: 'left'}
      ,{field: 'title', title: '标题',sort: true}
      ,{field: 'archivesType', title: '档案类型',sort: true} 
      ,{field: 'author', title: '作者',sort: true} 
      ,{field: 'date', title: '上传时间',sort: true} 
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
		
		if(event == 'apply'){
			var userName = '${requestScope.userName}';
        	var archivesType = '${requestScope.archivesType}';
			window.location.href="applyarchives?id=" + data.Id + "&archivesType="+ archivesType + "&userType=" +${requestScope.userType} +"&userName="+userName;
		}else if(event == 'check'){
			window.location.href="checkarchives?title="+data.title;
			/* window.location.href="checkarchives?title="+ data.title; */
		} else if(event === 'edit'){		//如果点击了编辑按钮
			//执行查看详情的方法
			/* window.location.href="edituserType?id=" + data.Id + "&userType=" + data.userType; */
			layer.open({
		        type: 1
		        ,title:'编辑档案'
		        ,content: addoredit("edit")
		        /* ,btn: ['确定', '取消'] */
		        ,btnAlign: 'c' //按钮居中
		        ,shade: 0 //不显示遮罩
		        ,area: '550px'
		      });
			
			$("#archivesid").val(data.Id);
			$("#title").val(data.title);
			$("#author").val(data.author);
			$("select option[value='"+data.archivesType+"']").attr("selected","selected");
			
	    } else if(event === 'del'){	//如果点击了删除按钮
			//执行异步删除方法
			layer.confirm('确定删除此档案？', function(index){
	        	/* obj.del();
	        	layer.close(index); */
	        	/* var flag = "${sessionScope.data}"; */
	        	var archivesType = '${requestScope.archivesType}';
				window.location.href="delarchives?id=" + data.Id + "&archivesType=" + archivesType + "&userType=" +${requestScope.userType};
				/* layer.msg("${requestScope.flag}"); */
	    	});
	    }
		form.render();
	});
  
});
/* 搜索 */
$("#searcharchives").click(function(){
	var searchtext = $("#searchtext").val()
	if(searchtext==""){
		layer.msg("搜索内容为空");
	}else{
		var archivesType = '${requestScope.archivesType}';
		window.location.href="searcharchives?search=" + searchtext + "&userType=" + ${requestScope.userType} + "&archivesType=" +archivesType;
	}
});
/* 提示 */
var layer;
var flag="${requestScope.flag}";
if(flag!=""){
	layer.msg(flag);
}

$(function(){
		
	if(${requestScope.userType}!=2){
		$("#bartop").prepend('<div class="layui-btn-group"><button type="button" class="layui-btn layui-btn-sm" id="btn-add"><i class="layui-icon">&#xe608;</i> 添加</button></div>');
	}
	
	$("#btn-add").click(function(){
		layer.open({
	        type: 1
	        ,title:'添加档案'
	        ,content: addoredit("add")
	        ,btnAlign: 'c' //按钮居中
	        ,shade: 0 //不显示遮罩
	        ,area: '550px'
	      });

		
		layui.use('form', function(){
			var form = layui.form;  
			var upload = layui.upload;
	        var $ = layui.jquery;
			form.render(); 
			
		});
	});
})

function addoredit(obj){
	
	var html = '';
	
	html += '<div class="formbox layui-form">';
	if(obj == "edit"){
		html += '<form theme="xhtml" id="editarchives" name="editarchives" action="editarchives.action" method="post" enctype="multipart/form-data" onsubmit="return checkform()">';
	}
	if(obj == "add"){
		html += '<form theme="xhtml" id="addarchives" name="addarchives" action="addarchives.action" method="post" enctype="multipart/form-data" onsubmit="return checkform()">';
	}
	html += '<table class="wwFormTable" style="border-collapse:separate; border-spacing:0px 20px;">';
	html += '<tbody>';
	
	html += '<tr class="layui-form-item" hidden="hidden">';
	html += '<td class="tdLabel"><label for="archivesid" class="layui-form-label">id：</label></td>';
	html += '<td><input type="text" name="archivesid" value="" id="archivesid" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item" style="margin-bottom:20px">';
	html += '<td class="tdLabel"><label for="title" class="layui-form-label">标题：</label></td>';
	html += '<td><input type="text" name="title" value id="title" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item">';
	html += '<td class="tdLabel"><label for="author" class="layui-form-label">作者：</label></td>';
	html += '<td><input type="text" name="author" value id="author" class="layui-input"></td>';
	html += '</tr>';

	html += '<tr class="layui-form-item">';
	html += '<td class="tdLabel"><label for="archivesType" class="layui-form-label">档案类型：</label></td>';
	html += '<td><select name="archivesType" id="archivesType" class="layui-input-block">';
	html += '<option value="-1">-请选择-</option>';
	$("#archives>dd>a", parent.document).each(function(){
		if($(this).text() != "全部"){
        	html += '<option value="'+$(this).text()+'">'+$(this).text()+'</option>';
		}
    });
	html += '</select></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item" hidden="hidden">';
	html += '<td class="tdLabel"><label for="userType" class="layui-form-label">用户类型：</label></td>';
	html += '<td><input type="text" name="userType" value="${requestScope.userType}" id="userType" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item" hidden="hidden">';
	html += '<td class="tdLabel"><label for="inarchivesType" class="layui-form-label">所在档案：</label></td>';
	html += '<td><input type="text" name="inarchivesType" value="${requestScope.archivesType}" id="inarchivesType" class="layui-input"></td>';
	html += '</tr>';
	
	html += '<tr class="layui-form-item">';
	html += '<td class="tdLabel"><label for="addfile" class="layui-form-label">文件上传：</label></td>';
	html += '<td><input type="file" name="file" value id="file"></td>';
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

function checkform(){
    var title = $("#title").val();
    var author = $("#author").val();
    var archivesType = $("#archivesType option:selected").val();
	var file = $("#file").val();
	var check = "";
	
	if(title == "" || author == "" || archivesType == "-请选择-" || file == "" || file == null){
		if(title == ""){
			check += '请输入标题 ';
		}
		if(author == ""){
			check += '请输入作者 ';
		}
		if(archivesType == "-1"){
			check += '请选择档案类型 ';
		}
		if(file == "" || file == null){
			check += '请选择上传文件 ';
		}
		layer.msg(check);
		return false;
	}
	return true;
}
</script>