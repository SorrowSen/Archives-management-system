<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>档案管理系统</title>
<link href="${pageContext.request.contextPath}/layui/css/layui.css"	rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<style type="text/css">
.layui-body{
	overflow-y:hidden;
}

.layui-header .layui-nav {
	padding: 0 60px;
}

.layui-layout-admin .layui-body {
	bottom: 0px;
}

.layui-side-menu, .layadmin-pagetabs .layui-tab-title li:after,
	.layadmin-pagetabs .layui-tab-title li.layui-this:after,
	.layui-layer-admin .layui-layer-title, .layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-item>.layui-nav-child
	{
	background-color: #20222A !important;
}
.wwFormTable{
	width:100%;
}
.formbox{
	margin-top: 30px;
	margin-bottom:30px;
    width: 70%;
    margin-left: 15%;
}
.layui-icon{
color: #FFF;
font-size: 30px; 
}
</style>
</head>
<body>
	<div class="layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">
				<span style="color: #FFFFFF;">档案系统</span>
			</div>
			<div title="菜单缩放" class="kit-side-fold"><i class="layui-icon  layui-icon-shrink-right" style="line-height:60px;font-size:20px;padding-left:220px" aria-hidden="true"></i></div>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="#">${requestScope.nickName}</a>
					<dl class="layui-nav-child">
						<dd>
							<a id="ci">修改信息</a>
						</dd>
						<dd>
							<a id="cp">修改密码</a>
						</dd>
						<a href="loginout.jsp">退了</a>
					</dl>
				</li>
			</ul>
		</div>
		<div class="layui-side layui-side-menu">
			<div class="layui-side-scroll">
				
				<ul class="layui-nav layui-nav-tree" lay-shrink="all" lay-filter="layadmin-system-side-menu">
					<li class="layui-nav-item">
						<a href="javascript:;"><i class="layui-icon layui-icon-read" style="display:none"></i><span>档案目录</span></a>
						<dl class="layui-nav-child" id="archives">
							<dd><a href="archivesManage?archivesType=all&userType=${requestScope.userType}&userName=${requestScope.userName}" target="right"><span>全部</span></a></dd>
						</dl>
					</li>
					<c:if test="${requestScope.userType==0}">
						<li class="layui-nav-item"><a href="userManage?userType=${requestScope.userType}" target="right"><i class="layui-icon layui-icon-user" style="display:none"></i><span>人员信息管理</span></a></li>
					</c:if>
					<c:if test="${requestScope.userType!=2}">
						<li class="layui-nav-item"><a href="archivesTypeManage?userType=${requestScope.userType}" target="right"><i class="layui-icon layui-icon-file-b" style="display:none"></i><span>类目管理</span></a></li>
						<li class="layui-nav-item"><a href="approve?userType=${requestScope.userType}&userName=${requestScope.userName}"  target="right"><i class="layui-icon layui-icon-email" style="display:none"></i><span>档案借阅审批管理</span></a></li>
					</c:if>
					<c:if test="${requestScope.userType==2}">
						<li class="layui-nav-item"><a href="borrow?userType=${requestScope.userType}&userName=${requestScope.userName}"  target="right"><i class="layui-icon layui-icon-log" style="display:none"></i><span>我的借阅记录</span></a></li>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="layui-body">
			<iframe id="iframeRight" style="width: 100%" ; height="100%" name="right"></iframe>
		</div>
	</div>
</body>
</html>
<script>

var layer;

$(function(){
	var arr = ${requestScope.archivesType};
	var userName = "${requestScope.userName}";
	for(i=0;i<arr.length;i++){
		$("#archives").append("<dd><a href='archivesManage?archivesType="+arr[i]+"&userType="+${requestScope.userType}+"&userName="+userName+"' target='right'><span>" + arr[i] + "</span></a></dd>");
		layui.use('element');
	}
	$('.layui-nav-child>dd').click(function(){
		$(".layui-nav-child>dd").removeClass("layui-this");
		$(".layui-nav-item").removeClass("layui-this");
		$(this).addClass("layui-this");
	});
})

	
layui.use('form', function(){
	var form = layui.form; 
	form.render();
});


$("#ci").click(function(){
	layer.open({
        type: 1
        ,title:'修改信息'
        ,content: iop("i")
        ,btnAlign: 'c' //按钮居中
        ,shade: 0 //不显示遮罩
        ,area: '550px'
      });
	var userid = "${requestScope.Id}";
	$("#id").val(userid);
});

$("#cp").click(function(){
	layer.open({
        type: 1
        ,title:'修改密码'
        ,content: iop("p")
        ,btnAlign: 'c' //按钮居中
        ,shade: 0 //不显示遮罩
        ,area: '550px'
      });
	var userid = "${requestScope.Id}";
	$("#id").val(userid);
});

function iop(obj){
	var html = '';
	html += '<div class="formbox layui-form">';
	if(obj == "i"){
		html += '<form theme="xhtml" id="ci" name="ci" action="ci.action" method="post" enctype="multipart/form-data" onsubmit="return checkform(1)">';
		html += '<table class="wwFormTable" style="border-collapse:separate; border-spacing:0px 20px;">';
		html += '<tbody>';
		
		html += '<tr class="layui-form-item" hidden="hidden">';
		html += '<td class="tdLabel"><label for="id" class="layui-form-label">id：</label></td>';
		html += '<td><input type="text" name="id" value="" id="id" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="inickName" class="layui-form-label">昵称：</label></td>';
		html += '<td><input type="text" name="inickName" value="" id="inickName" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '<td colspan="2"><div align="right"><input type="submit" id="submitarchivesbtn" value="确定"  class="layui-btn"></div></td>'
		html += '</tr>';
		 	
		html += '</tbody>';
		html += '</table>';
		html += '</form>';
		html += '</div>';
	}
	if(obj == "p"){
		html += '<form theme="xhtml" id="cp" name="cp" action="cp.action" method="post" enctype="multipart/form-data" onsubmit="return checkform(2)">';
		html += '<table class="wwFormTable" style="border-collapse:separate; border-spacing:0px 20px;">';
		html += '<tbody>';
		
		html += '<tr class="layui-form-item" hidden="hidden">';
		html += '<td class="tdLabel"><label for="id" class="layui-form-label">id：</label></td>';
		html += '<td><input type="text" name="id" value="" id="id" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="oldpassword" class="layui-form-label">旧密码：</label></td>';
		html += '<td><input type="password" name="oldpassword" value="" id="oldpassword" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="newpassword" class="layui-form-label">新密码：</label></td>';
		html += '<td><input type="password" name="newpassword" value="" id="newpassword" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="cnewpassword" class="layui-form-label">再次输入密码：</label></td>';
		html += '<td><input type="password" name="cnewpassword" value="" id="cnewpassword" class="layui-input"></td>';
		html += '</tr>';
		
		
		html += '<tr>';
		html += '<td colspan="2"><div align="right"><input type="submit" id="submitarchivesbtn" value="确定"  class="layui-btn"></div></td>'
		html += '</tr>';
		 	
		html += '</tbody>';
		html += '</table>';
		html += '</form>';
		html += '</div>';
	}
	
	return html;
}

function checkform(obj){
	if(obj == "1"){
		var inickName = $("#inickName").val();
		if(inickName == ""){
			layer.msg("请输入昵称");
			return false;
		}else{
			return true;
		}
	}else{
		var oldpassword = $("#oldpassword").val();
		var newpassword = $("#newpassword").val();
		var cnewpassword = $("#cnewpassword").val();
		var regex = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z]).{8,30}');
		if(oldpassword == "" || newpassword=="" || cnewpassword == ""){
			var check = "";
			if(oldpassword == ""){
				check += "请输入旧密码 ";
			}
			if(newpassword == ""){
				check += "请输入新密码 ";
			}
			if(cnewpassword == ""){
				check += "请再次新密码 ";
			}
			
			layer.msg(check);
			return false;
		}else if(newpassword != cnewpassword){
			layer.msg("两次输入的密码不相同！");
			return false;
		}else if(!regex.test(newpassword)){
			layer.msg("您的密码复杂度太低（密码中必须包含字母、数字，至少8个字符，最多30个字符），请换个密码！");
			return false;
		}else{
			return true;
		}
	}
}

</script>

<script src="${pageContext.request.contextPath}/layui/layui.all.js"></script>
<script>
var msg= "${requestScope.Message}";
if(msg!=""){
	layer.msg(msg);
} 
</script>
<script>

    /* layui.use('element', function(){
        var element = layui.element;
 
    }); */
    var isShow = true;  //定义一个标志位
    $('.kit-side-fold').click(function(){
        //选择出所有的span，并判断是不是hidden
        $('.layui-side-menu span').each(function(){
            if($(this).is(':hidden')){
                $(this).show();
            }else{
                $(this).hide();
            }
        });
        //判断isshow的状态
        if(isShow){
            //将二级导航栏隐藏
            $('dd span').each(function(){
                $(this).hide();
            });
            $('.layui-body').animate({left:'80'},350);
            $('.layui-footer').animate({left:'80'},350);
            $('.layui-side-menu').animate({width:'80'},350);
            $('.kit-side-fold .layui-icon').removeClass('layui-icon-shrink-right');
            $('.kit-side-fold .layui-icon').addClass('layui-icon-spread-left');
            $('#archives dd').hide();
            $('.layui-side-menu i').show();
	    //如果鼠标经过则展开
	    $(".layui-side-menu").hover(function(){
	    	$('dd span').each(function(){
                	$(this).show();
            	});
            	$('.layui-body').animate({left:'200'},350);
            	$('.layui-footer').animate({left:'200'},350);
            	$('.layui-side-menu').animate({width:'200'},350);
            	$('#archives dd').show();
            	$('.layui-side-menu i').hide();
		$('.layui-side-menu span').each(function(){
            	    	$(this).show();
		});
	    },function(){
	    	$('dd span').each(function(){
                	$(this).hide();
            	});
                $('.layui-body').animate({left:'80'},350);
            	$('.layui-footer').animate({left:'80'},350);
            	$('.layui-side-menu').animate({width:'80'},350);
            	$('#archives dd').hide();
            	$('.layui-side-menu i').show();
		$('.layui-side-menu span').each(function(){
            	    	$(this).hide();
        	});
	    });
            //修改标志位
            isShow =false;
        }else{
            $('dd span').each(function(){
                $(this).show();
            });
            $('.layui-body').animate({left:'200'},350);
            $('.layui-footer').animate({left:'200'},350);
            $('.layui-side-menu').animate({width:'200'},350);
            $('.kit-side-fold .layui-icon').removeClass('layui-icon-spread-left');
            $('.kit-side-fold .layui-icon').addClass('layui-icon-shrink-right');
            $('#archives dd').show();
            $('.layui-side-menu i').hide();
	    $('.layui-side-menu').unbind('mouseenter').unbind('mouseleave');
            isShow =true;
        }
    });
 
</script>