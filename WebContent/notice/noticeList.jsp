<%@page import="com.hanul.page.Pager"%>
<%@page import="com.hanul.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.hanul.page.MakePager"%>
<%@page import="com.hanul.page.RowNumber"%>
<%@page import="com.hanul.notice.NoticeDAO"%>
<%@page import="com.hanul.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	//encoding 설정 (한글깨짐 방지)
	
	int curPage = 1;
	try{
		curPage = Integer.parseInt(request.getParameter("curPage"));
	}catch(Exception e){
		
	}
	
	String kind = request.getParameter("kind");
	if(kind == null || kind.equals("")){
		kind = "title";
	}
	
	String search = request.getParameter("search");
	if(search == null){
		search = "";
	}
	
	BoardDAO boardDAO = new NoticeDAO();
	MakePager makePager = new MakePager(curPage, search, kind);	
	List<BoardDTO> ar = boardDAO.selectList(makePager.makeRow());

	int totalCount = boardDAO.getCount(kind, search);
	
	Pager pager = makePager.makePage(totalCount);
	
	
	request.setAttribute("list", ar);
	request.setAttribute("board", "notice");
	request.setAttribute("pager", pager);
	
	RequestDispatcher view = request.getRequestDispatcher("../board/boardList.jsp");
	view.forward(request, response);
	
%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

</body>
</html>
