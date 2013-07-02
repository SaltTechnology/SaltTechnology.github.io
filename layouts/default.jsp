<%@ page pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
  <style type="text/css">
    a.disabled-link,
    a.disabled-link:visited,
    a.disabled-link:active,
    a.disabled-link:hover {
      background-color:#d9d9d9 !important;
      color:#aaa !important;
    }

    .dropdown-menu .nav-header,
  	.dropdown-menu .role {
      font-style: italic;
      margin-left: 0;
      padding: 3px 20px;
    }
  </style>
  <decorator:head/>
  <title><decorator:title/></title>
</head>
<body>
  <div class="navbar navbar-static-top">
    <div class="navbar-inner">
      <div class="container-fluid">
        <a class="brand" href="${pageContext.request.contextPath}/"><img alt="Logo" src="static/img/salt-logo-tiny.png"/></a>
        <span class="brand">${msg.companyBrand}</span>
        <ul class="nav pull-right">
          <li><a id="logoutLink" href="security/logout">${msg.logout}</a>
        </ul>
      	<c:if test="${organizationContext.organization.class.simpleName != 'NotMerchant'}">
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
        </c:if>
      </div>
    </div>
  </div>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span3" id="sidebar">
        <div class="sidebar-nav">
          <ul class="nav nav-list well">
            <li class="nav-top">${msg.userAccount}
            <li>
              <div class="btn-group row-fluid">
                <!-- id=myAccountDropDownLink is been used for automated test, please do not remove -->
                <button id="myAccountDropDownLink" class="btn span11 dropdown-toggle" data-toggle="dropdown">
                  <i class="icon-user"></i> <span id="userPrincipal">${userContext.userAccount.email}</span>
                </button>
                <button class="btn dropdown-toggle" data-toggle="dropdown">
                  <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                  <li><a id="myAccountLink" href="user/myaccount">${msg.userAccountSettings}...</a>
                  <li class="divider">
                  <li><a href="security/logout">${msg.logout}</a>
                </ul>
              </div>
            </li>
          </ul>
          <ul class="nav nav-list well">
            <li class="nav-top">${msg.merchantAccount}
            <li>
              <div class="btn-group row-fluid">
                <c:choose>
                  <c:when test="${!empty organizationContext.organization.name}">
                    <button id="orgDropDownLink" class="btn span11 dropdown-toggle" data-toggle="dropdown">
                      ${organizationContext.organization.name}
                    </button>
                    <button class="btn dropdown-toggle" data-toggle="dropdown">
                      <span class="caret"></span>
                    </button>
                  </c:when>
                  <c:otherwise>
                    <button class="btn span11 dropdown-toggle" data-toggle="dropdown">
                      - none -
                    </button>
                    <button class="btn dropdown-toggle" data-toggle="dropdown">
                      <span class="caret"></span>
                    </button>
                  </c:otherwise>
                </c:choose>
                <ul id="orgDropDownMenu" class="dropdown-menu">
                  <c:forEach var="row" items="${userContext.organizations}" varStatus="rowStatus">
                    <c:choose>
                      <c:when test="${rowStatus.count <= msg.organizationChooserMaxRowCount}">
                        <li>
                          <c:choose>
                            <c:when test="${row.active eq false}">
                              <a class="disabled-link">
                            </c:when>
                            <c:otherwise>
                              <a href="organization/${row.organizationId}/choose">
                            </c:otherwise>
						  </c:choose>
                          <c:if test="${row.organizationId eq organizationContext.organizationId}">
                            <i class="icon-flag"></i>
                          </c:if>
                          ${row.name}
                          </a>
                        </li>
                      </c:when>
                      <c:otherwise>
                        <c:if test="${rowStatus.last}">
                          <li><a href="merchant/">${msg.hasMore}</a>
                        </c:if>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>

                  <li class="divider">
                  <li><a href="merchant/">${msg.chooseOrganizationLabel}...</a>

                  <li class="divider">
                  <li class="nav-header">Roles
                  <c:choose>
                    <c:when test="${empty organizationContext.roles}">
                      <li class="role">-- none --
                    </c:when>
	                <c:otherwise>
	                  <c:forEach var="row" items="${organizationContext.roles}">
	                    <li class="role">${row.name}
	                  </c:forEach>
	                </c:otherwise>
                  </c:choose>
                </ul>
              </div>
            </li>
           
            <c:if test="${Permission.PAYMENT_SHOW.permitted
                         || Permission.SETTLEMENT_SHOW.permitted}">
	            <li class="nav-header">${msg.orders}
	            <c:if test="${Permission.PAYMENT_SHOW.permitted}">
	            	<li id="navitem-payments"><a href="payment">${msg.transactions}</a>
	            </c:if>
	            <c:if test="${Permission.SETTLEMENT_SHOW.permitted}">
	            	<li id="navitem-settlement"><a href="settlement" >${msg.settlement}</a>
	            </c:if>
	        </c:if>

            <c:if test="${organizationContext.organization.class.simpleName != 'NotMerchant'}">
              <c:if test="${Permission.ORGANIZATION_PROFILE_SHOW.permitted
                         || Permission.ORGANIZATION_CONTACT_SHOW.permitted
                         || Permission.MERCHANT_SERVICE_SHOW.permitted}">
                <li class="nav-header">${msg.settings}
                <c:if test="${Permission.ORGANIZATION_PROFILE_SHOW.permitted}">
                  <li id="navitem-profile"><a id="profileLink" href="profile">${msg.profileLabel}</a>
                </c:if>
                <c:if test="${Permission.ORGANIZATION_CONTACT_SHOW.permitted}">
                  <li id="navitem-contacts"><a id="contactLink" href="contact">${msg.contactLabel}</a>
                </c:if>
                <c:if test="${Permission.MERCHANT_SERVICE_SHOW.permitted}">
                  <li id="navitem-services"><a id="serviceListLink" href="service">${msg.serviceLabel}</a>
                </c:if>
              </c:if>
            </c:if>
            <li class="nav-header">${msg.administrationLabel}
            <c:if test="${Permission.MEMBERSHIP_SHOW.permitted}">
              <li id="navitem-users"><a id="membershipLink" href="membership/">${msg.members}</a>
            </c:if>
            <c:if test="${Permission.AUDIT_LOG_SHOW.permitted}">
              <li id="navitem-auditlog"><a id="auditLogLink" href="auditlog/">${msg.activityLog}</a>
            </c:if>
          </ul>
          <c:if test="${Permission.USER_ACCOUNT_SHOW.permitted
                     || Permission.ROLE_EDIT.permitted}">
            <ul class="nav nav-list well">
              <li class="nav-top">${msg.companyBrand}
              <li id="navitem-merchants"><a href="merchant/">${msg.merchants}</a>
              <c:if test="${Permission.USER_ACCOUNT_SHOW.permitted}">
                <li id="navitem-useraccounts"><a id="userListLink" href="user/">${msg.globalUsers}</a>
              </c:if>
              <c:if test="${Permission.ROLE_EDIT.permitted}">
                <li id="navitem-role"><a href="role/">${msg.roles}</a>
              </c:if>
            </ul>
          </c:if>
        </div>
      </div>
      <div class="span9">
        <decorator:body/>
      </div>
    </div>
  </div>
 
  <%@ include file="/WEB-INF/jspf/footer.jspf" %>
  <%@ include file="/WEB-INF/jspf/supportMail.jspf" %>

  <!-- Placed at the end of the document so the pages load faster -->
  <script>
    $(function() {
      // Add active class to current navbar item.
      var navitem = $(".content").data("navitem");
      $("#navitem-" + navitem).addClass("active");

      // Insert CSRF prevention token into form elements.
      $("form").append(
          '<input type="hidden" name="csrfToken" value="${csrfToken}">');

      // CSRF prevention for AJAX requests checks for this header.
      $("body").ajaxSend(function (ev, xhr, settings) {
        xhr.setRequestHeader("X-Requested-By", "XMLHttpRequest");
      });
    });

  </script>
</body>
</html>
