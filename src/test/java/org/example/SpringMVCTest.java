package org.example;

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)  //@RunWith注解是junit提供的
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-mvc.xml"})
@WebAppConfiguration
public class SpringMVCTest {

    //传入SpringMVC的ioc
    @Autowired
    private WebApplicationContext context;

    //虚假mvc请求，获取到处理结果
    private MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testMVC() throws Exception{
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps")
                .param("pn", "1")).andReturn();

        System.out.println(result);

        //请求成功以后，请求域中会有pageInfo，我们可以取出pageInfo进行验证
//        MockHttpServletRequest request = result.getRequest();
//        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
//
//        System.out.println("当前页码:"+pi.getPageNum());
    }
}
