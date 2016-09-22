<%@page import="tw.iii.qr.DataBaseConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.util.*,tw.iii.qr.QRAccount" %>	
<jsp:useBean id="getaccount" class="tw.iii.qr.QRAccountFactory"  scope="page"/>
<!doctype html>

<html>
<head>
<meta charset="utf-8">
<title>修改員工帳號</title>
</head>
<body>
<%@ include file="/href/navbar.jsp" %>

<div class="nav">
  <div class="container">
    <div class="navbar-left" style="background-color:#C7AAE4;" >
      <ul class="nav nav-tabs">
        <li><a href="./accountManage.jsp" style="color:#fff">員工帳號管理</a></li>
      </ul>
    </div>
  </div>
  <div class="container">
    <div class="nav" style="background-color:#984AC0;" >
      <ul class="nav nav-tabs">
        <li><a href="./accountManage.jsp" style="color: #fff">員工帳號管理</a></li>
        <li><a href="./Account.jsp">新增員工帳號</a></li>
      </ul>
    </div>
  </div>
</div>
  
<div class="container container-fluid breadcrumbBox">
  <ol class="breadcrumb" >
    <li><a href="../HomePage.jsp" >首頁</a></li>
    <li class="active"><a href="./accountManage.jsp">員工帳號管理</a></li>
    <li><a href="./Account.jsp">新增員工帳號</a></li>
  </ol>
</div>
<%
request.setCharacterEncoding("UTF-8");
String account1 = request.getParameter("p");

System.out.println(account1);   
System.out.println(request.getParameter("p"));
if(!"".equals(account1) || account1 != null){
Connection conn = new DataBaseConn().getConn();

QRAccount accountinfo  = getaccount.searchDetail(account1);
session.setAttribute("accountinfo", accountinfo);
System.out.println(accountinfo.getAccount());
}
%>  

<div class="container" style="background: #E9C2D0; border-radius:20px;">
  <form name="searchform" method="post" action="QRAccountServlet.do" class="form-inline container required" 
  	style="font-size: 100%; vertical-align: baseline; padding: 15px; ">
    <fieldset id="myfields" class="font-weight" style="padding:0 30px 0 0;">
      <legend>帳號修改</legend>
      <div class="container-fluid form-horizontal">
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>帳號資訊</h4>
          </div>
          <div class="col-md-5 well-sm">
            <input class="form-control" name="account" type="text" value="${accountinfo.getAccount()}" readonly>
          </div>
        </div>
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>密碼</h4>
          </div>
          <div class="col-md-5 well-sm">
            <input class="form-control" name="password" type="password" value="${accountinfo.getPassword()}">
          </div>
        </div>
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>姓氏</h4>
          </div>
          <div class="col-md-5 well-sm">
            <input class="form-control" name="lastName" type="text" value="${accountinfo.getLastName()}">
          </div>
        </div>
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>名字</h4>
          </div>
          <div class="col-md-5 well-sm">
            <input class="form-control" name="firstName" type="text" value="${accountinfo.getFirstName()}">
          </div>
        </div>
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>E-mail</h4>
          </div>
          <div class="col-md-5 well-sm">
            <input class="form-control" name="E-mail" type="text" value="${accountinfo.getEmail()}">
          </div>
        </div>
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>英文名字</h4>
          </div>
          <div class="col-md-5 well-sm">
            <input class="form-control" name="enName" type="text" value="${accountinfo.getEnName()}">
          </div>
        </div>
        
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>權限等級</h4>
          </div>
           <div class="col-md-5 well-sm">
            <select class="form-control" name="CompetenceLv" >
              <c:forEach var="i" varStatus="check" items="${getCompetenceLv}" begin="0" step="1">
                <option  value="${i.getCompetenceLv()}">${i.getCompetenceLv()}</option>
              </c:forEach>
            </select>
          </div>
        </div>
        
        
        <div class="row">
          <div class="col-md-3 text-right well-sm label-tag"  >
            <h4>帳號狀態</h4>
          </div>
          <div class="col-md-5 well-sm">           
            <c:if test="${accountinfo.getstatus() eq 'ON' }"> 
              	<input type="radio" id="id_fd-is_active_0" value="ON" name="status" checked/> 有效
          	  	<input type="radio" id="id_fd-is_active_0" value="OFF" name="status"/> 停用
           	</c:if>          
            <c:if test="${accountinfo.getstatus() eq 'OFF' }"> 
                <input type="radio" id="id_fd-is_active_0" value="ON" name="status"/> 有效
          	    <input type="radio" id="id_fd-is_active_0" value="OFF" name="status" checked/> 停用
            </c:if>
          </div>
        </div>
        
        
        <div class="" align="center">
          <button type="submit" name="submit" value="editAccount" class="btn-lg btn-success">修改送出</button>
          <td><a href="accountManage.jsp">
            <input type="button" value="取消" class="btn-lg btn-success">
            </a></td>
        </div>
      </div>
    </fieldset>
  </form>
</div>
<%@ include file="/href/footer.jsp" %>
</body>
</html>
