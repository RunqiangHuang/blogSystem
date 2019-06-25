<%--
  Created by IntelliJ IDEA.
  User: HuangRunqiang
  Date: 2019/5/17
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<html>
  <head>
    <title>测试框架页面</title>
  </head>
  <body>
    <form action="${pageContext.request.contextPath }/loginAction" method="post">
      账号：<input type="text" name="account"> <br>
      密码：<input type="text" name="password"> <br>
      <input type="submit">
    </form>
  </body>
</html>
