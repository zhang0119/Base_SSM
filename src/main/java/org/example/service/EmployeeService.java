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

    /**
     * 检验用户名是否可用
     * @param empName 待检验的用户名2
     * @return true 表示姓名可用<br/>false表示不可用
     */
    public boolean checkUser(String empName) {

        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        long count = employeeMapper.countByExample(example);

        return count == 0;
    }
}
