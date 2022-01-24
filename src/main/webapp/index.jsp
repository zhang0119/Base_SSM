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
            <table class="table table-hover table-bordered" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>function</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>



            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>

        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>

    </div>

</div>



<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>

<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>

<script type="text/javascript">
    //1.页面加载完成后，直接去发送ajax请求，要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    //这个函数是负责跳转页面的
    function to_page(pn){
        $.ajax({
            url:"<%=basePath%>emps",
            data:"pn="+pn,
            type:"get",
            success:function(result){
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.显示分页条信息
                build_page_nav(result);
            }
        })
    }

    //下面编写两个方法处理员工数据和分页
    function build_emps_table(result){
        //清空table表格
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        //接下来我遍历这个员工的信息
        $.each(emps,function(index,item){

            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<td></td>").addClass("btn btn-success btn-sm")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil")
                .append("编辑");

            var delBtn = $("<td></td>").addClass("btn btn-danger btn-sm")
                .append("<span></span>").addClass("glyphicon glyphicon-trash")
                .append("删除");

            var btnTd = $("<td></td>").append(editBtn).append("   ").append(delBtn);

            //append方法执行完以后还是返回原来的元素
            $("<tr></tr>").append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(deptNameTd)
                        .append(btnTd)
                        .appendTo("#emps_table tbody");
        })
    }

    //这个函数的功能是处理分页信息
    function build_page_info(result){
        $("#page_info_area").empty();

        $("#page_info_area").append("当前是第"+result.extend.pageInfo.pageNum+"页，" +
            "总"+result.extend.pageInfo.pages+"页，" +
            "共"+result.extend.pageInfo.total+"条记录");
    }

    //这个函数是处理分页条的
    function build_page_nav(result){

        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

        //如果是第一页，我们禁用上一页
        if(result.extend.pageInfo.hasPreviousPage === false){
            //表示没有上一页
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        let lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //如果是最后一页，我们要禁用下一页
        if(result.extend.pageInfo.hasNextPage === false){
            //表示没有下一页
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }

        firstPageLi.click(function(){
            to_page(1);
        });
        prePageLi.click(function(){
            let pn = result.extend.pageInfo.pageNum-1;
            to_page(pn);
        });

        nextPageLi.click(function(){
            let pn = result.extend.pageInfo.pageNum+1;
            to_page(pn);
        });

        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);

        //遍历页号
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
            let numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum === item){
                numLi.addClass("active");
            }

            numLi.click(function(){
                to_page(item);
            });
            //添加页号的提示
            ul.append(numLi);
        });

        //添加末页和后一页的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav标签中
        let navEle = $("<nav></nav>").append(ul);

        //最后我们将做好的分页条加入到对应的位置即可
        navEle.appendTo("#page_nav_area");

    }
</script>

</body>
</html>
