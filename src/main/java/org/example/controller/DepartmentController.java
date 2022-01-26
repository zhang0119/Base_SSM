package org.example.controller;

import org.example.pojo.Department;
import org.example.pojo.Msg;
import org.example.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 这个类是专门去处理和部门有关的氢气
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     */
    @GetMapping("/depts")
    @ResponseBody
    public Msg getDepts(){

        List<Department> list = departmentService.getDepts();

        return Msg.success().add("depts",list);
    }
}
