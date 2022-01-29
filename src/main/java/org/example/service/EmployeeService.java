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

    /**
     * 按照员工的id查询员工
     * @param id 待查询员工的id
     * @return 待查询员工的信息
     */
    public Employee getEmp(Integer id) {

        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 员工更新
     * @param employee 待更新的员工信息
     */
    public void updateEmp(Employee employee) {
        //根据主键有选择的更新
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 根据员工id删除员工
     * @param id 待删除员工的id
     */
    public void deleteEmp(Integer id) {
         employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {

        //根据条件删除员工
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        //使用完上面三行代码后，sql语句就会变成:
        // delete from xxx where emp_id in(1,2,3)
        employeeMapper.deleteByExample(example);

    }
}
