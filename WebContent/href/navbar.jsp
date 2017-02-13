<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Nav</title>
<!-- local file -->
<!-- <link rel="stylesheet" type="text/css" href="../css/bootstrap.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"> -->

<!-- <script src="../js/jquery-1.12.4.min.js"></script> -->
<!-- <script src="../js/bootstrap.min.js"></script> -->
<!-- <script src="../js/jquery-ui.min.js"></script> -->
<!-- <script src="../js/jquery.ui.datepicker-zh-TW.js"></script> -->


<!-- downloaded -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<link rel="stylesheet"
	href="http://fonts.googleapis.com/earlyaccess/notosanstc.css">
<link rel="stylesheet" href="../css/custom.css" rel="stylesheet">

  <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.js"></script>
  <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
  <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.js"></script>
  <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>
<style type="text/css">
textarea {
    resize: none;
}
</style>  
<style>
.loader {
margin: 0px auto;
position:absolute; width:70%; height:280px;
    top:0; bottom:0; left:0; right:0; margin:auto;
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #3498db;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
  z-index:4;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
<script type="text/javascript">
$(function() {
	//日期選擇器
 	$(".yymmdd").datepicker({
		dateFormat : 'yy-mm-dd',
		
	}); 
	
	$("input[name=checkupdate]").datepicker({
		dateFormat : 'yy-mm-dd',
	});
	$("input[name=cdate]").datepicker({
		dateFormat : 'yy-mm-dd',
	});
	$("input[name=dateMin]").datepicker({
		dateFormat : 'yy-mm-dd',
	});
	$("input[name=dateMax]").datepicker({
		dateFormat : 'yy-mm-dd',

	});
	 $("input[name=date1]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=date2]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=payDateMin]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=payDateMax]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=shippingDateMin]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=shippingDateMax]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=startTime]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=lastFixTime]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=OrderDate]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=PayDate]").datepicker({dateFormat : 'yy-mm-dd'});
        $("input[name=ShippingDate]").datepicker({dateFormat : 'yy-mm-dd'});
   });

    function checkAllOrders(ele) {
   	//select all
	if (ele.checked) {
		$("input[name=all]").prop("checked", true);
        $("input[name=waitProcess]").prop("checked", true);
        $("input[name=processing]").prop("checked", true);
        $("input[name=pickup]").prop("checked", true);
        $("input[name=finished]").prop("checked", true);
        $("input[name=refund]").prop("checked", true);
        $("input[name=oothers]").prop("checked", true);
        $("input[name=deducted]").prop("checked", true);
    } else {
    	$("input[name=all]").prop("checked", false);
        $("input[name=waitProcess]").prop("checked", false);
        $("input[name=processing]").prop("checked", false);
        $("input[name=pickup]").prop("checked", false);
        $("input[name=finished]").prop("checked", false);
        $("input[name=refund]").prop("checked", false);
        $("input[name=oothers]").prop("checked", false);
        $("input[name=deducted]").prop("checked", false);
    }
};

$(function () {
	$("button[name=send]").click(function() {
		bool = confirm("確認是否送出訂單");
		if(!bool){
			return false;
		}
	});
});
	
$( document ).ready(function() {
$('body').css({'font-family': 'Noto Sans TC'});
	});
//Modal
$(function() {
		$('.pop').on('click', function() {
			$('.imagepreview').attr('src', $(this).find('img').attr('src'));
			$('#imagemodal').modal('show');   
		});		
});
//AjaxModal
function AjaxModal() {
	$('.pop').on('click', function() {
		$('.imagepreview').attr('src', $(this).find('img').attr('src'));
		$('#imagemodal').modal('show');   
	});		
}

</script>
</head>
<body>

<%

//  if(!"0".equals(request.getParameter("p"))){
//  	if (session.getAttribute("account")==null){
//  		response.sendRedirect("/Login.jsp?p=0");
//  	}
//  }
 

%>



	<nav class="navbar" style="background-color: #000000">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="/HomePage.jsp">QuickReach</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<c:if test="${PageCompetence.getProductManage() ==1}">
					<li><a href="/QRProduct/SearchStockPage.jsp">商品/庫存 </a></li>
				</c:if>
				<c:if test="${PageCompetence.getOrdersManage() ==1}">
					<li><a href="/QROrders/SearchOrder.jsp">訂單資訊</a></li>
				</c:if>
				<c:if test="${PageCompetence.getEbayPaypalAccountEdit()==1}">
					<li><a href="/QREBayAccount/eBayAccount.jsp">Ebay帳號管理</a></li>
				</c:if>
				<c:if test="${PageCompetence.getAccountInfoEdit() ==1 }"> 
					<li><a href="/QREmployee/accountManage.jsp">員工管理</a></li>
					<li><a href="/QRAccess/Competence.jsp">權限管理</a></li>
			    </c:if>
			    <c:if test="${PageCompetence.getParamSettingEdit() ==1}">
			    	<li><a href="/SupplyCompany/SCManage.jsp">供應商/倉庫</a></li>
				</c:if>
			</ul>

			<ul class="nav navbar-right">
				<c:if test="${account != null}">
					<li><a href="/Login.jsp?p=0" >${staffName}${'('}${account}${')'}<span
							class="glyphicon glyphicon-log-in"></span> Logout</a></li>
				</c:if>	
				<c:if test="${account == null}">
					<li><a href="/Login.jsp?p=0" ><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
				</c:if>	
			</ul>
		</div>
	</div>
	</nav>
	<div class="loader text-center" id="spinner" hidden></div>
	
<!-- Modal -->
<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">              
      <div class="modal-body">
      	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <img src="" class="imagepreview" style="width: 100%;" >
      </div>
    </div>
  </div>
</div>
</body>
</html>