<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script type="text/javascript">

$(function() {
	$.ajax({
		url : "pShowSearch", //views/surveyList.jsp가 결과
		success : function(result) { //결과가 담겨진 table부분코드
			$('#pShowSearch').html(result)
			//alert('ajax성공')
		},
		error : function() {
			alert('ajax실패')
		}
	})
})
</script>
</head>
<body>
	<div class="header">
	</div>
   <div class="searchbox">
     
        <h1>여행지 검색</h1>
        <form action="pShowSearch">       
        	<input type="text" name="place_area" placeholder="Type to Search">
			<button class="btn btn-danger" type="submit">검색</button>
		</form>
</div>
<div id = "pShowSearch">

</div>
 

</body>
</html>