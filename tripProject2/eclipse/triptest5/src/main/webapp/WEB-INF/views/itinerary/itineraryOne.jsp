<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript" src="../resources/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
/* 
$(function() {
	$.ajax({
		url : "../itineraryComment/iCommentList", //views/itineraryComment.jsp가 결과
		success : function(result) { //결과가 담겨진 table부분코드
			$('#itinerayComment').html(result)
			//alert('ajax성공')
		},
		error : function() {
			alert('ajax실패')
		}
	})
}) */
</script>
<title>여행일정 게시판 상세보기</title>
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		int member_idx = 0;
		if(session.getAttribute("member_idx") != null){
			member_idx = Integer.parseInt((String)session.getAttribute("member_idx"));
		}
		
		// itineraryID를 초기화 시키고
		// 'itineraryID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int itinerary_idx = 0;
		if(request.getParameter("itinerary_idx") != null){
			itinerary_idx = Integer.parseInt(request.getParameter("itinerary_idx"));
		}
		
		// 만약 넘어온 데이터가 없다면
		if(itinerary_idx == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='itinerary.jsp'");
			script.println("</script");
		}
		
		// 유효한 글이라면 구체적인 정보를 'itinerary'라는 인스턴스에 담는다
	%>
	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="../main.jsp">Hitrip 메인 페이지</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="../main.jsp">Hitrip 메인 페이지</a></li>
				<li class="active"><a href="itinerary.jsp">게시판</a></li>
			</ul>
			<%
				// 로그인 하지 않았을 때 보여지는 화면
				if(member_idx == 0){
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->
	
	<!-- 게시판 글 보기 양식 영역 시작 -->
	<div class="container">
	<div align="right">
	<a href="itinerary.jsp" class="btn btn-primary">목록</a>
			
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
		<%-- 	<%
				if(member_idx != 0 && member_idx == ${one.member_idx}){
			%> --%>
					<a href="itineraryUpdate?itinerary_idx=${one.itinerary_idx}" class="btn btn-primary">수정</a>
					<a href="itineraryDelete?itinerary_idx=${one.itinerary_idx}" class="btn btn-primary">삭제</a>
		<%-- 	<%
				}
			%> --%>
	</div>
		<div class="row">
		
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2">${one.itinerary_title}</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2">${memberOne.member_name}</td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2">${one.itinerary_date}</td>
					</tr>
					<tr>
						<td>여행지</td>
						<td colspan="2">
						<c:forEach items="${placeList}" var="placeList" varStatus="status">
						<a href="../place/pDetail?place_idx=${placeList.place_idx}">
							${placeList.place_info}</a><br>
						</c:forEach>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 200px; text-align: left;"> ${one.itinerary_details}</td>
					</tr>
				</tbody>
			</table>
			
		</div>
	
	</div>
	<!-- 게시판 글 보기 양식 영역 끝 -->
	
	<!-- 댓글 -->
<%-- 	<%@ include file="/itineraryComment/itineraryComment.jsp" %>
 --%>	<div id="itineraryComment">
	
	</div>
	<!-- 부트스트랩 참조 영역 -->
</body>
</html>