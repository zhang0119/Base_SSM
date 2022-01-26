package org.example.service;

import org.example.dao.DepartmentMapper;
import org.example.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {

        List<Department> depts = departmentMapper.selectByExample(null);

        return depts;
    }
}
