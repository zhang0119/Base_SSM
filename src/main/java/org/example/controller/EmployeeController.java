package org.example.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.example.pojo.Employee;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 这个处理器主要用来处理员工的CRUD请求的
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 查询员工数据(分页查询)
     * @return 返回员工数据
     */
    @GetMapping("/emps")
    public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,
                            Model model){

        PageHelper.startPage(pn,4);
        //这样写不是一个分页查询，我们现在引入pageHelper分页插件
        List<Employee> emps = employeeService.getAll();

        //使用pageInfo封装查询后的结果，只需要将pageInfo交给页面即可
        //后面的4表示一次查询4条数据
        PageInfo page = new PageInfo(emps);
        model.addAttribute("pageInfo",page);

        return "list";
    }
}
