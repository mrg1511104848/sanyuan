<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="ans" varStatus="s" items="${question.answers}">
	<div>回答人:<font color="#2d64b3">${ans.answerPeople}</font></div>
	<div>回答时间:${ans.answerTime}</div>
	<div>内容:${ans.content }</div>
	<hr/>
</c:forEach>