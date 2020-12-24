package com.stu.controller;

import com.stu.bean.Admin;
import com.stu.exception.MyException;
import com.stu.service.AdminService;
import com.stu.util.ResultAction;
import com.stu.util.SubmitData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName AdminController
 * @Description 管理员Controller
 * @Author BX
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/
@Controller(value = "adminController")
@RequestMapping(value = "/admin")
public class AdminController {

    //spring自动注入adminService对象
    @Autowired
    private AdminService adminService;

    /**
     * @Author BX
     * @Description //登录校验用户名、密码
     * @Date 23:05 2020/12/7 0008
     * @Param [adminId, adminPwd, request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/doLogin"})
    public @ResponseBody ResultAction doLogin(@ModelAttribute("username")String adminId, @ModelAttribute("password")String adminPwd, HttpServletRequest request) throws MyException {
        //调用Service层方法
        Admin admin = adminService.doLogin(adminId,adminPwd);
        //封装返回结果
        ResultAction result = null;
        if(admin == null){
            //用户名或密码错误
            result = new ResultAction(false,"用户名、密码或用户选择有误 请重新登录");
        }else{
            //将用户保存到session中
            request.getSession().setAttribute("admin",admin);
            //登录成功
            System.out.println(admin.getAdminName() + "------>>管理员登录成功!<<-------");
            result = new ResultAction(true,"登录成功","../admin/main_admin.jsp");
        }
        return result;
    }

    /**
     * @Author BX
     * @Description //管理员个人中心 回显当前登录的管理员个人信息 并在页面中进行个人信息修改
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/adminCenter"})
    public ModelAndView adminCenter(HttpServletRequest request) throws MyException {
        ModelAndView modelAndView = new ModelAndView("admin/center_admin");
        //获取客户端的管理员编号
        String adminNoStr = request.getParameter("adminNo");
        //类型转换
        int adminNo = Integer.valueOf(adminNoStr).intValue();
        //调用Service层方法 根据管理员编号查询管理员信息
        Admin admin = adminService.queryAdminByNoCenter(adminNo);
        //将查询结果保存在modelAndView中
        modelAndView.addObject("adminInfo",admin);
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //管理员个人中心 回显当前登录的管理员个人信息 并在页面中进行个人信息修改
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/updateAdmin"})
    @ResponseBody
    public ResultAction updateAdmin(@RequestBody SubmitData data) throws MyException {
        //接收注册页面传送过来的表单数据
        Admin admin = data.getAdmin();
        //封装参数
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = adminService.updateAdmin(admin.getAdminNo(),admin.getAdminId(),admin.getAdminName(),admin.getAdminPhone(),admin.getAdminSex());
            //判断是否修改成功
            if(flag){
                //修改成功
                resultAction = new ResultAction(true,"管理员信息修改成功");
            }else {
                //修改失败 抛出异常
                resultAction = new ResultAction(false,"管理员信息修改失败");
            }
            return resultAction;
        } catch (MyException e) {
            e.printStackTrace();
            //抛出service层异常信息 @ResponseBody通过json格式数据返回给前端
            return new ResultAction(false,e.getMessage());
        }
    }


}
