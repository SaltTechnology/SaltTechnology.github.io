<%@ page pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <base href="<%=request.getScheme()%>://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/">
  <link href="static/css/bootstrap.css" rel="stylesheet">

  <!-- Shim adds HTML5 support to Internet Explorer 6-8 -->
  <!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->

  <script src="static/js/jquery-1.7.2.min.js"></script>
  <script src="static/js/bootstrap.min.js"></script>

  <decorator:head/>
  <title><decorator:title/></title>
</head>
<body>
  <div class="navbar navbar-static-top" >
    <div class="navbar-inner">
      <div class="container-fluid">
        <a class="brand" href="${pageContext.request.contextPath}/"><img alt="Logo" src="static/img/salt-logo-tiny.png"/></a>
        <span class="brand">${msg.companyBrand}</span>
        <ul class="nav pull-right">
        <li><a id="developersLink" href="http://salttechnology.github.io/">${msg.developers}</a>
          <li class="dropdown">
            <a id="supportLink" class="dropdown-toggle" data-toggle="dropdown">${msg.support} <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a id="supportMailLink" href="#supportMail" data-toggle="modal">${msg.mailSupport}...</a>
              <li class="divider">
              <li><address>${msg.supportPhone}</address>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>

  <div class="container">
    <div class="row">
      <div class="span12">
        <decorator:body/>
		<a href="http://salttechnology.github.io/core_api_doc.html">Core API Guide</a><br>
		<a href="http://salttechnology.github.io/post_api_ref.html">POST API Reference</a><br>
		<a href="http://salttechnology.github.io/core_api_ref.html">Java Credit Card API Reference</a><br>
		<!--<a href="http://salttechnology.github.io/core_api_ref_iop.html">Java IOP API Reference</a><br> -->
      </div>
    </div>
  </div>
  <%@ include file="/jspf/footer.jspf" %>
  <%@ include file="/jspf/supportMail.jspf" %>
  
</body>
</html>
