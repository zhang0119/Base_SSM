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

<%--员工添加的模态框------------------------------------------------------------------------------------%>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <%--员工姓名--%>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--员工邮箱--%>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--员工性别--%>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio1" value="男" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio2" value="女"> 女
                            </label>
                        </div>
                    </div>

                    <%--部门名称--%>
                    <div class="form-group">

                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId">
                                <%--<option>1</option>--%>
                            </select>
                        </div>
                    </div>
                </form>




            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>


<%--员工添加的模态框------------------------------------------------------------------------%>



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
            <button id="emp_add_modal_btn" type="button" class="btn btn-primary">新增</button>
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

    //引入总记录数
    var totalRecord;

    //1.页面加载完成后，直接去发送ajax请求，要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    //数据库层面校验员工输入的信息是否合法
    $("#empName_add_input").change(function(){
        //第一种获取empName的方法
        /*let empName = $("#empName_add_input").val();*/
        //第二种获取empName的方法
        let empName = this.value;
        //发送ajax请求校验用户名是否可用
        $.ajax({
            url:"<%=basePath%>checkUser",
            type:"get",
            data:"empName="+empName,
            success:function(result){
                //后端会返回两种结果，这里我们做个判断
                /*alert(result);*/
                if(result.code === 100){
                    //100表示处理成功
                    show_validate_msg("#empName_add_input","success","用户名可用!");
                    //这里我们给提交按钮加上一个属性，用来判断到底该不该提交
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }

        })
    });

    //校验表单数据
    function validate_add_form(){
        //1.拿到要校验的数据，使用正则表达式
        let empName = $("#empName_add_input").val();
        let realEmpName = empName.trim();
        //这个正则表达式表示可以使用a-z、A-Z、0-9和-_ 4到16位，还可以使用中文，长度是2-5位，中间的 | 表示扩展。
        let regExp = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        //alert(regExp.test(realEmpName));
        if(!regExp.test(realEmpName)){
            //alert("用户名建议2-5位中文或者4-16位英文和数字的组合");
            //应该清空这个元素之前的样式,我们抽取出这个方法(清空样式的功能)
            //现在我们抽取这个功能，直接调用这个方法
            show_validate_msg("#empName_add_input","error","用户名建议2-5位中文或者4-16位英文和数字的组合!");

            /*$("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next().text("用户名建议2-5位中文或者4-16位英文和数字的组合");*/
            return false;
        }else{

            show_validate_msg("#empName_add_input","success","");
            //验证成功
            /*$("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next().text("");*/

        }

        //下一步，校验邮箱信息
        let email = $("#email_add_input").val();
        let emailRegExp = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+/;
        let realEmail = email.trim();
        //alert(emailRegExp.test(realEmail));
        if(!emailRegExp.test(realEmail)){
            //调用show
            show_validate_msg("#email_add_input","error","请使用正确的邮箱格式");
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next().text("请使用正确的邮箱格式");*/
            return false;
        }else{
            //邮箱合法
            show_validate_msg("#email_add_input","success","");
            return true;
            /*$("#empName_add_input").parent().addClass("has-success");
            $("#email_add_input").next().text("");*/
        }

    }

    /*
    *
    * */
    function show_validate_msg(ele,status,msg){
        //清楚当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        //清楚span标签内的内容
        $(ele).next("span").text("");

        if("success" === status){
            /*show_validate_msg("#empName_add_input","success","");*/
            /*$("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next().text("");*/
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);

        }else if("error" === status){
            /*show_validate_msg("#empName_add_input","error","用户名建议2-5位中文或者4-16位英文和数字的组合!");*/
            /*$("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next().text("用户名建议2-5位中文或者4-16位英文和数字的组合");*/
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);

        }
    }

    //当用户点击模态框里的保存按钮就可以保存新员工的信息
    $("#emp_save_btn").click(function(){
        //0、先对要提交给服务器的表单数据进行校验
        //如果校验失败，我们直接return false , 下面的是前端校验

        if(!validate_add_form()){
            return false;
        }

        //1.将模态框中填写的表单数据交给服务器进行保存

        //1.5、判断之前的ajax用户名校验是否成功
        if($(this).attr("ajax-va") === "error"){
            return false;
        }

        //2.发送ajax请求保存员工
        $.ajax({
            url:"<%=basePath%>emp",
            type:"post",
            data:$("#empAddModal form").serialize(),
            success:function(result){

                //现在后端会给我们传入success和error两种情况，我们这里需要做个判断，不能简单只判断哪一种情况.
                if(result.code === 100){
                    //alert(result.msg);
                    //当用户保存成功后，我们需要做两个工作：
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.跳转到最后一页
                    //我们给to_page()方法里面传入一个很大的数字，让它自动跳转到最后一页
                    //这里我用总记录数来表示这个很大的数字，因为他肯定大于总页码
                    to_page(totalRecord);
                }else{
                    //用户校验失败，这里显示失败信息
                    //console.log(result);
                    /*alert(result.extend.errorFields.email);
                    alert(result.extend.errorFields.empName);*/ //undefined
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }
            }
        });

    });

    //表单重置的函数
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //清理表单下方的文本
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function(){

        /*当用户点击新增按钮时，应该清除输入框里的内容*/
        /*$("#empName_add_input").val("");
        $("#email_add_input").val("");*/

        reset_form("#empAddModal form");

        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts();

        $("#empAddModal").modal({
            backdrop:"static"
        });


    });

    //查出所有部门信息并显示在下拉列表中
    function getDepts(){
        //每次查询部门信息都要清空上一次的查询信息
        $("#empAddModal select").empty();

        $.ajax({
            url:"<%=basePath%>depts",
            type:"get",
            success:function (result) {
                //这个result里面都是从数据库中查询到的部门信息
                //console.log(result);
                //显示部门信息在下拉列表中
                /*$("#empAddModal select").append();*/
                $.each(result.extend.depts,function(){
                    //this对象表示当前正在遍历的对象
                    let optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo("#empAddModal select");

                });

            }
        })
    }

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

        totalRecord = result.extend.pageInfo.total;

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
        }else{
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                let pn = result.extend.pageInfo.pageNum-1;
                to_page(pn);
            });
        }

        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        let lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //如果是最后一页，我们要禁用下一页
        if(result.extend.pageInfo.hasNextPage === false){
            //表示没有下一页
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //不是最后一页
            nextPageLi.click(function(){
                let pn = result.extend.pageInfo.pageNum+1;
                to_page(pn);
            });

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });

        }

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
