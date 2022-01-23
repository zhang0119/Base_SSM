package org.example;

import org.example.dao.DepartmentMapper;
import org.example.dao.EmployeeMapper;
import org.example.pojo.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 推荐spring的项目就用spring-test的单元测试，可以自动导入我们需要的组件
 * 1、导入spring-test依赖
 * 2、类上加入@ContextConfiguration指定的Spring配置文件的位置
 * 3、直接@Autowired引入我们想要容器中的组件
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)  //@RunWith注解是junit提供的
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Test
    public void insertEmpTest(){
        int result = employeeMapper.insertSelective(new Employee(null, "zhongli", "男", "450897483@qq.com", 1));
        System.out.println("result:"+result);
    }

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){

        //1.创建springIOC容器
        /*ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");*/
        //2.从容器中获取mapper
        /*DepartmentMapper bean = context.getBean(DepartmentMapper.class);*/

        //测试能否从容器中拿到映射对象
        System.out.println(departmentMapper);

    }
}
