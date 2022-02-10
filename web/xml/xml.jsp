<?xml version="1.0" encoding="UTF-8"?>
<%@page import="java.util.HashMap"%>
<%@page import="kr.urimal365.dao.NewsViewDAO"%>
<%@page import="kr.urimal365.dto.NewsView"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String startDate = request.getParameter("start_date");
	String endDate = request.getParameter("end_date");
	String serverName = request.getServerName();
	String msg = "";
	if(startDate=="" || startDate==null) {
		msg = "날자를 날자형식에 맞게 입력해주세요 ex)20170101";
	}

	if(endDate=="" || endDate==null) {
		msg = "날자를 날자형식에 맞게 입력해주세요 ex)20170101";
	}
	
	
	HashMap<String,Object> param = new HashMap<String,Object>();
	param.put("startDate", startDate);
	param.put("endDate", endDate);
	List<NewsView> newsXmlList = NewsViewDAO.getDAO().getXmlList(param);
	
	System.out.println(newsXmlList);
%>
<Syndicate>
	<%
		for(NewsView news : newsXmlList) {
			String contents = news.getContents().replaceAll("src=\"", "src=\"" + request.getScheme() + "://" + serverName + "/");
			int cateIdx = news.getCategoryIdx();
				if(cateIdx == 6 || cateIdx == 14 || cateIdx == 12 || cateIdx == 36 || cateIdx == 18 || cateIdx == 19) {
					String thumbUrl = "";
					if(news.getThumbnailFile() != null) {
						thumbUrl = request.getScheme()+"://"+serverName+news.getThumbnailFile();
					}
	%>
	<NewsItem>
		<NewsItemId><%=news.getIdx()%></NewsItemId>
		<ContentsStatus><%=news.getContentsStatus()%></ContentsStatus>
		<ModifyId><%=news.getModifyId()%></ModifyId>
		<ModifyDate><%=news.getUpdateDate()%></ModifyDate>
		<ApproveDate><%=news.getWriteDate()%></ApproveDate>
		<ApproverName><%=news.getWriteId()%></ApproverName>
		<EmbargoDate><%=news.getPublishDate()%></EmbargoDate>
		<GroupingCode><%=news.getCate1()%>|<%=news.getCategoryIdx()%></GroupingCode>
		<Title><![CDATA[<%=news.getTitle()%>]]></Title>
		<SubTitle1><%=news.getSubTitle()%></SubTitle1>
		<SubTitle2></SubTitle2>
		<SubTitle3></SubTitle3>
		<WriterName><%=news.getWriteId()%></WriterName>
		<WriterPhone></WriterPhone>
		<WriterEmail></WriterEmail>
		<WriterPosition></WriterPosition>
		<ContentsType>H</ContentsType>
		<DataContents><![CDATA[<%=contents%>]]></DataContents>
		<FileName></FileName>
		<FileUrl></FileUrl>
		<MisisterCode></MisisterCode>
		<ThumbnailUrl><%=thumbUrl%></ThumbnailUrl>
		<OriginalimgUrl></OriginalimgUrl>
		<OriginalUrl></OriginalUrl>
		<Etc1></Etc1>
		<Etc2></Etc2>
		<Etc3></Etc3>
	</NewsItem>
	<%
			}
		}
	%>
</Syndicate>
