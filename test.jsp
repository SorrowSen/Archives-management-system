<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/layui/css/layui.css"	rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.all.js"></script>
</head>
<body>
<div class="layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">
				<span style="color: #FFFFFF;">档案系统</span>
			</div>
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
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <div title="菜单缩放" class="kit-side-fold"><i class="layui-icon layui-icon-align-center" aria-hidden="true"></i></div>
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="javascript:;"><i class="fa fa-user-circle-o fa-lg"></i> <span >生源追踪</span></a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;"><i class="fa fa-list fa-lg"></i> <span >生源列表</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-clipboard fa-lg"></i> <span >学校信息</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-file-text fa-lg"></i> <span >工做计划</span></a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="fa fa-vcard fa-lg"></i> <span >学员管理</span></a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;"><i class="fa fa-th-list fa-lg"></i> <span >学员列表</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-user-o fa-lg"></i> <span >考勤管理</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-send-o fa-lg"></i> <span >沟通计划</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-frown-o fa-lg"></i> <span >成绩管理</span></a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="fa fa-diamond fa-lg"></i> <span >管理设置</span></a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;"><i class="fa fa-address-book fa-lg"></i> <span >账号管理</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-check-square fa-lg"></i> <span >授权管理</span></a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="fa fa-gear fa-lg"></i> <span >系统管理</span></a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;"><i class="fa fa-window-restore fa-lg"></i> <span >系统信息</span></a></dd>
                    <dd><a href="javascript:;"><i class="fa fa-database fa-lg"></i> <span >操作日志</span></a></dd>
                </dl>
            </li>
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

    layui.use('element', function(){
        var element = layui.element;
 
    });
    var isShow = true;  //定义一个标志位
    $('.kit-side-fold').click(function(){
        //选择出所有的span，并判断是不是hidden
        $('.layui-nav-item span').each(function(){
            if($(this).is(':hidden')){
                $(this).show();
            }else{
                $(this).hide();
            }
        });
        //判断isshow的状态
        if(isShow){
            $('.layui-side.layui-bg-black').width(60); //设置宽度
            $('.kit-side-fold i').css('margin-right', '70%');  //修改图标的位置
            //将footer和body的宽度修改
            $('.layui-body').css('left', 60+'px');
            $('.layui-footer').css('left', 60+'px');
            //将二级导航栏隐藏
            $('dd span').each(function(){
                $(this).hide();
            });
            //修改标志位
            isShow =false;
        }else{
            $('.layui-side.layui-bg-black').width(200);
            $('.kit-side-fold i').css('margin-right', '10%');
            $('.layui-body').css('left', 200+'px');
            $('.layui-footer').css('left', 200+'px');
            $('dd span').each(function(){
                $(this).show();
            });
            isShow =true;
        }
    });
 
</script>