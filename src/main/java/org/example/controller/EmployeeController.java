package org.example.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.example.pojo.Employee;
import org.example.pojo.Msg;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 这个处理器主要用来处理员工的CRUD请求的
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    //这个方法是封装保存后的新员工数据,这里我们使用restful风格
    @PostMapping("/emp")
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }


    //以json的形式返回封装好的分页数据
    @GetMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn){

        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 查询员工数据(分页查询)
     * @return 返回员工数据
     */
    //@GetMapping("/emps")
    /*public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,
                            Model model){

        PageHelper.startPage(pn,5);
        //这样写不是一个分页查询，我们现在引入pageHelper分页插件
        List<Employee> emps = employeeService.getAll();

        //使用pageInfo封装查询后的结果，只需要将pageInfo交给页面即可
        //后面的5表示一次查询5条数据
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }*/
}
