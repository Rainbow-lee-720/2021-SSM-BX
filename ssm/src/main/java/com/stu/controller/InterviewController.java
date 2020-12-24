package com.stu.controller;

import com.stu.bean.Company;
import com.stu.bean.Employ;
import com.stu.bean.Interview;
import com.stu.bean.Student;
import com.stu.exception.MyException;
import com.stu.service.InterviewService;
import com.stu.service.StudentService;
import com.stu.util.PageModel;
import com.stu.util.ResultAction;
import com.stu.util.StringEmpty;
import com.stu.util.SubmitData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @ClassName InterviewController
 * @Description 求职信息controller
 * @Author BX
 * @Date 2020/12/7 0022 15:20
 * @Version 1.0
 **/
@Controller(value = "interviewController")
@RequestMapping(value = "/interview")
public class InterviewController {
    //spring自动注入interviewService对象
    @Autowired
    private InterviewService interviewService;
    //spring自动注入studentService对象
    @Autowired
    private StudentService studentService;

    /**
     * @Author Lee
     * @Description //添加求职信息
     * @Date 17:34 2020/2/22 0022
     * @Param [data]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/addInterview"})
    @ResponseBody
    public ResultAction addInterview(@RequestBody SubmitData data) {
        //接收注册页面传送过来的表单数据
        Interview interview = data.getInterview();
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = interviewService.addInterview(interview);
            //判断此求职信息是否添加成功
            if(flag){
                //添加成功
                resultAction = new ResultAction(true,"求职信息添加成功!","main_stu.jsp");
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
     * @Description //求职信息 回显当前登录的学生求职信息 并在页面中进行求职信息修改
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryInterByStuNo"})
    public ModelAndView queryInterByStuNo(HttpServletRequest request) throws MyException {
        ModelAndView modelAndView = new ModelAndView("student/interview_stu");
        //获取客户端的学号
        String stuNoStr = request.getParameter("interStuNo");
        //类型转换
        int stuNo = Integer.valueOf(stuNoStr).intValue();
        //调用Service层方法 根据学号查询求职信息
        List<Interview> list = interviewService.queryInterByStuNo(stuNo);
        if(list.size() > 0){
            Interview interview = list.get(0);
            //将查询结果保存在modelAndView中
            modelAndView.addObject("interInfo",interview);

            //将查询结果保存在modelAndView中
            Student student = studentService.queryStuByNoCenter(stuNo);
            modelAndView.addObject("stuInfo",student);

            return modelAndView;
        }else{
            //将查询结果保存在modelAndView中
            modelAndView.addObject("interInfo",null);
            return modelAndView;
        }
    }

    /**
     * @Author BX
     * @Description //修改求职信息
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/updateInterview"})
    @ResponseBody
    public ResultAction updateInterview(@RequestBody SubmitData data) throws MyException {
        //接收注册页面传送过来的表单数据
        Interview interview = data.getInterview();
        //封装参数
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = interviewService.updateInterview(interview.getInterStuNo(),interview.getInterName(),interview.getInterSex(),interview.getInterAge(),interview.getInterSpecialty(),interview.getInterSchool(),interview.getInterDegree(),interview.getInterPhone(),interview.getInterPosition(),interview.getInterSalary(),interview.getInterLocation());
            //判断是否修改成功
            if(flag){
                //修改成功
                resultAction = new ResultAction(true,"求职信息更新成功");
            }else {
                //修改失败 抛出异常
                resultAction = new ResultAction(false,"求职信息更新失败");
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
     * @Description //前端页面删除求职信息
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/delInter"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction delInter(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的学号
        String stuNo = request.getParameter("interStuNo");
        //类型转换
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        //查询数据库 根据学号删除求职信息
        Boolean aBoolean = interviewService.delInter(stuNo2);
        //保存数据 页面跳转
        resultAction = new ResultAction(aBoolean,stuNo);
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //求职审核信息（学生求职信息） 求职信息分页查询
     * @Date 16:13 2020/12/7 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryInterByPage"})
    public ModelAndView queryInterByPage(HttpServletRequest request) throws MyException {
        //获取前端的企业编号interComNo
        String comNo = request.getParameter("interComNo");
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Interview> interviewPageModel = null;
        try {
            interviewPageModel = interviewService.queryInterByPage(comNo,pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("interviewPageModel",interviewPageModel);
        //跳转到adver_stu.jsp
        modelAndView.setViewName("company/interview_com");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据四个条件动态查询求职信息
     * @Date 15:10 2020/12/7 0021
     * @Param [interview]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryInterByFourCon"}, method = RequestMethod.POST)
    public ModelAndView queryInterByFourCon(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //接收查询页面传送过来的表单数据
        Company company = (Company) request.getSession().getAttribute("company");
        int comNoInt = company.getComNo();
        String comNo = String.valueOf(comNoInt);
        Interview interview = data.getInterview();
        //获取四个条件
        String interSex = interview.getInterSex();
        String interDegree = interview.getInterDegree();
        String interLocation = interview.getInterLocation();

        String interSalary = request.getParameter("interSalary");
        //条件过滤
        int startSalary = 0;
        int endSalary = 0;
        //转换
        switch (interSalary) {
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
        PageModel<Interview> interviewPageModel = null;
        try {
            interviewPageModel = interviewService.queryInterByFourCon(comNo,interSex,interDegree,interLocation,startSalary,endSalary,pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("interviewPageModel",interviewPageModel);
        //跳转到inter_com_query.jsp
        modelAndView.setViewName("company/inter_com_query");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据学号、企业编号查询学生求职信息 用于显示学生求职详细信息 前端模态框展示
     * @Date 11:33 2020/12/7 0005
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryInterInfo"})
    @ResponseBody
    public ResultAction queryInterInfo(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号、学生编号
        String stuNo = request.getParameter("stuNo");
        String comNo = request.getParameter("comNo");
        //类型转换
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        int comNo2 = Integer.valueOf(comNo).intValue();
        //查询数据库 根据企业编号查询学生信息 queryComByNo
        Interview interview = interviewService.queryInterInfo(stuNo2,comNo2);
        //保存数据 页面跳转
        if(interview == null){
            //求职数据不存在
            resultAction = new ResultAction(false,"学生求职信息不存在");
        }else{
            //查询成功
            resultAction = new ResultAction(true,interview);
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //审核通过 后台先判断此学生求职申请是否已经审核通过（查询就业信息中是否有次学生和对应的企业） 后台自动生成学生就业信息 并把interview表中的InterComNo字段对应的审核通过的企业编号去除
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/giveJob"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction giveJob(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业名称、对象
        Interview interview = data.getInterview();
        String comNoStr = request.getParameter("comNo");
        //获取封装的数据
        int interStuNo = interview.getInterStuNo();
        //类型转换
        int comNo = Integer.valueOf(comNoStr);
        String interStuName = interview.getInterName();
        String interSex = interview.getInterSex();
        long interAge = interview.getInterAge();
        String interPhone = interview.getInterPhone();
        String interDegree = interview.getInterDegree();
        String interSchool = interview.getInterSchool();
        String interSpecialty = interview.getInterSpecialty();
        String comName = request.getParameter("comName");
        String interPosition = interview.getInterPosition();
        long interSalary = interview.getInterSalary();
        String interLocation = interview.getInterLocation();
        //自动生成就业信息前先将求学生对应的求职表中的企业编号去除
        String interComNo = interview.getInterComNo();
        //标识
        String giveJob = comNoStr + "g";
        String replaceStr = interComNo.replace(comNoStr,giveJob);
        //校验是否已经操作过
        if(interComNo.contains(giveJob)){
            //已经对求职信息审核过 保存提示数据返回 页面跳转
            resultAction = new ResultAction(false,"求职申请已审核通过 不可重复操作");
            return resultAction;
        }else{
            //调用mapper方法 将替换后的字q符串修改进interview表中 达到审核通过的效果
            Boolean aBoolean = interviewService.findJob(interStuNo,replaceStr);
            if(aBoolean){
                //将求职成功的学生数据封装进就业信息对象
                Employ employ = new Employ();
                employ.setEmpStuNo(interStuNo);
                employ.setEmpComNo(comNo);
                employ.setEmpName(interStuName);
                employ.setEmpSex(interSex);
                employ.setEmpAge(interAge);
                employ.setEmpStuPhone(interPhone);
                employ.setEmpDegree(interDegree);
                employ.setEmpSchool(interSchool);
                employ.setEmpSpecialty(interSpecialty);
                employ.setEmpComName(comName);
                employ.setEmpPosition(interPosition);
                employ.setEmpSalary(interSalary);
                employ.setEmpLocation(interLocation);
                //调用Service方法 自增长主键、日期自动插入
                Boolean aBoolean1 = interviewService.addEmploy(employ);
                if(aBoolean1){
                    //审核求职信息成功、自动生成学生就业信息 保存提示数据返回 页面跳转
                    resultAction = new ResultAction(aBoolean1,"学生求职申请审核通过 学生就业信息已实时发布");
                    return resultAction;
                }else{
                    //审核求职信息失败 保存提示数据返回 页面跳转
                    resultAction = new ResultAction(aBoolean1,"服务器异常 请重试");
                    return resultAction;
                }
            }else{
                //清除求职信息中的企业信息失败 保存提示数据返回 页面跳转
                resultAction = new ResultAction(aBoolean,"服务器异常 请重试");
                return resultAction;
            }
        }
    }

    /**
     * @Author BX
     * @Description //审核不通过 通过在interiew表中的interComNo字段去除（与学生撤回求职申请一样实现） 表示该学生的求职申请审核不通过
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/refuseJob"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction refuseJob(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号、学号
        String comNo = request.getParameter("comNo");
        String interComNo = request.getParameter("interComNo");
        String interStuNo = request.getParameter("interStuNo");
        //类型转换
        int stuNo = Integer.valueOf(interStuNo).intValue();
        //审核不通过 做撤回申请操作
        String replaceStr = interComNo.replace(comNo,"");
        if(StringEmpty.stringIsEmpty(replaceStr)){
            //替换撤回所有企业的求职申请时的空字符串 因为要传int型参数
            replaceStr = "r";
        }
        //调用mapper方法 将替换后的字符串修改进interview表中 达到撤回申请的效果
        Boolean aBoolean = interviewService.findJob(stuNo,replaceStr);
        if(aBoolean){
            //学生求职审核不通过 保存提示数据返回 页面跳转
            resultAction = new ResultAction(aBoolean,"求职审核不通过操作成功");
            return resultAction;
        }else{
            //学生求职审核不通过操作失败 保存提示数据返回 页面跳转
            resultAction = new ResultAction(aBoolean,"服务器异常 请重试");
            return resultAction;
        }
    }

}
