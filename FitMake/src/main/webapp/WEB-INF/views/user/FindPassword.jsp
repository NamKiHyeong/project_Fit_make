<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>

<style type="text/css">
#containerFid {
	width: 1200px;
	height: 100%;
	margin: 0px auto;
}

#fidMainDiv {
	margin: 0px auto;
	width: 600px;
	height: 50px;
}

#fidMainDiv2 {
	margin-top: 20px;
	margin: 0px auto;
	width: 600px;
	margin: 0px auto;
}

#findId {
	text-align: center;
	font-size: 30px;
	font-weight: 600
}

#contentSpan {
	color: #444343;
	font-size: 15px;
	padding: 22px 0 22px 14px;
	text-align: left;
	line-height: 1.4;
}

#contentSpan3 {
	color: #444343;
	font-size: 15px;
	padding: 22px 0 22px 14px;
	text-align: left;
	line-height: 1.4;
}

.emClass {
	color: #d7266d;
}

#email {
	width: 243px;
	height: 35px;
	padding-left: 11px;
	line-height: 35px;
	background: #f9f9f9;
	border: 1px solid #d6d6d6;
	color: #7e7e7e;
	font-family: 'Noto sans', sans-serif;
	font-size: 13px;
}

#btnDiv {
	text-align: center;
	padding-top: 40px;
}

#submitInp {
	width: 200px;
	background: #d7266d;
	margin-bottom: 70px;
	padding: 10px 0px;
	border: 1px solid #d7266d;
	color: #fff;
	text-align: center;
	font-size: 1em;
	font-weight: bold;
	border-radius: 3px;
	cursor: pointer;
}

#cancelInp {
	width: 200px;
	background: #fff;
	margin-left: 10px;
	margin-bottom: 70px;
	padding: 10px 0px;
	border: 1px solid #565656;
	color: #565656;
	text-align: center;
	font-size: 1em;
	font-weight: bold;
	border-radius: 3px;
	cursor: pointer;
	border-radius: 3px;
	margin-bottom: 70px;
}
</style>

<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		findPasswordFnc();
		$("#cancelInp").click(function() {
			location.href = "../auth/login.do";
		});
	});
	function findPasswordFnc() {
		$("#submitInp").click(
				function() {
					var email = $("#email").val();
					$.ajax({
						type : "post",
						url : "resultFindPwd.do",
						dataType : "text",
						data : {
							email : email
						},
						success : function(data) {
							if (data != 0) {
								$("#contentSpan3").html(
										"???????????? Password??? " + data + " ?????????");
							} else {
								$("#contentSpan3").html("????????? ???????????? ????????????");
							}
						},
						error : function() {
							console.log("????????????");
						}
					});

				});
	}
</script>
</head>

<body>
	<!-- ?????? include -->
	<jsp:include page="../Header.jsp" />
	<div id="containerFid">
		<p id="findId">???????????? ??????</p>
		<div id="fidMainDiv">
			<span id="contentSpan"><em class="emClass">*</em>???????????? ????????? ?????????
				?????????????????? </span> <input type="text" value="" id="email">
		</div>
		<div id="fidMainDiv2">
			<span id="contentSpan3"></span>
		</div>
		<div id="btnDiv">
			<input type="button" id="submitInp" value="??????"><input
				type="button" id="cancelInp" value="??????">
		</div>
	</div>
	<!-- footer include -->
	<jsp:include page="../Footer.jsp" />
</body>


</html>