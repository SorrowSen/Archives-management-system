<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
<link href="${pageContext.request.contextPath}/layui/css/layui.css"	rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.all.js"></script>
<style type="text/css">
blockquote, body, button, dd, div, dl, dt, form, h1, h2, h3, h4, h5, h6, input, li, ol, p, pre, td, textarea, th, ul {
    margin: 10px;
}
.layui-input-block {
    margin-left: 0px;
    min-height: 36px;
}
.layui-input-block{
	margin: 10px;
}
.layui-form select {
    display: block;
}
.loginbox{
    position: absolute;
    left: 50%;
    margin: 125px 0 0 -170.5px;
}
.loginlogo{
	font-size:24px;
	font-weight:bold;
	text-align:center;
	margin-bottom:40px;
}
html {
	height: 100%
}

body {
	margin: 0;
	height: 100%;
	background: #fff;
}
canvas {
	display: block;
	width: 100%;
	height: 100%;
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
.formbox input{
	margin:0px;
}
.formbox tr{
	margin:0px;
}
.formbox td{
	margin:0px;
}
.formbox div{
	margin:0px;
}
</style>
</head>
<body>
<canvas id="canvas" style="position: absolute;"></canvas>
<div class="layui-form loginbox">
	<div class="loginlogo">用户登陆</div>
	<s:form action="checkLogin" method="post">
		<s:textfield name="userName" label="用户名：" class="layui-input"/>
		<s:password name="passWord" label="密码："  class="layui-input"/>
		<s:select label="用户类型：" name="userType" list="#{0:'超级管理员',1:'档案管理员',2:'普通用户'}" headerKey="-1" headerValue="-诸选择-" class="layui-input-block" />
		<s:submit value="登陆" class="layui-btn" style="width:100%"/>
	</s:form>
	<div><a id="forget">忘记密码</a><a id="register" style="float:right">用户注册</a></div>
</div>


</body>
</html>
<script type="text/javascript"> 
var layer;

var msg="${requestScope.Message}";
if(msg!=""){
	layer.msg(msg);
} 

layui.use('form', function(){
	var form = layui.form; 
	form.render();
});

$(function(){
	$("select").hide();
});

$("#register").click(function(){
	layer.open({
        type: 1
        ,title:'用户注册'
        ,content: rof("register")
        ,btnAlign: 'c' //按钮居中
        ,shade: 0 //不显示遮罩
        ,area: '550px'
      });
});

$("#forget").click(function(){
	layer.open({
        type: 1
        ,title:'忘记密码'
        ,content: rof("forget")
        ,btnAlign: 'c' //按钮居中
        ,shade: 0 //不显示遮罩
        ,area: '550px'
      });
	var form = layui.form; 
	form.render();
	$("select").hide();
});

function rof(obj){
	var html = '';
	html += '<div class="formbox layui-form">';
	if(obj == "register"){
		html += '<form theme="xhtml" id="register" name="register" action="register.action" method="post" enctype="multipart/form-data" onsubmit="return checkform(1)">';
		html += '<table class="wwFormTable" style="border-collapse:separate; border-spacing:0px 20px;">';
		html += '<tbody>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="registeruserName" class="layui-form-label">用户名：</label></td>';
		html += '<td><input type="text" name="registeruserName" value="" id="registeruserName" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="registernickName" class="layui-form-label">昵称：</label></td>';
		html += '<td><input type="text" name="registernickName" value="" id="registernickName" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="registerpassword" class="layui-form-label">密码：</label></td>';
		html += '<td><input type="password" name="registerpassword" value="" id="registerpassword" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '<td colspan="2"><div align="right"><input type="submit" id="submitarchivesbtn" value="确定"  class="layui-btn"></div></td>'
		html += '</tr>';
		 	
		html += '</tbody>';
		html += '</table>';
		html += '</form>';
		html += '</div>';
	}
	if(obj == "forget"){
		html += '<form theme="xhtml" id="forget" name="forget" action="forget.action" method="post" enctype="multipart/form-data" onsubmit="return checkform(forget)">';
		html += '<table class="wwFormTable" style="border-collapse:separate; border-spacing:0px 20px;">';
		html += '<tbody>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="forgetuserName" class="layui-form-label">用户名：</label></td>';
		html += '<td><input type="text" name="forgetuserName" value="" id="forgetuserName" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="forgetpassword" class="layui-form-label">密码：</label></td>';
		html += '<td><input type="password" name="forgetpassword" value="" id="forgetassword" class="layui-input"></td>';
		html += '</tr>';
		
		html += '<tr class="layui-form-item">';
		html += '<td class="tdLabel"><label for="forgetq" class="layui-form-label">安全问题：</label></td>';
		html += '<td><select name="forgetq" id="forgetq" class="layui-input-block">';
		html += '<option value="-1">-请选择-</option>';
	    html += '<option value="0">第一个小学</option>';
	    html += '<option value="1">最喜欢的歌曲</option>';
	    html += '<option value="2">父母姓名</option>';
		html += '</select></td>';
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
	if(obj=="1"){
		var userName = $("#registeruserName").val();
		var nickName = $("#registernickName").val();
		var passWord = $("#registerpassword").val();
		var regex = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z]).{8,30}');
		var check = '';
		if(userName == "" || nickName == "" || passWord == ""){
			if(userName == ""){
				check += '请输入用户名 ';
			}
			if(nickName == ""){
				check += '请输入昵称 ';
			}
			if(passWord == ""){
				check += '请输入密码  ';
			}
			layer.msg(check);
			return false;
		}else if(!regex.test(passWord)){
			layer.msg("您的密码复杂度太低（密码中必须包含字母、数字，至少8个字符，最多30个字符），请换个密码！");
			return false;
		}else{
			return true;
		}
	}
}

class Circle {
  //创建对象
  //以一个圆为对象
  //设置随机的 x，y坐标，r半径，_mx，_my移动的距离
  //this.r是创建圆的半径，参数越大半径越大
  //this._mx,this._my是移动的距离，参数越大移动
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.r = Math.random() * 10;
    this._mx = Math.random();
    this._my = Math.random();

  }

  //canvas 画圆和画直线
  //画圆就是正常的用canvas画一个圆
  //画直线是两个圆连线，为了避免直线过多，给圆圈距离设置了一个值，距离很远的圆圈，就不做连线处理
  drawCircle(ctx) {
    ctx.beginPath();
    //arc() 方法使用一个中心点和半径，为一个画布的当前子路径添加一条弧。
    ctx.arc(this.x, this.y, this.r, 0, 360)
    ctx.closePath();
    ctx.fillStyle = 'rgba(204, 204, 204, 0.3)';
    ctx.fill();
  }

  drawLine(ctx, _circle) {
    let dx = this.x - _circle.x;
    let dy = this.y - _circle.y;
    let d = Math.sqrt(dx * dx + dy * dy)
    if (d < 150) {
      ctx.beginPath();
      //开始一条路径，移动到位置 this.x,this.y。创建到达位置 _circle.x,_circle.y 的一条线：
      ctx.moveTo(this.x, this.y); //起始点
      ctx.lineTo(_circle.x, _circle.y); //终点
      ctx.closePath();
      ctx.strokeStyle = 'rgba(204, 204, 204, 0.3)';
      ctx.stroke();
    }
  }

  // 圆圈移动
  // 圆圈移动的距离必须在屏幕范围内
  move(w, h) {
    this._mx = (this.x < w && this.x > 0) ? this._mx : (-this._mx);
    this._my = (this.y < h && this.y > 0) ? this._my : (-this._my);
    this.x += this._mx / 2;
    this.y += this._my / 2;
  }
}

//鼠标点画圆闪烁变动
class currentCirle extends Circle {
  constructor(x, y) {
    super(x, y)
  }

  drawCircle(ctx) {
    ctx.beginPath();
    //注释内容为鼠标焦点的地方圆圈半径变化
    //this.r = (this.r < 14 && this.r > 1) ? this.r + (Math.random() * 2 - 1) : 2;
    this.r = 8;
    ctx.arc(this.x, this.y, this.r, 0, 360);
    ctx.closePath();
    //ctx.fillStyle = 'rgba(0,0,0,' + (parseInt(Math.random() * 100) / 100) + ')'
    ctx.fillStyle = 'rgba(255, 77, 54, 0.6)'
    ctx.fill();

  }
}

//更新页面用requestAnimationFrame替代setTimeout
window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

let canvas = document.getElementById('canvas');
let ctx = canvas.getContext('2d');
let w = canvas.width = canvas.offsetWidth;
let h = canvas.height = canvas.offsetHeight;
let circles = [];
let current_circle = new currentCirle(0, 0)

let draw = function() {
  ctx.clearRect(0, 0, w, h);
  for (let i = 0; i < circles.length; i++) {
    circles[i].move(w, h);
    circles[i].drawCircle(ctx);
    for (j = i + 1; j < circles.length; j++) {
      circles[i].drawLine(ctx, circles[j])
    }
  }
  if (current_circle.x) {
    current_circle.drawCircle(ctx);
    for (var k = 1; k < circles.length; k++) {
      current_circle.drawLine(ctx, circles[k])
    }
  }
  requestAnimationFrame(draw)
}

let init = function(num) {
  for (var i = 0; i < num; i++) {
    circles.push(new Circle(Math.random() * w, Math.random() * h));
  }
  draw();
}

window.addEventListener('load', init(60));

window.onmousemove = function(e) {
  e = e || window.event;
  current_circle.x = e.clientX;
  current_circle.y = e.clientY;
}

window.onmouseout = function() {
  current_circle.x = null;
  current_circle.y = null;
}
</script>