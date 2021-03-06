<%@page import="tw.iii.qr.order.DTO.COrderDetail"%>
<%@page import="tw.iii.qr.order.DTO.COrders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.util.*,tw.iii.qr.stock.DTO.CProduct" %>
<%@page import="tw.iii.qr.DataBaseConn"%>
<jsp:useBean id="COrderFactory" class="tw.iii.qr.order.COrderFactory" scope="page" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>訂單內容</title>
</head>
<body>
  <%@ include file ="/href/navbar.jsp" %>
<c:if test="${PageCompetence.getOrdersManage() == 0 }">  
<% response.sendRedirect("/HomePage.jsp"); %>   
</c:if>
<%
String QR_id ;
request.setCharacterEncoding("UTF-8");
if(request.getParameter("QR_id") != null || request.getParameter("QR_id") != ""){
Connection conn = new DataBaseConn().getConn();
QR_id = request.getParameter("QR_id");
COrders searchResult = COrderFactory.getOrderAllInfo(QR_id,conn);
session.setAttribute("result", searchResult);
LinkedList<COrderDetail> resultDetail = COrderFactory.getOrderDetails(QR_id,conn);
session.setAttribute("resultDetail", resultDetail);
conn.close();
}else {
	response.sendRedirect("QROrders/SearchOrder.jsp");	
}
%>
 <div class="nav">
  <div class="container">
    <div class="navbar-left" style="background-color:#F3CE9A;" >
      <ul class="nav nav-tabs">
        <li class="" style="background-color:#A45A21"><a href="SearchOrder.jsp" style="color:#FFFFFF">訂單管理</a></li>
        <c:if test="${PageCompetence.getEntireOrders() == 1 }"> 
        	<li><a href="DayliBalanceSheet.jsp" >日結表</a></li>
      	</c:if>
      </ul>
    </div>
  </div>
  <div class="container">
    <div class="nav" style="background-color:#A45A21;" >
      <ul class="nav nav-tabs">
        <li><a href="SearchOrder.jsp?begin=0&end=10">查詢訂單</a></li>
        <li><a href="OrderProcessingPage.jsp?begin=0&end=10" style="color:#fff">處理中</a></li>
        <li><a href="OrderPickupPage.jsp?begin=0&end=10">揀貨中</a></li>
        <li><a href="OrderUploadTrackingCode.jsp?begin=0&end=10">上傳追蹤碼</a></li>
        <li><a href="OrderFinished.jsp?begin=0&end=10">已完成訂單</a></li>
        <li><a href="ShipmentRecord.jsp?begin=0&end=10" >訂單出貨記錄</a></li>
        <li><a href="refundPage.jsp?begin=0&end=10" >退貨</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="container container-fluid breadcrumbBox">
  <ol class="breadcrumb" >
    <li><a href="/HomePage.jsp" >首頁</a></li>
    <li class="active" style="display:"><a href="SearchOrder.jsp?begin=0&end=10">訂單管理</a></li>
    <li><a href="OrderDetail.jsp?QR_id=${result.getCOrderMaster().getQR_id()}">訂單明細</a></li>
  </ol>
</div>

  <div class="container table-responsive" style="background: #D9A56B; border-radius:20px;">
  	<form name="searchform" method="post" action="../OrdersServlet" class="form-inline container" 
  	style="font-size: 100%; vertical-align: baseline; padding: 15px;" onsubmit="return isSubmited()">
	<c:if test="${PageCompetence.getPendingOrdersEdit() == 1}">  	
	  	<div class="row">
	      <label for="inputPassword" class="col-md-2 control-label text-left">編輯模式</label>
	      <div class="col-md-4">
	        <label class="radio-inline"><input type="checkbox" name="optionsRadios" id="optionsCheck" onchange="enableFields(this)">開關</label>
	    	<label class="radio-inline">
	    	<button type="submit" name="submit" value="updateOrder" class="btn btn-lg btn-success" id="btnCheck" disabled>更新商品資料</button>
	    	<a href="./OrderProcessingPage.jsp?begin=0&end=10" class="btn btn-info" role="button">回到處理中</a>
	      	</label>
	      </div>
	    </div>
    </c:if>
    <fieldset id="myfields" class="font-weight" style="padding:0 30px 0 0;" disabled><legend>訂單明細</legend>
      <div class="panel-group" id="accordion">
        <div class="panel panel-default" style="background-color:#E7D29F">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">訂購人資料</a>
            </h4>
          </div>
          <div id="collapse1" class="panel-collapse collapse">
            <div class="panel-body">
              <div class="container-fluid form-horizontal">
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>客戶名子</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GuestFirstName" value="${result.getCOrderGuestInfo().getGuestFirstName()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>客戶姓氏</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GuestLastName" value="${result.getCOrderGuestInfo().getGuestLastName()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>訂購帳號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GuestAccount" value="${result.getCOrderGuestInfo().getGuestAccount()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>電子郵件</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Email" value="${result.getCOrderGuestInfo().getEmail()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>電話(日)</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GTel1" value="${result.getCOrderGuestInfo().getTel1()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>電話(夜)</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GTel2" value="${result.getCOrderGuestInfo().getTel2()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>行動電話</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Mobile" value="${result.getCOrderGuestInfo().getMobile()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>公司/學校</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Company" value="${result.getCOrderGuestInfo().getCompany()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>地址</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GAddress" value="${result.getCOrderGuestInfo().getAddress()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>國家</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GCountry" value="${result.getCOrderGuestInfo().getCountry()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>郵遞區號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="GPostcode" value="${result.getCOrderGuestInfo().getPostcode()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>性別</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Gender" value="${result.getCOrderGuestInfo().getGender()}"></div>
		        </div>
		      </div>
            </div>
          </div>
          <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">收件人資料</a>
            </h4>
          </div>
          <div id="collapse2" class="panel-collapse collapse">
            <div class="panel-body">
              <div class="container-fluid form-horizontal">
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>收件人名字</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RecieverFirstName" value="${result.getCOrderReciever().getRecieverFirstName()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>收件人姓氏</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RecieverLastName" value="${result.getCOrderReciever().getRecieverLastName()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>電話1</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RTel1" value="${result.getCOrderReciever().getTel1()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>電話2</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RTel2" value="${result.getCOrderReciever().getTel2()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>地址</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RAddress" value="${result.getCOrderReciever().getAddress()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>收件人國家</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RCountry" value="${result.getCOrderReciever().getCountry()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>郵遞區號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RPostCode" value="${result.getCOrderReciever().getPostCode()}"></div>
		        </div>
		      </div>
            </div>
          </div>
          <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">訂單資料</a>
            </h4>
          </div>
          <div id="collapse3" class="panel-collapse collapse">
            <div class="panel-body">
              <div class="container-fluid form-horizontal">
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>外部訂單編號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="OutsideCode" value="${result.getCOrderMaster().getOutsideCode()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>訂單狀態</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="OrderStatus" value="${result.getCOrderMaster().getOrderStatus()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>訂單編號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="EbayNO" value="${result.getCOrderMaster().getEbayNO()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>出貨編號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="QR_id" value="${result.getCOrderMaster().getQR_id() }"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>Tracking Code</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="TrackingCode" value="${result.getCOrderMaster().getTrackingCode() }"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>公司</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="MCompany" value="${result.getCOrderMaster().getCompany()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>平台</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Platform" value="${result.getCOrderMaster().getPlatform()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>ebay 帳號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="EbayAccount" value="${result.getCOrderMaster().getEbayAccount()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>購買日期</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="OrderDate" value="${result.getCOrderMaster().getOrderDate()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>付款日期</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="PayDate" value="${result.getCOrderMaster().getPayDate()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>付款方式</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="PayWay" value="${result.getCOrderMaster().getPayWay()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>paypal 交易序號</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="PaypalId" value="${result.getCOrderMaster().getPaypalId()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>出貨日期</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="ShippingDate" value="${result.getCOrderMaster().getShippingDate()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>物流配送方式</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Logistics" value="${result.getCOrderMaster().getLogistics()}"></div>
		        </div>
			    <c:if test="${PageCompetence.getTotalAmountEdit() == 1}">
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>運費</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="ShippingFees" value="${result.getCOrderMaster().getShippingFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>退運費</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="RefundShippingFees" value="${result.getCOrderMaster().getRefundShippingFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>其它費用</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="OtherFees" value="${result.getCOrderMaster().getOtherFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>ebay成交費</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="EbayFees" value="${result.getCOrderMaster().getEbayFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>計算保價</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="InsuranceTotal" value="${result.getCOrderMaster().getInsuranceTotal()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>paypal費用</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="PaypalFees" value="${result.getCOrderMaster().getPaypalFees()}"></div>
			        </div>
		        </c:if>
		        <c:if test="${PageCompetence.getTotalAmountEdit() == 0}">
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>運費</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="ShippingFees" value="${result.getCOrderMaster().getShippingFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>退運費</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="RefundShippingFees" value="${result.getCOrderMaster().getRefundShippingFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>其它費用</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="OtherFees" value="${result.getCOrderMaster().getOtherFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>ebay成交費</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="EbayFees" value="${result.getCOrderMaster().getEbayFees()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>計算保價</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="InsuranceTotal" value="${result.getCOrderMaster().getInsuranceTotal()}"></div>
			        </div>
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>paypal費用</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="PaypalFees" value="${result.getCOrderMaster().getPaypalFees()}"></div>
			        </div>
		        </c:if>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>淨重(公克)</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Weight" value="${result.getCOrderMaster().getWeight()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>毛重(公克)</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="TotalWeight" value="${result.getCOrderMaster().getTotalWeight()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>長/寛/高</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Size" value="${result.getCOrderMaster().getSize()}"></div>
		        </div>
		        <div class="row">
		          <div class="col-md-3 text-right well-sm label-tag"><h4>備註</h4></div>
		          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="Comment" value="${result.getCOrderMaster().getComment()}"></div>
		        </div>
		        <c:if test="${PageCompetence.getTotalAmountEdit() == 1}">
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>總計</h4></div>
			          <div class="col-md-5 well-sm"><input class="form-control" type="text" name="TotalPrice" id="TotalPrice" value="${result.getCOrderMaster().getTotalPrice()}"></div>
			        </div>
		      	</c:if>
		      	<c:if test="${PageCompetence.getTotalAmountEdit() == 0}">
			        <div class="row">
			          <div class="col-md-3 text-right well-sm label-tag"><h4>總計</h4></div>
			          <div class="col-md-5 well-sm"><input readonly class="form-control" type="text" name="TotalPrice" value="${result.getCOrderMaster().getTotalPrice()}"></div>
			        </div>
		      	</c:if>
		      </div>
            </div>
          </div>
          <div class="panel-heading">
            <h4 class="panel-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">訂購商品清單</a>
            </h4>
          </div>
          <div id="collapse4" class="panel-collapse collapse in">
            <div class="panel-body">
              <table class="table table-bordered table-hover table-condensed pull-left" style="margin:0 0 0 -15px">
			    <thead>
			 	  <tr class="ListTitle2">
			        <th>商品SKU</th>
			        <th>商品名稱 / invoice名稱</th>
			        <th>價錢</th>
			        <th>數量</th>
			        <th>備註</th>
		          </tr>
	            </thead>
	            <c:forEach var="i" items="${resultDetail}" begin="0" step="1" varStatus="check">
		        <tbody>
		          <tr>
		            <td>
		              <input class="" type="hidden" name="SKU" value="${i.getSKU()}">
		              SKU:<br/><a href="../QRProduct/StockDetail.jsp?sku=${i.getSKU()}"><b>${i.getSKU()}</b></a>
	          		  <button type="submit" name="submit" value="deleteDetail" class="btn btn-sm btn-danger">移除此商品</button>
		            </td>
		            <td>${i.getProductName()}<br/>
						Invoice Name:<br/><input class="" type="text" name="invoiceName" value="${i.getInvoiceName()}">
		            </td>
		           	<c:if test="${PageCompetence.getTotalAmountEdit() == 1}">
			            <td>售價:<br/><input class="" type="text" name="price" value="${i.getPrice()}" ><br/>
			            invoicePrice:<br/><input class="" type="text" name="invoicePrice" value="${i.getInvoicePrice()}" ></td>
			        </c:if>
		            <c:if test="${PageCompetence.getTotalAmountEdit() == 0}">
			           <td>售價:<br/><input class="" type="text" name="price" value="${i.getPrice()}" ><br/>
			            invoicePrice:<br/><input class="" type="text" name="invoicePrice" value="${i.getInvoicePrice()}" readonly></td>
		           	</c:if>
		            <td>
		              <input class="" type="text" name="qty" value="${i.getQty()}">
		             	 倉別:
		              <select name="warehouse">
                        <c:set var="SKU" scope="session" value="${i.getSKU()}"/>
                        <%
                        if(session.getAttribute("SKU") != null){
                        LinkedList<String> warehouses = COrderFactory.getWarehousesForI(request,session.getAttribute("SKU").toString());
                        session.setAttribute("warehouses", warehouses);
                        } else {
                        	session.setAttribute("warehouses", "");
                        }
                        %>
                        <c:choose>
                          <c:when test="${i.getWarehouse() != null || i.getWarehouse() != ''}">
                            <option value="${i.getWarehouse()}">${i.getWarehouse()}</option>
		                  </c:when>
		                  <c:otherwise>
		                    <option></option>
		                  </c:otherwise>
		                </c:choose>
                          <c:forEach var="w" items="${warehouses}">
                            <option value="${w}">${w}</option>
                          </c:forEach>
                      </select>
		            </td>
		            <td><input class="" type="text" name="comment" value="${i.getComment()}">
		            <input type="hidden" name="item" value="${i.getItem()}">
		            </td>
		          </tr>
		        </tbody>
		        </c:forEach>
		      </table>
	          <button type="submit" name="submit" value="toGetProducts" class="btn btn-sm btn-success">新增商品</button>
            </div>
          </div>
        </div>
      </div>
    </fieldset>
    </form>
  </div>

<script type="text/javascript">
 
$(function () {
	$(".btn-danger").click(function() {
		bool = confirm("確認是否刪除訂單");
		if(!bool){
			return false;
		}
	});
});
  
 function enableFields(ele){
  if (ele.checked) {
	  $("#myfields").prop("disabled", false);
	  $("#btnCheck").prop("disabled", false);
  } else {
	  $("#myfields").prop("disabled", true);
	  $("#btnCheck").prop("disabled", true);
	  }
  };

function isSubmited() {
	//isLessTotalPrice()
	var sum = 0;
    $('input[name="price"]').each(function(){
        sum += +$(this).val();
    });
    var total = $('#TotalPrice').val();
    if (sum>total || sum <=0)
    {
    	alert("請注意,修改後金額小於原始金額,不可更改");
        return false;
    } else if (sum>total || sum <=0)
    {
    	alert("請注意,修改後金額小於等於0");
        return false;
    }
    //isWarehousePicked()
    var isWarehousePicked = true;
    $('select[name=warehouse]').each(function(){
    	if($(this).val() == undefined || $(this).val().trim() == ""){
    		alert("請選擇倉別");
    		isWarehousePicked = false;
    		return false;
		}
    });
    return isWarehousePicked;
}
</script>  
</body>
</html>	