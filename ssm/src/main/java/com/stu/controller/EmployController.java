package com.stu.controller;

import com.stu.bean.Advertise;
import com.stu.bean.Company;
import com.stu.bean.Employ;
import com.stu.bean.Student;
import com.stu.exception.MyException;
import com.stu.mapper.AdvertiseMapper;
import com.stu.mapper.CompanyMapper;
import com.stu.mapper.EmployMapper;
import com.stu.service.AdvertiseService;
import com.stu.service.EmployService;
import com.stu.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName EmployController
 * @Description 就业信息controller
 * @Author BX
 * @Date 2020/12/7 0022 15:20
 * @Version 1.0
 **/
@Controller(value = "employController")
@RequestMapping(value = "/employ")
public class EmployController {
    //spring自动注入interviewService对象
    @Autowired
    private EmployService employService;
    @Autowired
    private AdvertiseService advertiseService;
    //spring自动注入employMapper
    @Resource(name = "employMapper")
    private EmployMapper employMapper;
    //spring自动注入advertiseMapper
    @Resource(name = "advertiseMapper")
    private AdvertiseMapper advertiseMapper;
    //spring自动注入companyMapper
    @Resource(name = "companyMapper")
    private CompanyMapper companyMapper;

    /**
     * @Author BX
     * @Description //前端页面删除就业信息
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/delEmp"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction delEmp(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //封装返回值
        ResultAction resultAction = null;
        //获取前端传来的封装数据
        Employ employ = data.getEmploy();
        String empComName = employ.getEmpComName();
        Integer empNo = employ.getEmpNo();
        Integer empState = employ.getEmpState();
        Integer empStuNo = employ.getEmpStuNo();
        //校验是否已经确认就业 确认了就不可删除
        Employ employ1 = employService.queryEmpByStuNoState(empStuNo);
        if(StringEmpty.stringIsEmpty(employ1)) {
            //查询数据库 根据就业编号删除就业信息
            Boolean aBoolean = employService.delEmp(empNo);
            //保存数据 页面跳转
            resultAction = new ResultAction(aBoolean,"企业：" + empComName +"的就业信息删除成功");
            return resultAction;
        }else{
            //已经确认就业不可删除 保存提示数据返回 页面跳转
            resultAction = new ResultAction(false,"您已确认就业 不可删除就业信息");
            return resultAction;
        }
    }

    /**
     * @Author BX
     * @Description //就业信息 求职信息分页查询
     * @Date 16:13 2020/12/7 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryEmpByPage"})
    public ModelAndView queryEmpByPage(HttpServletRequest request) throws MyException {
        //获取前端数据
        String stuNoStr = request.getParameter("stuNo");
        int stuNoInt = Integer.valueOf(stuNoStr);
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Employ> employPageModel = null;
        try {
            employPageModel = employService.queryEmpByPage(stuNoInt,pageNo,pageSize);
        } catch (MyException | ParseException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("employPageModel",employPageModel);
        //跳转到employ_stu.jsp
        modelAndView.setViewName("student/employ_stu");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据三个条件动态查询就业信息
     * @Date 15:10 2020/12/7 0021
     * @Param [Employ]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryEmpByThreeCon"}, method = RequestMethod.POST)
    public ModelAndView queryEmpByThreeCon(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //接收查询页面传送过来的表单数据
        Employ employ = data.getEmploy();
        //获取三个条件
        String empComName = employ.getEmpComName();
        //获取学号
        String stuNoStr = request.getParameter("stuNo");
        int empStuNo = Integer.valueOf(stuNoStr);
        String empPosition = employ.getEmpPosition();
        String empSalary = request.getParameter("empSalary");
        //条件过滤
        int startSalary = 0;
        int endSalary = 0;
        //转换
        switch (empSalary) {
            case "小于3000":
                startSalary = 0;
                endSalary = 3000;
                break;
            case "3000-5000":
                startSalary = 3001;
                endSalary = 5000;
                break;
            case "5000-7000":
                startSalary = 5001;
                endSalary = 7000;
                break;
            case "7000-10000":
                startSalary = 7001;
                endSalary = 10000;
                break;
            case "大于10000":
                startSalary = 10001;
                endSalary = 999999999;
                break;
            default:
                break;
        }
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Employ> employPageModel = null;
        try {
            employPageModel = employService.queryEmpByThreeCon(empStuNo,empComName,empPosition,startSalary,endSalary,pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("employPageModel",employPageModel);
        //跳转到employ_stu.jsp
        modelAndView.setViewName("student/employ_stu");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //确认就业 将状态码由0改为1 标识确认就业
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/comfirmEmp"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction comfirmEmp(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的对象
        Employ employ = data.getEmploy();
        String empComName = employ.getEmpComName();
        Integer empNo = employ.getEmpNo();
        Integer empState = employ.getEmpState();
        Integer empComNo = employ.getEmpComNo();
        //校验是否重复操作 通过学号和状态码1来判断是否已经确认过
        Student student = (Student) request.getSession().getAttribute("student");
        int empStuNo = student.getStuNo();
        //查询数据库校验
        Employ employ1 = employService.queryEmpByStuNoState(empStuNo);
        if(StringEmpty.stringIsEmpty(employ1)) {
            //未确认 将状态码由0改为1
            Boolean aBoolean = employService.comfirmEmp(empNo);
            //校验
            if(aBoolean){
                //根据企业编号查询招聘信息
                Advertise advertise = advertiseService.queryAdverByComNo(empComNo).get(0);
                //确认就业后 该企业的招聘人数减1
                Long oldAdverCount = advertise.getAdverCount();
                oldAdverCount--;
                //修改招聘人数
                advertiseService.updateAdverCount(empComNo,oldAdverCount);
                //封装
                advertise.setAdverCount(oldAdverCount);
                //确认就业 保存提示数据返回 页面跳转
                resultAction = new ResultAction(aBoolean,"恭喜你就业成功！ 欢迎加入" + "<span style='font-weight:bold;color:#f37b1d;'>" + empComName + "</span>");
                return resultAction;
            }else{
                //操作失败 保存提示数据返回 页面跳转
                resultAction = new ResultAction(aBoolean,"服务器异常 请重试");
                return resultAction;
            }
        }else{
            //已经确认就业 保存提示数据返回 页面跳转
            resultAction = new ResultAction(false,"您已确认就业 不可重复操作");
            return resultAction;
        }
    }

    /**
     * @Author BX
     * @Description //就业分析
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return ModelAndView
     **/
    @RequestMapping(value = {"/salaryAnalyse"}, method = RequestMethod.POST)
    @ResponseBody
    public EmployAnalyse salaryAnalyse(HttpServletRequest request) throws MyException {
        //封装JSON数据返回到前端图表
        EmployAnalyse employAnalyse = new EmployAnalyse();
        //构建返回的数据项，实际开发中应该从数据库中读出
        List<Integer> counts = new ArrayList<Integer>();
        //获取数据库中的数据
        Integer count1 = employMapper.queryEmpSalaryCount1();
        Integer count2 = employMapper.queryEmpSalaryCount2();
        Integer count3 = employMapper.queryEmpSalaryCount3();
        Integer count4 = employMapper.queryEmpSalaryCount4();
        Integer count5 = employMapper.queryEmpSalaryCount5();
        //进行封装
        counts.add(count1);
        counts.add(count2);
        counts.add(count3);
        counts.add(count4);
        counts.add(count5);
        //封装JSON
        employAnalyse.setCount(counts);
        //返回到前端图表
        return employAnalyse;
    }

    /**
     * @Author BX
     * @Description //就业分析
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return ModelAndView
     **/
    @RequestMapping(value = {"/locationAnalyse"}, method = RequestMethod.POST)
    @ResponseBody
    public EmployAnalyse locationAnalyse(HttpServletRequest request) throws MyException {
        //数据条数
        int count1 = 0;
        int count2 = 0;
        int count3 = 0;
        int count4 = 0;
        int count5 = 0;
        int count6 = 0;
        int count7 = 0;
        int count8 = 0;
        //封装JSON数据返回到前端图表
        EmployAnalyse employAnalyse = new EmployAnalyse();
        //构建返回的数据项，实际开发中应该从数据库中读出
        List<Integer> counts = new ArrayList<Integer>();
        //获取数据库中的数据 查询所有已经确认就业的就业信息
        List<Employ> list = employMapper.queryAllEmp();
        //校验
        for(int i=0;i<list.size();i++) {
            //获取每个企业的编号
            Employ employ = list.get(i);
            Integer comNo = employ.getEmpComNo();
            //查询企业工作地
            List<Advertise> advertiseList = advertiseMapper.queryAdverByComNo(comNo);
            if(advertiseList.size() > 0) {
                Advertise advertise = advertiseList.get(0);
                String comLocation = advertise.getAdverLocation();
                //判断
                if(comLocation.contains("北京")) {
                    count1++;
                }else if(comLocation.contains("上海")) {
                    count2++;
                }else if(comLocation.contains("南京")) {
                    count3++;
                }else if(comLocation.contains("成都")) {
                    count4++;
                }else if(comLocation.contains("武汉")) {
                    count5++;
                }else if(comLocation.contains("广州")) {
                    count6++;
                }else if(comLocation.contains("西安")) {
                    count7++;
                }else if(comLocation.contains("南昌")) {
                    count8++;
                }
            }
        }
        //进行封装
        counts.add(count1);
        counts.add(count2);
        counts.add(count3);
        counts.add(count4);
        counts.add(count5);
        counts.add(count6);
        counts.add(count7);
        counts.add(count8);
        //封装JSON
        employAnalyse.setCount(counts);
        //返回到前端图表
        return employAnalyse;
    }

    /**
     * @Author BX
     * @Description //就业分析
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return ModelAndView
     **/
    @RequestMapping(value = {"/kindAnalyse"}, method = RequestMethod.POST)
    @ResponseBody
    public EmployAnalyse kindAnalyse(HttpServletRequest request) throws MyException {
        //数据条数
        int count1 = 0;
        int count2 = 0;
        int count3 = 0;
        int count4 = 0;
        int count5 = 0;
        int count6 = 0;
        //封装JSON数据返回到前端图表
        EmployAnalyse employAnalyse = new EmployAnalyse();
        //构建返回的数据项，实际开发中应该从数据库中读出
        List<List<Object>> number = new ArrayList<List<Object>>();
        //获取数据库中的数据 查询所有已经确认就业的就业信息
        List<Employ> list = employMapper.queryAllEmp();
        //校验
        for(int i=0;i<list.size();i++) {
            //获取每个企业的编号
            Employ employ = list.get(i);
            Integer comNo = employ.getEmpComNo();
            //查询企业性质
            Company company = companyMapper.queryComByNo(comNo);
            String comKind = company.getComKind();
            //判断
            if(comKind.equals("自营")) {
                count1++;
            }else if(comKind.equals("私企")) {
                count2++;
            }else if(comKind.equals("国企")) {
                count3++;
            }else if(comKind.equals("合资")) {
                count4++;
            }else if(comKind.equals("外资")) {
                count5++;
            }else if(comKind.equals("事业单位")) {
                count6++;
            }
        }
        List<Object> resultAction1 = new ArrayList<Object>();
        resultAction1.add("自营");
        resultAction1.add(count1);
        List<Object> resultAction2 = new ArrayList<Object>();
        resultAction2.add("私企");
        resultAction2.add(count2);
        List<Object> resultAction3 = new ArrayList<Object>();
        resultAction3.add("国企");
        resultAction3.add(count3);
        List<Object> resultAction4 = new ArrayList<Object>();
        resultAction4.add("合资");
        resultAction4.add(count4);
        List<Object> resultAction5 = new ArrayList<Object>();
        resultAction5.add("外资");
        resultAction5.add(count5);
        List<Object> resultAction6 = new ArrayList<Object>();
        resultAction6.add("事业单位");
        resultAction6.add(count6);
        //进行封装
        number.add(resultAction1);
        number.add(resultAction2);
        number.add(resultAction3);
        number.add(resultAction4);
        number.add(resultAction5);
        number.add(resultAction6);
        //封装JSON
        employAnalyse.setNumber(number);
        //返回到前端图表
        return employAnalyse;
    }

}
