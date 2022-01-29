package org.example.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.example.pojo.Employee;
import org.example.pojo.Msg;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 这个处理器主要用来处理员工的CRUD请求的
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    //单个删除用户的功能
    //现在我们把这个方法改造成单个删除和全部删除二合一
    //批量删除：1-2-3
    //单个删除:1
    @DeleteMapping(value="/emp/{ids}")
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            //这是批量删除的操作
            List<Integer> del_ids = new ArrayList<>();
            //分割字符串 得到一个数组
            String[] str_ids = ids.split("-");
            //创建一个批量删除员工的方法
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);

        }else{
            //这是单个删除的操作
            //将String类型的ids转为int类型
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    //保存员工的功能
    @PutMapping("/emp/{empId}")
    @ResponseBody
    public Msg saveEmp(Employee employee){

        System.out.println("将要更新的数据:"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    //查询员工的处理器,因为是查询操作，我们使用get请求方式restful风格
    @GetMapping(value="/emp/{id}")
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){

        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    //这个方法是检测用户输入的姓名和数据库里面的是否有冲突
    @GetMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName")String empName){

        //后端校验
        String nameRegExp = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(nameRegExp)){
            //这里表示匹配失败
            return Msg.fail().add("va_msg","用户名必须是4-16位或者中文2-5位");
        }

        //数据库用户名重复校验
        boolean result = employeeService.checkUser(empName);
        if(result){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    //这个方法是封装保存后的新员工数据,这里我们使用restful风格
    //bindingResult是封装校验的结果
    @PostMapping("/emp")
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){

            //我们用map集合封装这些错误信息
            Map<String, Object> map = new HashMap<String, Object>();
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println("错误的字段名:"+error.getField());
                System.out.println("错误信息:"+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            //保存成功
            employeeService.saveEmp(employee);
            return Msg.success();
        }

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
