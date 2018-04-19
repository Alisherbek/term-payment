<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>E-Tirjorat</title>
</head>
<style>
	body{
		 background: #eee url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAMAAAC6sdbXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAAZQTFRF3d3d////riJKgAAAAAJ0Uk5T/wDltzBKAAAAFUlEQVR42mJgBAEGGMmAxAYCgAADAAGGABmnk/7aAAAAAElFTkSuQmCC);
		 background-color: #BDBDBD;
		 /*padding:0px;
		 margin:0px;*/
	}
	/*menu*/
    .sidenav {
		height: 100%;
		width: 0;
		position: fixed;
		z-index: 1;
		top: 0;
		left: 0;
		background-color: #111;
		overflow-x: hidden;
		transition: 0.5s;
		padding-top: 60px;
	}
	.sidenav a {
		padding: 8px 8px 8px 32px;
		text-decoration: none;
		font-size: 25px;
		color: #818181;
		display: block;
		transition: 0.3s
	}

	.sidenav a:hover, .offcanvas a:focus{
		color: #f1f1f1;
	}

	.sidenav .closebtn {
		position: absolute;
		top: 0;
		right: 25px;
		font-size: 36px;
		margin-left: 50px;
	}

	@media screen and (max-height: 450px) {
	  .sidenav {padding-top: 15px;}
	  .sidenav a {font-size: 18px;}
	}
	/*end menu*/
/*top*/
	span{
		font-size: 30px;
	}
	#header1{	
	 /*   background-color: #9933cc;*/
		color: #ffffff;            
		width: 100%;
		height: 40px;
		padding-bottom: 5px;
		padding-top: 5px;
		/*margin: 0px 5px 5px 10px;*/
		border: 1px solid #222;
		background-color: #111;
		background-image: -moz-linear-gradient(#444, #111); 
		background-image: -webkit-gradient(linear, left top, left bottom, from(#444), to(#111));	
		background-image: -webkit-linear-gradient(#444, #111);	
		background-image: -o-linear-gradient(#444, #111);
		background-image: -ms-linear-gradient(#444, #111);
		background-image: linear-gradient(#444, #111);
		-moz-box-shadow: 0 1px 1px #777, 0 1px 0 #666 inset;
		-webkit-box-shadow: 0 1px 1px #777, 0 1px 0 #666 inset;
		box-shadow: 0 1px 1px #777, 0 1px 0 #666 inset;
		float: left;
	}

	.container {        
		margin-left: 10px;
		float: left;
		display: inline-block;
		cursor: pointer;
	}	
	.bar{
		width: 35px;
		height: 5px;
		background-color: #ffffff;
		margin: 6px 0;
	}
/*end top*/
</style>
<script>
function openNav() {
        document.getElementById("mySidenav").style.width = "350px";
    }

function closeNav() {
        document.getElementById("mySidenav").style.width = "0";
    }
	function sizePage(){
		var a = window.innerHeight, b = a - 16, b1 = a - 65;
		var c = b+"px";
		var c1 = b1+"px";
		document.getElementById("mainDiv").style.height = c;
		document.getElementById("mainFrame").style.height = c1;		
	}
//--------------show menu

</script>
<body onload="sizePage()">
<!---->
<div id="mySidenav" class="sidenav">
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<a href="main/mainView.jsp" target="main" onclick="closeNav()">Главный</a>
	<a href="setting/settings.jsp" target="main" onclick="closeNav()">Настройка</a>
	<a href="user/users.jsp" target="main" onclick="closeNav()">Пользователы</a>
	<a href="products/product_names.jsp" target="main" onclick="closeNav()">Наименование товар</a>
	<a href="products/products.jsp" target="main" onclick="closeNav()">Товаровы</a>
	<a href="contracts/contracts.jsp" target="main" onclick="closeNav()">Договоры</a>            
	<a href="payment/payments.jsp" target="main" onclick="closeNav()">Оплаты</a>            	
	<a href="contracts/contract_products.jsp" target="main" onclick="closeNav()">Предмет договора</a>            
	<a href="main/main_6.jsp" target="main" onclick="closeNav()">Переданные в суд</a>            
	<a href="acc/repaccs.jsp" target="main" onclick="closeNav()">Отчёт (сум)</a>            
	<a href="acc/repacc$.jsp" target="main" onclick="closeNav()">Отчёт ($)</a>            
	<a href="acc/fromtos.jsp" target="main" onclick="closeNav()">Отчёт дата c... по... (сум)</a>            
	<a href="acc/fromto$.jsp" target="main" onclick="closeNav()">Отчёт дата c... по... ($)</a>            
	<a href="index.jsp">Выход</a>
</div>
<div id="header1">
	<div class="container" title="Menu" onclick="openNav()">
		<div class="bar"></div>
		<div class="bar"></div>
		<div class="bar"></div>
	</div>           
	
	<span style="color:white; float: right; margin-right: 10px">Пользователь: ADMIN</span>
</div>
<div id ="mainDiv" style="width:100%;">
	<iframe id="mainFrame" name="main"  width="100%" src="main/mainView.jsp" rightmargin="0"  frameborder="0" ></iframe>		
</div>
</body>
</html>