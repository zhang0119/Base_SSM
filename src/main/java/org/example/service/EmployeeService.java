package org.example.service;

import org.example.dao.EmployeeMapper;
import org.example.pojo.Employee;
import org.example.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll() {

        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id asc");

        return employeeMapper.selectByExampleWithDept(employeeExample);
    }

    /**
     * 处理员工保存的方法
     * @param employee 新用户的数据
     */
    public void saveEmp(Employee employee) {

         employeeMapper.insertSelective(employee);
    }
}
