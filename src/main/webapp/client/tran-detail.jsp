<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path +"/";
	pageContext.setAttribute("baseUrl", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员中心-每日扣费详情</title>
<link rel="stylesheet" href="<%=basePath%>css/userstyle.css">
<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.js"></script>
<link href="<%=basePath%>css/WdatePicker.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=basePath%>css/blue.css">
<script type="text/javascript" src="<%=basePath%>js/data.js"></script>
</head>
<body>



	<script type="text/javascript">
</script>
	<div class="mNav">
		<div class="container">
			<ul class="nav_list clearfix">
					<li><span
						style="color: #ffffff; font-size: 16px; padding-left: 10px; padding-top: 10px; line-height: 40px;">
						<a href="<%=basePath%>user/index.action">首页</a>
							&nbsp;&nbsp; 当前用户：<span id="top_lblName">${sessionScope.user.username}</span>
							&nbsp;&nbsp; 余额：<span id="top_lblName">${u.balance }</span>
							&nbsp;&nbsp; 消息：<span id="top_lblName"  >${u.user_msg }</span>
					</span></li>
				</ul>
		</div>
	</div>
	<div class="mMain">
		<div class="container">
			<div class="manage clearfix">
					<div class="side_menu fl">
						<div class="menu-list">
							<h3>关键词管理</h3>
							<ul class="">
								<li><a href="<%=basePath%>user/keyPrice.action?user_id=${sessionScope.user.user_id}" >关键词报价</a></li>
								<li><a href="<%=basePath%>user/keyAdd.action?user_id=${sessionScope.user.user_id}" id="leftmenu_A1">新增关键词</a></li>
								<li><a href="<%=basePath%>user/keyDr.action?user_id=${sessionScope.user.user_id}" id="leftmenu_A2">关键词导入</a></li>
								<li><a href="<%=basePath%>keywords/keywordsListShow.action" id="leftmenu_menukeys">关键词列表</a></li>
							</ul>
						</div>
						<div class="menu-list">
							<h3>统计数据</h3>
							<ul class="">
								<li><a href="<%=basePath%>money/tranDetailList.action" id="leftmenu_menukeyday">每日扣费详情</a></li>
								<li><a href="<%=basePath%>money/tranSerialList.action" id="leftmenu_menuscoreday">消费记录</a></li>
								<li><a href="<%=basePath%>money/tranKeys.action" >关键字扣费详情</a></li>
							</ul>
						</div>
						<div class="menu-list">
							<h3>财务管理</h3>
							<ul class="">
								<li><a href="<%=basePath%>user/rechangeAdd.action?user_id=${sessionScope.user.user_id}" id="leftmenu_menupay">充值</a></li>
								<li><a href="<%=basePath%>money/rechangeList.action" id="leftmenu_menupaylist">充值记录</a></li>
							</ul>
						</div>
						<div class="menu-list">
							<h3>账户管理</h3>
							<ul class="">
								<li><a href="<%=basePath%>user/userDetail.action?user_id=${sessionScope.user.user_id}" id="leftmenu_menuprofile">基本资料</a></li>
								<li><a href="<%=basePath%>user/userUptPwd.action?user_id=${sessionScope.user.user_id}" id="leftmenu_menupass">修改密码</a></li>
								<li><a href="javascript:;" onclick="javascript:LoginOut();">退
										出</a></li>
							</ul>
						</div>
					</div>

				<script type="text/javascript">
						function LoginOut() {
						    if (confirm("您确定要退出吗？")) {
						        location.href="<%=basePath%>user/loginOut.action";
						        }
											}
						function search(currPage) {
							var pl=document.getElementById("pl_txtPage").value; 
							var date = document.getElementById("txtDate").value;
							var pageSize=document.getElementById("pageSize").value;
							if(pl!=""){
								currPage=pl;
							}
							if(date.length!=8){
								alert("日期格式有误");
								return false;
							}
							var url = "<%=basePath%>money/tranDetailList.action?date=" + date+ "&currPage="+currPage+"&pageSize="+pageSize;
							location.href = url;
						}
				</script>
				<div class="tool_main">
					<div class="ce_bread">
						您当前的位置： <a href="<%=basePath%>user/index.action">会员中心</a> <span>&gt;</span> 每日扣费详情
					</div>
					<div class="well">
						当前查询日期：<span style="color: green; font-weight: bold">${date }</span>
					</div>
					<div class="main_center">
						<form  id="form1">
							<div class="control-search">
								<input name="txtDate" id="txtDate" class="control-text"
									onclick="fPopCalendar(event,this,this)" type="text" value="${date }">
								<input class="control-button" value="搜索"
									onclick="javascript:search(1);" type="button">
							</div>
							<table class="table table-striped m-table" cellspacing="0" cellpadding="0" border="0">
								<thead>
									<tr>
										<th style="width: 40px;">标识号</th>
										<th>关键词</th>
										<th>类型</th>
										<th>域名</th>
										<th>最新排名</th>
										<th>消费</th>
										<th>排名情况</th>
										<!--<th>查看</th>-->
									</tr>
								</thead>
								<c:forEach items="${rows}" var="row">
										<tr>
											<td>${row.tran_id }</td>
											<c:if test="${row.search_engines eq '1' }">
											<td><a href="https://www.baidu.com/s?wd=${row.keywords }" target="_blank">${row.keywords }</a></td>
											<td>百度PC</td>
											</c:if>
											<c:if test="${row.search_engines eq '2' }">
											<td><a href="https://m.baidu.com/s?word=${row.keywords }" target="_blank">${row.keywords }</a></td>
											<td>百度手机</td>
											</c:if>
											<c:if test="${row.search_engines eq '3' }">
											<td><a href="https://www.so.com/s?ie=utf-8&shb=1&src=360sou_newhome&q=${row.keywords }" target="_blank">${row.keywords }</a></td>
											<td>360PC</td>
											</c:if>
											<td>${row.domain }</td>
											<td>
											<font color="red">
											<c:if test="${row.xinpai eq '9999' }">--</c:if>
											<c:if test="${row.xinpai eq '10000' }">未收录</c:if>
											<c:if test="${row.xinpai ne '9999' }"><c:if test="${row.xinpai ne '10000' }">${row.xinpai }</c:if></c:if>
											</font>
											</td>
											<td><span style="color: Red">${row.tran_money}</span></td>
											<c:if test="${row.dabiao eq '1' }">
												<td>达标</td>
											</c:if>
											<c:if test="${row.dabiao eq '2' }">
												<td>未达标</td>
											</c:if>
											<!-- 消耗积分 -->
											<!--<td><a href="javascript:view(546);">查看</a></td> -->
										</tr>
								</c:forEach>
							</table>
							<div style="height: 10px;" align="right"><font color="red">总额：${sum_account }元</font></div>
									<!--//页脚：-->
									<div class="pageList">
										<strong
											style="margin-right: 15px; font-size: 14px; font-weight: 700;">总数<font
											color="red">${count }</font>
										</strong> 
											<a class="previousBtn tBtn"
											href="javascript:search(${currPage-1} );">上页</a> 
											<a class="cur" href="javascript:search(${currPage })">${currPage }</a> <a
											class="nextBtn tBtn" href="javascript:search(${currPage+1 });">下页</a> 
											<span class="mr10"> 
											<input name="pl$txtPage" id="pl_txtPage" style="width: 30px;"
											class="isTxtBig w-50" type="text" value=""> 页
											</span> 
											<a id="pl_btnPage" class="de"
											href="javascript:search(${currPage })">Go</a>
											<select name="pageSize" id="pageSize">
												<option  value="10" <c:if test="${pageSize eq '10' }">selected="selected"</c:if>>10</option>
												<option  value="20" <c:if test="${pageSize eq '20' }">selected="selected"</c:if>>20</option>
												<option  value="50" <c:if test="${pageSize eq '50' }">selected="selected"</c:if>>50</option>
											</select>
									</div>
									</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div
		style="display: none; position: fixed; left: 0px; top: 0px; width: 100%; height: 100%; cursor: move; opacity: 0; background: rgb(255, 255, 255) none repeat scroll 0% 0%;"></div>
</body>
</html>