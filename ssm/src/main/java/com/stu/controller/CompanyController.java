package com.stu.controller;

import com.stu.bean.Advertise;
import com.stu.bean.Company;
import com.stu.bean.Employ;
import com.stu.exception.MyException;
import com.stu.service.AdvertiseService;
import com.stu.service.CompanyService;
import com.stu.service.EmployService;
import com.stu.util.PageModel;
import com.stu.util.ResultAction;
import com.stu.util.SubmitData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;

/**
 * @ClassName CompanyController
 * @Description 企业Controller
 * @Author BX
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/
@Controller(value = "companyController")
@RequestMapping(value = "/company")
public class CompanyController {

    //spring自动注入companyService对象
    @Autowired
    private CompanyService companyService;
    @Autowired
    private AdvertiseService advertiseService;
    @Autowired
    private EmployService employService;

    /**
     * @Author BX
     * @Description //登录校验用户名、密码
     * @Date 23:05 2020/12/7 0008
     * @Param [comId, comPwd, request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/doLogin"})
    public @ResponseBody ResultAction doLogin(@ModelAttribute("username")String comId, @ModelAttribute("password")String comPwd, HttpServletRequest request) throws MyException {
        //获取传送过来的数据
        //调用Service层方法
        Company company = companyService.doLogin(comId,comPwd);
        //封装返回结果
        ResultAction result = null;
        if(company == null){
            //用户名或密码错误
            result = new ResultAction(false,"用户名、密码或用户选择有误 请重新登录");
        }else if(company.getComPower().equals("-1")){
            // 账号已注销
            result = new ResultAction(false,"账号已注销 请重新注册");
        }else{
            //将用户保存到session中
            request.getSession().setAttribute("company",company);
            System.out.println(company.getComName() + "------>>企业登录成功<<-------");
            //登录成功
            result = new ResultAction(true,"登录成功","../company/main_com.jsp");
        }
        return result;
    }

    /**
     * @Author BX
     * @Description //企业注册
     * @Date 14:20 2020/12/7 0010
     * @Param [data]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/comRegist"})
    @ResponseBody
    public ResultAction comRegist(@RequestBody SubmitData data) {
        //接收注册页面传送过来的表单数据
        Company company = data.getCompany();
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = companyService.comRegist(company);
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
     * @Description //企业信息管理模块 企业信息分页查询
     * @Date 16:13 2020/12/7 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryComByPage"})
    public ModelAndView queryComByPage(HttpServletRequest request) throws MyException {
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Company> companyPageModel = null;
        List<Company> comTypeKindList = null;
        try {
            companyPageModel = companyService.queryComByPage(pageNo,pageSize);
            //查询所有企业类型 在企业查询下拉框中用到
            comTypeKindList =  companyService.queryComTypeAndKind();
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //去重
        HashSet<String> comTypeSet = new HashSet<String>();
        HashSet<String> comKindSet = new HashSet<String>();
        for(int i=0;i<comTypeKindList.size();i++){
            Company company = comTypeKindList.get(i);
            String comType = company.getComType();
            String comKind = company.getComKind();
            //存储企业类型
            comTypeSet.add(comType);
            //存储企业性质
            comKindSet.add(comKind);
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("companyPageModel",companyPageModel);
        //查询所有企业类型 在企业查询下拉框中用到
        modelAndView.addObject("comTypeSet",comTypeSet);
        //查询所有企业性质 在企业查询下拉框中用到
        modelAndView.addObject("comKindSet",comKindSet);
        //跳转到com_admin.jsp
        modelAndView.setViewName("admin/com_admin");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据五个条件动态查询企业信息
     * @Date 15:10 2020/12/7 0021
     * @Param [student]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryComByFiveCon"}, method = RequestMethod.POST)
    public ModelAndView queryComByFiveCon(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //接收注册页面传送过来的表单数据
        Company company = data.getCompany();
        int comNo = company.getComNo();
        String comNoStr = String.valueOf(comNo);
        //排除输入为空的值
        if(comNoStr.equals("0")){
            comNoStr = "";
        }
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Company> companyPageModel = null;
        try {
            companyPageModel = companyService.queryComByFiveCon(comNoStr,company.getComName(),company.getComAddress(),company.getComType(),company.getComKind(),pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("companyPageModel",companyPageModel);
        //跳转到com_admin_query.jsp
        modelAndView.setViewName("admin/com_admin_query");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //企业信息管理模块 企业信息分页查询 数据回显
     * @Date 16:13 2020/12/7 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryComByPageNew"})
    public ModelAndView queryComByPageNew(HttpServletRequest request) throws MyException {
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Company> companyPageModel = null;
        try {
            companyPageModel = companyService.queryComByPage(pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("companyPageModel",companyPageModel);
        //跳转到com_admin_query.jsp
        modelAndView.setViewName("admin/com_admin_query");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据企业编号查询企业信息 用于显示企业详细信息 前端表格展示
     * @Date 11:33 2020/12/7 0005
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryComInfo"})
    @ResponseBody
    public ResultAction queryComInfo(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号
        String comNo = request.getParameter("comNo");
        //类型转换
        int comNo2 = Integer.valueOf(comNo).intValue();
        //查询数据库 根据企业编号查询学生信息 queryComByNo
        Company company = companyService.queryComInfo(comNo2);
        //保存数据 页面跳转
        if(company == null){
            //企业数据不存在
            resultAction = new ResultAction(false,"该企业信息不存在");
        }else{
            //查询成功
            resultAction = new ResultAction(true,company);
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //前端页面删除企业数据
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/delCom"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction delCom(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号
        String comNo = request.getParameter("comNo");
        //类型转换
        int comNo2 = Integer.valueOf(comNo).intValue();
        //删除前先校验此账号下是否有数据
        List<Advertise> adverList = advertiseService.queryAdverByComNo(comNo2);
        List<Employ> empList = employService.queryEmpByComNo(comNo2);
        if(adverList.size() > 0 || empList.size() > 0) {
            //保存数据 页面跳转
            resultAction = new ResultAction(false,comNo);
            return resultAction;
        }else{
            //查询数据库 根据企业编号删除企业信息 queryComByNo
            Boolean aBoolean = companyService.delCom(comNo2);
            //保存数据 页面跳转
            resultAction = new ResultAction(aBoolean,comNo);
            return resultAction;
        }
    }

    /**
     * @Author BX
     * @Description //企业中心 回显当前登录的企业信息 并在页面中进行企业信息修改
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/comCenter"})
    public ModelAndView comCenter(HttpServletRequest request) throws MyException {
        ModelAndView modelAndView = new ModelAndView("company/center_com");
        //获取客户端的企业编号
        String comNoStr = request.getParameter("comNo");
        //类型转换
        int comNo = Integer.valueOf(comNoStr).intValue();
        //调用Service层方法 根据管理员编号查询管理员信息
        Company company = companyService.queryComByNoCenter(comNo);
        //将查询结果保存在modelAndView中
        modelAndView.addObject("comInfo",company);
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //企业个人中心 回显当前登录的企业信息 并在页面中进行企业信息修改
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/updateCom"})
    @ResponseBody
    public ResultAction updateCom(@RequestBody SubmitData data) throws MyException {
        //接收注册页面传送过来的表单数据
        Company company = data.getCompany();
        //封装参数
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = companyService.updateCom(company.getComNo(),company.getComId(),company.getComName(),company.getComPhone(),company.getComAddress(),company.getComKind(),company.getComNum(),company.getComType(),company.getComBack());
            //判断是否修改成功
            if(flag){
                //修改成功
                resultAction = new ResultAction(true,"企业信息修改成功 请更新您的招聘信息");
            }else {
                //修改失败 抛出异常
                resultAction = new ResultAction(false,"企业信息修改失败");
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
     * @Date 10:40 2020/12/7 0019
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/logOutCom"})
    @ResponseBody
    public ResultAction logOutCom(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号
        String comNo = request.getParameter("comNo");
        //类型转换
        int comNo2 = Integer.valueOf(comNo).intValue();
        //查询数据库 根据编号修改企业权限为-1 logOutCom
        Boolean aBoolean = companyService.logOutCom(comNo2);
        //保存数据 页面跳转
        if(aBoolean){
            //修改成功
            resultAction = new ResultAction(aBoolean,"企业账号:" + comNo2 + "注销成功");
        }else{
            //修改失败
            resultAction = new ResultAction(aBoolean,"企业账号:" + comNo2 + "注销失败");
        }
        return resultAction;
    }

}
