package com.stu.controller;

import com.stu.bean.Admin;
import com.stu.bean.Company;
import com.stu.bean.Student;
import com.stu.constant.Constant;
import com.stu.exception.MyException;
import com.stu.service.AdminService;
import com.stu.service.CompanyService;
import com.stu.service.StudentService;
import com.stu.util.ResultAction;
import com.stu.util.StringEmpty;
import com.stu.util.SubmitData;
import com.stu.util.VerifyCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.LinkedHashMap;

/**
 * @ClassName UtilController
 * @Description 公用的Controller
 * @Author BX
 * @Date 2020/12/5 0007 22:31
 * @Version 1.0
 **/
@Controller(value = "utilController")
@RequestMapping(value = "/utilController")
public class UtilController {

    //注入依赖
    @Autowired
    private StudentService studentService;
    @Resource(name = "companyService")
    private CompanyService companyService;
    @Autowired
    private AdminService adminService;

    /**
     * @Author BX
     * @Description //登录校验集中controller 接受前端表单的用户名、密码、验证码、权限 然后通过权限跳转到对应权限的controller
     * @Date 22:47 2020/12/5 0008
     * @Param [data, redirectAttributes, session]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = "/doLogin",method = RequestMethod.POST)
    public @ResponseBody ModelAndView doLogin(@RequestBody SubmitData data, RedirectAttributes redirectAttributes, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        //获取前端传送的数据
        String username = (String) data.getEntityData().get("username");
        String password = (String) data.getEntityData().get("password");
        //前端用户输入的验证码
        String checkCode = (String) data.getEntityData().get("checkCode");
        //用户权限
        String power = (String) data.getEntityData().get("power");
        //权限转换为int
        int userPower = Integer.valueOf(power).intValue();

        //将用户名和密码封装到工具类的对象中 用于传送到其他controller
        redirectAttributes.addFlashAttribute("username",username);
        redirectAttributes.addFlashAttribute("password",password);

        //获取session中存储的验证码
        String verifyCodeValue=(String) session.getAttribute("verifyCodeValue");

        //校验验证码
        if(!(verifyCodeValue.equals(checkCode.toUpperCase()))){
            //验证码错误，发送错误提示并跳转到主页index.jsp
            modelAndView.setViewName("main/index");
            return modelAndView;
        }else{
            if(userPower == Constant.STUDENT_POWER){
                //学生权限
                modelAndView.setViewName("redirect:/student/doLogin");
                return modelAndView;
            }else if(userPower == Constant.COMPANY_POWER){
                //企业权限
                modelAndView.setViewName("redirect:/company/doLogin");
                return modelAndView;
            }else{
                //管理员权限
                modelAndView.setViewName("redirect:/admin/doLogin");
                return modelAndView;
            }
        }
    }

    /**
     * @Author BX
     * @Description //获取验证码
     * @Date 22:51 2020/12/7 0007
     * @Param [response, session]
     * @return void
     **/
    @RequestMapping("/getVerifyCode")
    public void generate(HttpServletResponse response, HttpSession session) {
        //创建字节流 用于输入读取验证码图片
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        //调用工具类方法验证码
        String verifyCodeValue = VerifyCode.drawImg(output);
        //将生成的验证码保存在session对象中
        session.setAttribute("verifyCodeValue", verifyCodeValue);
        //获取输出字节流 将验证码图片输出到前端
        try {
            ServletOutputStream out = response.getOutputStream();
            output.writeTo(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * @Author BX
     * @Description //跳转到登录页面 公共跳转方法
     * @Date 16:06 2020/12/15 0015
     * @Param []
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping("/visitLogin")
    public ModelAndView visitLogin() {
        ModelAndView modelAndView = new ModelAndView("main/quit");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //登录时Ajax校验用户名
     * @Date 11:19 2020/12/21 0021
     * @Param [username]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = "/checkNoAjax", method = RequestMethod.POST)
    @ResponseBody
    public ResultAction checkNoAjax(@RequestBody SubmitData submitData) {
        String username = submitData.getUsername();
        ResultAction resultAction = new ResultAction();
        //查询数据库验证此用户名是否已经存在
        Boolean boo = null;
        try {
            if(username.indexOf("s") != -1){
                //查询用户是否被注销
                Student student = studentService.queryStuByIdStu(username);
                if(StringEmpty.stringIsEmpty(student)){
                    resultAction.setResult(false);
                    resultAction.setMsg1("服务器异常 请重试");
                    return resultAction;
                }else{
                    if(!(student.getStuPower().equals("-1"))){
                        //未被注销
                        boo = studentService.queryStuById(username);
                    }else{
                        //已被注销
                        boo = false;
                    }
                }
            }else if(username.indexOf("c") != -1) {
                //查询用户是否被注销
                Company company = companyService.queryComByIdCom(username);
                if(StringEmpty.stringIsEmpty(company)){
                    resultAction.setResult(false);
                    resultAction.setMsg1("服务器异常 请重试");
                    return resultAction;
                }else{
                    if(!(company.getComPower().equals("-1"))){
                        //未被注销
                        boo = companyService.queryComById(username);
                    }else{
                        //已被注销
                        boo = false;
                    }
                }
            }else if(username.indexOf("a") != -1) {
                boo = adminService.queryAdminById(username);
            }else{
                resultAction.setResult(false);
                resultAction.setMsg1("用户名不合法 请重新输入");
                return resultAction;
            }
            if(boo) {
                resultAction.setResult(true);
                resultAction.setMsg1("用户名已注册 可直接登录");
            }else {
                resultAction.setResult(false);
                resultAction.setMsg1("账号已注销 请重新注册");
            }
        } catch (MyException e) {
            e.printStackTrace();
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //登注册时Ajax校验用户名
     * @Date 14:09 2020/12/21 0021
     * @Param [submitData]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = "/checkNoAjaxRegist", method = RequestMethod.POST)
    @ResponseBody
    public ResultAction checkNoAjaxRegist(@RequestBody SubmitData submitData) {
        String username = submitData.getUsername();
        ResultAction resultAction = new ResultAction();
        //查询数据库验证此用户名是否已经存在
        Boolean boo = null;
        try {
            if(username.indexOf("s") != -1){
                boo = studentService.queryStuById(username);
            }else if(username.indexOf("c") != -1) {
                boo = companyService.queryComById(username);
            }else if(username.indexOf("a") != -1) {
                boo = adminService.queryAdminById(username);
            }else{
                resultAction.setResult(true);
                resultAction.setMsg1("用户名不合法 请重新注册");
                return resultAction;
            }
            if(boo) {
                resultAction.setResult(true);
                resultAction.setMsg1("用户名已注册 请重新注册用户名");
            }else {
                resultAction.setResult(false);
                resultAction.setMsg1("此用户名可注册");
            }
        } catch (MyException e) {
            e.printStackTrace();
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //Ajax校验原密码是否输入正确
     * @Date 12:37 2020/12/15 0015
     * @Param [submitData]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = "/checkOldPwdRight", method = RequestMethod.POST)
    @ResponseBody
    public ResultAction checkOldPwdRight(@RequestBody SubmitData submitData, HttpServletRequest request) {
        //获取客户端传过来的包装类数据oldPwd
        String oldPwd = submitData.getOldPwd();
        //封装返回结果给前端
        ResultAction resultAction = new ResultAction();
        Boolean boo = null;
        //获取session中的对象以此来判断当前登录的用户类别
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        Student student = (Student) request.getSession().getAttribute("student");
        Company company = (Company) request.getSession().getAttribute("company");
        //区分用户类别
        if(admin != null){
            //校验密码
            String adminPwd = admin.getAdminPwd();
            if(adminPwd.equals(oldPwd)){
                //校验成功
                boo = true;
            }else{
                //校验失败
                boo = false;
            }
        }else if(student != null){
            //校验密码
            String stuPwd = student.getStuPwd();
            if(stuPwd.equals(oldPwd)){
                //校验成功
                boo = true;
            }else{
                //校验失败
                boo = false;
            }
        }else if(company != null){
            //校验密码
            String comPwd = company.getComPwd();
            if(comPwd.equals(oldPwd)){
                //校验成功
                boo = true;
            }else{
                //校验失败
                boo = false;
            }
        }else{
            resultAction.setResult(false);
            resultAction.setMsg1("所查询的用户不存在");
            return resultAction;
        }
        //返回提示信息给前端
        if(boo) {
            resultAction.setResult(true);
            resultAction.setMsg1("原密码验证正确");
        }else {
            resultAction.setResult(false);
            resultAction.setMsg1("原密码验证错误 请重试");
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description // 账号管理 修改用户密码
     * @Date 13:06 2020/12/15 0015
     * @Param [data]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = "/managerAccount", method = RequestMethod.POST)
    @ResponseBody
    public ResultAction managerAccount(@RequestBody SubmitData submitData, HttpServletRequest request) {
        //封装返回结果给前端
        ResultAction resultAction = new ResultAction();
        Boolean boo = null;
        //获取客户端传过来的包装类数据newPwd confirmPwd
        LinkedHashMap<String,Object> entityData = submitData.getEntityData();
        //获取新密码和确认密码
        String newPwd = (String) entityData.get("newPwd");
        String confirmPwd = (String) entityData.get("confirmPwd");
        //校验新密码和确认密码是否一致
        if(newPwd.equals(confirmPwd)){
            //两次密码一致 调用service层方法 修改密码
            //获取session中的对象以此来判断当前登录的用户类别
            Admin admin = (Admin) request.getSession().getAttribute("admin");
            Student student = (Student) request.getSession().getAttribute("student");
            Company company = (Company) request.getSession().getAttribute("company");
            //区分用户类别
            if(admin != null){
                //调用adminService修改密码方法
                boo = adminService.updateAdminPwd(newPwd,admin.getAdminPwd());
            }else if(student != null){
                //调用studentService修改密码方法
                boo = studentService.updateStuPwd(newPwd,student.getStuPwd());
            }else if(company != null){
                //调用companyService修改密码方法
                boo = companyService.updateComPwd(newPwd,company.getComPwd());
            }else{
                resultAction.setResult(true);
                resultAction.setMsg1("所查询的用户不存在");
                return resultAction;
            }
            //返回提示信息给前端
            if(boo) {
                resultAction.setResult(true);
                resultAction.setMsg1("密码修改成功 请重新登录");
            }else {
                resultAction.setResult(false);
                resultAction.setMsg1("密码重置错误 请重试");
            }
        }else{
            //两次密码不一致
            resultAction.setResult(false);
            resultAction.setMsg1("两次密码输入不一致 请重试");
            return resultAction;
        }
        return resultAction;
    }

}
