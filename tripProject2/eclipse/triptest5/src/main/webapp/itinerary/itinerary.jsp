<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width" initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.hi.trip.itinerary.ItineraryDAO" %>
<%@ page import="com.hi.trip.itinerary.ItineraryVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(function() {
	$.ajax({
		url : "itineraryList", //views/surveyList.jsp가 결과
		success : function(result) { //결과가 담겨진 table부분코드
			$('#body').html(result)
			//alert('ajax성공')
		},
		error : function() {
			alert('ajax실패')
		}
	})
})
</script>
<title>여행지일정</title>
</head>
<body>
	<div id="total">
<%-- 		<div id="menu">
			<jsp:include page="top.jsp"></jsp:include>
		</div>
		<div id="memberTop">
			<jsp:include page="top2.jsp"></jsp:include>
		</div> --%>
		<div id="body">
			
		</div>
	</div>
</body>
</html>