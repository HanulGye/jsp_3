<%@page import="com.hanul.page.Pager"%>
<%@page import="com.hanul.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.hanul.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	//encoding 설정 (이 경우는 가져올 때, 이미 코드가 있기에 굳이 안써도 됨.)
	
	String board = (String)request.getAttribute("board");
	List<BoardDTO> ar = (List<BoardDTO>)request.getAttribute("list");
	Pager pager = (Pager)request.getAttribute("pager");
	
%>     

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../temp/style.jsp" %>
</head>
<body>
<jsp:include page="../temp/header.jsp"></jsp:include>
<div class="container-fluid">
	<div class="row">
		<h1><%= board %></h1>
	</div>
	<div class="row">
		<table class="table table hover">
			<tr>
				<th>Num</th>
				<th>Title</th>
				<th>Writer</th>
				<th>Date</th>
				<th>Hit</th>
			</tr>
			<% for(BoardDTO boardDTO: ar){ %>
				<tr>
					<td><%=boardDTO.getNum() %></td>
					<td><%=boardDTO.getTitle() %></td>
					<td><%=boardDTO.getWriter() %></td>
					<td><%=boardDTO.getReg_date() %></td>
					<td><%=boardDTO.getHit() %></td>
				</tr>
			
			<%} %>
		</table>
	</div>
</div>

<div class="container-fluid">
	<div class="row">
		    
	  <ul class="pagination">
	  	<li><a href="./boardList.jsp?curPage=<%= 1%>"><span class="glyphicon glyphicon-backward"></span></a></li>
	  	
	  	<%if (pager.getCurBlock()>1){ %>
	  	<li><a href="./boardList.jsp?curPage=<%= pager.getStartNum()-1%>&kind=<%=pager.getSearch().getKind()%>"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
	  	<%} %>
	   	<% for(int i=pager.getStartNum();i<=pager.getLastNum();i++){ %>
	   		<li><a href="./boardList.jsp?curPage=<%=i%>"><%=i%></a></li>
	   	<%} %>
	   	
	   	<% if(pager.getCurBlock() < pager.getTotalBlock()){ %>
	   	<li><a href="./boardList.jsp?curPage=<%=pager.getLastNum()+1%>"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
	   	<%} %>	
	   	<li><a href="./boardList.jsp?curPage=<%=pager.getTotalPage()%>"><span class="glyphicon glyphicon-forward"></span></a></li>
	  </ul>
	  
  	</div>
</div>



<jsp:include page="../temp/footer.jsp"></jsp:include>
</body>
</html>