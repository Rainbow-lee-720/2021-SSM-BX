package com.stu.controller;

import com.stu.bean.Employ;
import com.stu.bean.Interview;
import com.stu.bean.Student;
import com.stu.exception.MyException;
import com.stu.service.EmployService;
import com.stu.service.InterviewService;
import com.stu.service.StudentService;
import com.stu.util.PageModel;
import com.stu.util.ResultAction;
import com.stu.util.SubmitData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @ClassName StudentController
 * @Description 学生Controller
 * @Author BX
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/
@Controller(value = "studentController")
@RequestMapping(value = "/student")
public class StudentController {

    //spring自动注入studentService对象
    @Autowired
    private StudentService studentService;
    @Autowired
    private EmployService employService;
    @Autowired
    private InterviewService interviewService;

    /**
     * @Author BX
     * @Description //登录校验用户名、密码
     * @Date 23:05 2020/12/7 0008
     * @Param [stuId, stuPwd, request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/doLogin"})
    public @ResponseBody ResultAction doLogin(@ModelAttribute("username")String stuId, @ModelAttribute("password")String stuPwd, HttpServletRequest request) throws MyException {
        //获取传送过来的数据
        //调用Service层方法
        Student student = studentService.doLogin(stuId,stuPwd);
        //封装返回结果
        ResultAction result = null;
        if(student == null){
            //用户名或密码错误
            result = new ResultAction(false,"用户名、密码或用户选择有误 请重新登录");
        }else if(student.getStuPower().equals("-1")){
            // 账号已注销
            result = new ResultAction(false,"账号已注销 请重新注册");
        }else{
            //将用户保存到session中
            request.getSession().setAttribute("student",student);
            System.out.println(student.getStuName() + "------>>学生登录成功<<-------");
            //登录成功
            result = new ResultAction(true,"登录成功","../student/main_stu.jsp");
        }
        return result;
    }

    /**
     * @Author BX
     * @Description //学生注册
     * @Date 14:20 2020/12/7 0010
     * @Param [data]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/stuRegist"})
    @ResponseBody
    public ResultAction stuRegist(@RequestBody SubmitData data) {
        //接收注册页面传送过来的表单数据
        Student student = data.getStudent();
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = studentService.stuRegist(student);
            //判断此注册的用户是否已经存在
            if(flag){
                //注册成功
                resultAction = new ResultAction(true,"注册成功 请登录","../main/index.jsp");
            }
            return resultAction;
        } catch (MyException e) {
            e.printStackTrace();
            //抛出service层异常信息 @ResponseBody通过json格式数据返回给前端
            return new ResultAction(false,e.getMessage());
        }
    }

    /**
     * @Author BX
     * @Description //学生信息管理模块 学生信息分页查询
     * @Date 16:13 2020/12/12 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryStuByPage"})
    public ModelAndView queryStuByPage(HttpServletRequest request) throws MyException {
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Student> studentPageModel = null;
        try {
            studentPageModel = studentService.queryStuByPage(pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("studentPageModel",studentPageModel);
        //跳转到stu_admin.jsp
        modelAndView.setViewName("admin/stu_admin");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据四个条件动态查询学生信息
     * @Date 15:10 2020/12/21 0021
     * @Param [student]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryStuByFourCon"}, method = RequestMethod.POST)
    public ModelAndView queryStuByFourCon(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //接收查询页面传送过来的表单数据
        Student student = data.getStudent();
        int stuNo = student.getStuNo();
        String stuNoStr = String.valueOf(stuNo);
        if(stuNoStr.equals("0")){
            stuNoStr = "";
        }
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Student> studentPageModel = null;
        try {
            studentPageModel = studentService.queryStuByFourCon(stuNoStr,student.getStuName(),student.getStuSex(),student.getStuSchool(),pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("studentPageModel",studentPageModel);
        //跳转到stu_admin_query.jsp
        modelAndView.setViewName("admin/stu_admin_query");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //学生信息管理模块 学生信息分页查询 数据回显
     * @Date 16:13 2020/2/3 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryStuByPageNew"})
    public ModelAndView queryStuByPageNew(HttpServletRequest request) throws MyException {
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Student> studentPageModel = null;
        try {
            studentPageModel = studentService.queryStuByPage(pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("studentPageModel",studentPageModel);
        //跳转到stu_admin_query.jsp
        modelAndView.setViewName("admin/stu_admin_query");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据学号查询学生信息 用于显示学生详细信息 前端表格展示
     * @Date 11:33 2020/2/5 0005
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryStuInfo"})
    @ResponseBody
    public ResultAction queryStuInfo(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的学号
        String stuNo = request.getParameter("stuNo");
        //类型转换
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        //查询数据库 根据学号查询学生信息 queryStuByNo
        Student student = studentService.queryStuInfo(stuNo2);
        //保存数据 页面跳转
        if(student == null){
            //学生数据不存在
            resultAction = new ResultAction(false,"该学生信息不存在");
        }else{
            //查询成功
            resultAction = new ResultAction(true,student);
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //前端页面删除学生数据
     * @Date 13:42 2020/2/5 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/delStu"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction delStu(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的学号
        String stuNo = request.getParameter("stuNo");
        //类型转换
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        //删除前先校验此账号下是否有数据
        List<Interview> interList = interviewService.queryInterByStuNo(stuNo2);
        List<Employ> empList = employService.queryEmpByStuNo(stuNo2);
        if(interList.size() > 0 || empList.size() > 0) {
            //保存数据 页面跳转
            resultAction = new ResultAction(false,stuNo);
            return resultAction;
        }else{
            //查询数据库 根据学号删除学生信息
            Boolean aBoolean = studentService.delStu(stuNo2);
            //保存数据 页面跳转
            resultAction = new ResultAction(aBoolean,stuNo);
            return resultAction;
        }
    }

    /**
     * @Author BX
     * @Description //学生个人中心 回显当前登录的学生个人信息 并在页面中进行个人信息修改
     * @Date 13:09 2020/2/11 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/stuCenter"})
    public ModelAndView stuCenter(HttpServletRequest request) throws MyException {
        ModelAndView modelAndView = new ModelAndView("student/center_stu");
        //获取客户端的学号
        String stuNoStr = request.getParameter("stuNo");
        //类型转换
        int stuNo = Integer.valueOf(stuNoStr).intValue();
        //调用Service层方法 根据学号编号查询学生信息
        Student student = studentService.queryStuByNoCenter(stuNo);
        //将查询结果保存在modelAndView中
        modelAndView.addObject("stuInfo",student);
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //学生个人中心 回显当前登录的学生个人信息 并在页面中进行个人信息修改
     * @Date 13:09 2020/2/11 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/updateStu"})
    @ResponseBody
    public ResultAction updateStu(@RequestBody SubmitData data) throws MyException {
        //接收注册页面传送过来的表单数据
        Student student = data.getStudent();
        //封装参数
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = studentService.updateStu(student.getStuNo(),student.getStuId(),student.getStuName(),student.getStuAge(),student.getStuSex(),student.getStuSchool(),student.getStuSpecialty(),student.getStuPhone(),student.getStuAddress(),student.getStuDegree());
            //判断是否修改成功
            if(flag){
                //修改成功
                resultAction = new ResultAction(true,"修改成功 请更新您的求职信息");
            }else {
                //修改失败 抛出异常
                resultAction = new ResultAction(false,"学生信息修改失败");
            }
            return resultAction;
        } catch (MyException e) {
            e.printStackTrace();
            //抛出service层异常信息 @ResponseBody通过json格式数据返回给前端
            return new ResultAction(false,e.getMessage());
        }
    }

    /**
     * @Author BX
     * @Description //账号注销
     * @Date 10:40 2020/2/19 0019
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/logOutCom"})
    @ResponseBody
    public ResultAction logOutCom(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的学号
        String stuNo = request.getParameter("stuNo");
        //类型转换
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        //查询数据库 根据学号修改学生权限为-1 logOutCom
        Boolean aBoolean = studentService.logOutCom(stuNo2);
        //保存数据 页面跳转
        if(aBoolean){
            //修改成功
            resultAction = new ResultAction(aBoolean,"学生账号:" + stuNo2 + "注销成功");
        }else{
            //修改失败
            resultAction = new ResultAction(aBoolean,"学生账号:" + stuNo2 + "注销失败");
        }
        return resultAction;
    }

}
