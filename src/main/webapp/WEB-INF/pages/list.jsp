<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>

    <%
        String basePath = request.getScheme()
                + "://"
                + request.getServerName()
                + ":"
                + request.getServerPort()
                + request.getContextPath()
                + "/";
    %>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
</head>
<body>

    <div class="container">
        <%--整个页面分为4行--%>

        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>员工列表</h1>
            </div>
        </div>

        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>

        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover table-bordered">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>function</th>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑</button>
                                <button type="button" class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除</button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <%--分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前是第${pageInfo.pageNum}页，总共${pageInfo.pages}页,共${pageInfo.total}条记录
            </div>

            <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="<%=basePath%>emps?pn=1">首页</a></li>

                        <%--前一页，即当前页码-1--%>
                        <li>
                            <a href="<%=basePath%>emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>

                        <li>
                            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">

                                <%--这里我们需要做判断，如果是当前页码那么要高亮显示--%>
                                <%--当前页需要高亮--%>
                                <c:if test="${pageNum == pageInfo.pageNum}">
                                    <li class="active"><a href="<%=basePath%>emps?pn=${pageNum}">${pageNum}</a></li>
                                </c:if>
                                <%--非当前页--%>
                                <c:if test="${pageNum != pageInfo.pageNum}">
                                    <li><a href="<%=basePath%>emps?pn=${pageNum}">${pageNum}</a></li>
                                </c:if>
                            </c:forEach>
                        </li>

                        <%--下一页，即当前页码+1--%>
                        <li>
                            <a href="<%=basePath%>emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>

                        <li><a href="<%=basePath%>emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>

        </div>

    </div>



<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>

</body>
</html>
