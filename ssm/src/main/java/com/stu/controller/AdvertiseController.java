package com.stu.controller;

import com.stu.bean.*;
import com.stu.exception.MyException;
import com.stu.mapper.StudentMapper;
import com.stu.service.AdvertiseService;
import com.stu.service.CompanyService;
import com.stu.service.InterviewService;
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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @ClassName AdvertiseController
 * @Description 招聘信息controller
 * @Author BX
 * @Date 2020/12/7 0022 15:20
 * @Version 1.0
 **/
@Controller(value = "advertiseController")
@RequestMapping(value = "/advertise")
public class AdvertiseController {
    //spring自动注入interviewService对象
    @Autowired
    private AdvertiseService advertiseService;
    //spring自动注入companyService对象
    @Autowired
    private CompanyService companyService;
    @Autowired
    private InterviewService interviewService;
    //spring自动注入studentMapper
    @Resource(name = "studentMapper")
    private StudentMapper studentMapper;


    /**
     * @Author BX
     * @Description //添加招聘信息
     * @Date 17:34 2020/12/7 0022
     * @Param [data]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/addAdvertise"})
    @ResponseBody
    public ResultAction addAdvertise(@RequestBody SubmitData data) {
        //接收注册页面传送过来的表单数据
        Advertise advertise = data.getAdvertise();
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = advertiseService.addAdvertise(advertise);
            //判断此求职信息是否添加成功
            if(flag){
                //添加成功
                resultAction = new ResultAction(true,"企业招聘信息发布成功","main_com.jsp");
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
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryAdverByComNo"})
    public ModelAndView queryAdverByComNo(HttpServletRequest request) throws MyException {
        ModelAndView modelAndView = new ModelAndView("advertise_update_com");
        //获取客户端的企业编号
        String comNoStr = request.getParameter("adverComNo");
        //类型转换
        int comNo = Integer.valueOf(comNoStr).intValue();
        //调用Service层方法 根据学号查询求职信息
        List<Advertise> list = advertiseService.queryAdverByComNo(comNo);
        if(list.size() > 0){
            Advertise advertise = list.get(0);
            //将查询结果保存在modelAndView中
            modelAndView.addObject("adverInfo",advertise);
            //将查询结果保存在modelAndView中
            Company company = companyService.queryComByNoCenter(comNo);
            modelAndView.addObject("comInfo",company);
            return modelAndView;
        }else{
            //将查询结果保存在modelAndView中
            modelAndView.addObject("adverInfo",null);
            return modelAndView;
        }
    }

    /**
     * @Author BX
     * @Description //企业模块-招聘信息分页展示（需求修改）
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryAdverByPageNew"})
    public ModelAndView queryAdverByPageNew(HttpServletRequest request) throws MyException {
        //获取客户端的企业编号
        String comNoStr = request.getParameter("adverComNo");
        //类型转换
        int adverComNo = Integer.valueOf(comNoStr).intValue();
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Advertise> advertisePageModel = null;
        try {
            advertisePageModel = advertiseService.queryAdverByPageNew(adverComNo,pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("advertisePageModel",advertisePageModel);
        //跳转到advertise_com_new.jsp
        modelAndView.setViewName("company/advertise_com_new");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //企业根据三个条件动态查询招聘信息
     * @Date 15:10 2020/12/7 0021
     * @Param [Employ]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryAdverByThreeConNew"}, method = RequestMethod.POST)
    public ModelAndView queryAdverByThreeConNew(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //接收查询页面传送过来的表单数据
        Advertise advertise = data.getAdvertise();
        //获取三个条件
        String adverPosition = advertise.getAdverPosition();
        //获取企业编号
        String adverComNo = request.getParameter("adverComNo");
        int comNo = Integer.valueOf(adverComNo);
        String adverLocation = advertise.getAdverLocation();
        String adverSalary = request.getParameter("adverSalary");
        //条件过滤
        int startSalary = 0;
        int endSalary = 0;
        //转换
        switch (adverSalary) {
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
        PageModel<Advertise> advertisePageModel = null;
        try {
            advertisePageModel = advertiseService.queryAdverByThreeConNew(comNo,adverPosition,adverLocation,startSalary,endSalary,pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("advertisePageModel",advertisePageModel);
        //跳转到advertise_com_new_query.jsp
        modelAndView.setViewName("company/advertise_com_new");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //修改招聘信息前先回显当前招聘信息数据
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/updateAdverBefore"})
    @ResponseBody
    public ModelAndView updateAdverBefore(HttpServletRequest request) throws MyException {
        ModelAndView modelAndView = new ModelAndView("company/advertise_update_com");
        //获取前端传来的招聘信息编号
        String adverNo = request.getParameter("adverNo");
        //类型转换
        int adverNo2 = Integer.valueOf(adverNo).intValue();
        ResultAction resultAction = null;
        Advertise advertise = advertiseService.updateAdverBefore(adverNo2);
        //将查询结果保存在modelAndView中
        modelAndView.addObject("adverInfo",advertise);
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //修改招聘信息
     * @Date 13:09 2020/12/7 0011
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/updateAdvertise"})
    @ResponseBody
    public ResultAction updateAdvertise(@RequestBody SubmitData data) throws MyException {
        //接收注册页面传送过来的表单数据
        Advertise advertise = data.getAdvertise();
        //封装参数
        Boolean flag = null;
        ResultAction resultAction = null;
        try {
            flag = advertiseService.updateAdvertise(advertise.getAdverNo(),advertise.getAdverComName(),advertise.getAdverComPhone(),advertise.getAdverComAddress(),advertise.getAdverPosition(),advertise.getAdverCount(),advertise.getAdverSalary(),advertise.getAdverLocation(),advertise.getAdverRequire());
            //判断是否修改成功
            if(flag){
                //修改成功
                resultAction = new ResultAction(true,"招聘信息更新成功");
            }else {
                //修改失败 抛出异常
                resultAction = new ResultAction(false,"招聘信息更新失败");
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
     * @Description //前端页面删除招聘信息
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/delAdver"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction delAdver(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的招聘信息编号
        String adverNo = request.getParameter("adverNo");
        //类型转换
        int adverNo2 = Integer.valueOf(adverNo).intValue();
        //查询数据库 根据企业编号删除招聘信息
        Boolean aBoolean = advertiseService.delAdver(adverNo2);
        //保存数据 页面跳转
        resultAction = new ResultAction(aBoolean,adverNo);
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //企业招聘信息 招聘信息分页查询
     * @Date 16:13 2020/12/7 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryAdverByPage"})
    public ModelAndView queryAdverByPage(HttpServletRequest request) throws MyException {
        //每页显示的数据条数
        int pageSize = 10;
        //获取客户端的页数
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = PageModel.getPageNoFromIE(pageNoStr);
        //调用service层方法
        PageModel<Advertise> advertisePageModel = null;
        try {
            advertisePageModel = advertiseService.queryAdverByPage(pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("advertisePageModel",advertisePageModel);
        //跳转到adver_stu.jsp
        modelAndView.setViewName("student/adver_stu");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据三个条件动态查询企业招聘信息
     * @Date 15:10 2020/12/7 0021
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryAdverByThreeCon"}, method = RequestMethod.POST)
    public ModelAndView queryAdverByThreeCon(@RequestBody SubmitData data, HttpServletRequest request) throws MyException {
        //接收注册页面传送过来的表单数据
        Advertise advertise = data.getAdvertise();
        int comNo = advertise.getAdverComNo();
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
        PageModel<Advertise> advertisePageModel = null;
        try {
            advertisePageModel = advertiseService.queryAdverByThreeCon(comNoStr,advertise.getAdverComName(),advertise.getAdverLocation(),pageNo,pageSize);
        } catch (MyException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }
        //将pageModel对象存储在modelAndView中
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("advertisePageModel",advertisePageModel);
        //跳转到adver_stu_query.jsp
        modelAndView.setViewName("student/adver_stu_query");
        return modelAndView;
    }

    /**
     * @Author BX
     * @Description //根据企业编号查询招聘信息 用于显示企业招聘详细信息 前端表格展示
     * @Date 11:33 2020/12/7 0005
     * @Param [request]
     * @return org.springframework.web.servlet.ModelAndView
     **/
    @RequestMapping(value = {"/queryAdverInfo"})
    @ResponseBody
    public ResultAction queryAdverInfo(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号
        String comNo = request.getParameter("adverComNo");
        //类型转换
        int comNo2 = Integer.valueOf(comNo).intValue();
        //查询数据库 根据企业编号查询学生信息 queryComByNo
        List<Advertise> list = advertiseService.queryAdverInfo(comNo2);
        Advertise advertise = null;
        if(list.size() > 0) {
            advertise = list.get(0);
            //保存数据 页面跳转
            if(advertise == null){
                //企业数据不存在
                resultAction = new ResultAction(false,"招聘信息不存在");
            }else{
                //查询成功
                resultAction = new ResultAction(true,advertise);
            }
            return resultAction;
        }
        return resultAction;
    }

    /**
     * @Author BX
     * @Description //学生求职 将comNo修改到求职信息表中的interComNo
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/findJob"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction findJob(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号、学号
        String comNo = request.getParameter("adverComNo");
        String stuNo = request.getParameter("stuNo");
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        //先校验学生是否填写了求职信息
        List<Interview> list = interviewService.queryInterByStuNo(stuNo2);
        if(list.size() > 0){
            //学生已填写求职信息 可以进行求职申请
            //查询数据库模糊查询interview表中的interComNo来查询interview对象 为null说明未申请过 不为null则提示前端已经申请过 不可申请 根判断求职的此企业是否已经被申请过
            Interview interview = interviewService.queryInterByStuNoComNo(stuNo2,comNo);
            if(interview != null){
                //已经申请求职此公司
                //申请求职失败 保存提示数据返回 页面跳转
                resultAction = new ResultAction(false,"您已对此企业提交求职申请 不可重复操作");
                return resultAction;
            }else{
                //查询已有的interComNo
                List<Interview> list1 = interviewService.queryInterByStuNo(stuNo2);
                String oldComNoStr = list1.get(0).getInterComNo();
                //申请多个企业时 旧的拼接新传来的的企业编号
                String newComNoStr = oldComNoStr + comNo;
                //未申请此公司 求职操作 将申请求职的企业编号修改进interview表中的interComNo中
                Boolean aBoolean = interviewService.findJob(stuNo2,newComNoStr);
                if(aBoolean){
                    //申请求职成功 保存提示数据返回 页面跳转
                    resultAction = new ResultAction(aBoolean,"申请求职成功 请在“就业信息”中等待求职审核结果");
                    return resultAction;
                }else{
                    //申请求职失败 保存提示数据返回 页面跳转
                    resultAction = new ResultAction(aBoolean,"服务器异常 请重试");
                    return resultAction;
                }
            }
        }else{
            //学生未填写求职信息 不可以进行求职申请 申请求职失败 保存提示数据返回 页面跳转
            resultAction = new ResultAction(false,"您还未填写学生求职信息 不能进行求职申请操作");
            return resultAction;
        }
    }

    /**
     * @Author BX
     * @Description //撤回求职申请 将comNo在求职信息表中的interComNo去除字符串String.replace()
     * @Date 13:42 2020/12/7 0005
     * @Param [request]
     * @return com.stu.util.ResultAction
     **/
    @RequestMapping(value = {"/quitJob"}, method = RequestMethod.POST)
    @ResponseBody
    public ResultAction quitJob(HttpServletRequest request) throws MyException {
        ResultAction resultAction = null;
        //获取前端传来的企业编号、学号
        String comNo = request.getParameter("adverComNo");
        String stuNo = request.getParameter("stuNo");
        int stuNo2 = Integer.valueOf(stuNo).intValue();
        //先校验学生是否填写了求职信息
        List<Interview> list = interviewService.queryInterByStuNo(stuNo2);
        if(list.size() > 0){
            //学生已填写求职信息 并进行求职申请
            //查询数据库模糊查询interview表中的interComNo来查询interview对象 为null说明未申请过 不为null则提示前端已经申请过 不可申请 根判断求职的此企业是否已经被申请过
            Interview interview = interviewService.queryInterByStuNoComNo(stuNo2,comNo);
            if(interview != null){
                //已经申请求职了此企业
                String comNoInfo = interview.getInterComNo();
                //已经对此公司提交申请求职 做撤回申请操作
                String replaceStr = comNoInfo.replace(comNo,"");
                if(StringEmpty.stringIsEmpty(replaceStr)){
                    //替换撤回所有企业的求职申请时的空字符串 因为要传int型参数
                    replaceStr = "q";
                }
                //调用mapper方法 将替换后的字符串修改进interview表中 达到撤回申请的效果
                Boolean aBoolean = interviewService.findJob(stuNo2,replaceStr);
                if(aBoolean){
                    //撤回求职申请成功 保存提示数据返回 页面跳转
                    resultAction = new ResultAction(aBoolean,"撤回求职申请成功");
                    return resultAction;
                }else{
                    //撤回求职申请失败 保存提示数据返回 页面跳转
                    resultAction = new ResultAction(aBoolean,"服务器异常 请重试");
                    return resultAction;
                }
            }else{
                //还未提交对此公司的求职申请
                resultAction = new ResultAction(false,"您还未对此企业提交求职申请 不能进行求职申请撤回操作");
                return resultAction;
            }
        }else{
            //学生未填写求职信息 不可以进行求职申请 申请求职失败 保存提示数据返回 页面跳转
            resultAction = new ResultAction(false,"您还未填写学生求职信息和提交求职申请 不能进行求职申请撤回操作");
            return resultAction;
        }
    }

    /**
     * @Author BX
     * @Description //就业推荐 通过学生信息中的学生地址和对应学生求职信息中的求职岗位 和 招聘信息中的工作地和招聘岗位匹配模糊查询来实现
     * @Date 16:13 2020/12/7 0012
     * @Param
     * @return
     **/
    @RequestMapping(value = {"/queryAdverByPageAdvise"})
    public ModelAndView queryAdverByPageAdvise(HttpServletRequest request) throws MyException {
        //获取前端数据
        String stuNoStr = request.getParameter("stuNo");
        int stuNoInt = Integer.valueOf(stuNoStr);
        //查询数据库对象 获取学生地址
        Student student = studentMapper.queryStuByNo(stuNoInt);
        String stuAddress = student.getStuAddress();
        Integer stuNo = Integer.valueOf(stuNoStr);
        //查询学生求职信息
        List<Interview> list = interviewService.queryInterByStuNo(stuNo);
        ModelAndView modelAndView = null;
        if(list.size() > 0) {
            Interview interview = list.get(0);
            String interPosition = interview.getInterPosition();
            //每页显示的数据条数
            int pageSize = 10;
            //获取客户端的页数
            String pageNoStr = request.getParameter("pageNo");
            int pageNo = PageModel.getPageNoFromIE(pageNoStr);
            //调用service层方法 查询数据库传入学生地址和学生求职职位
            PageModel<Advertise> advertisePageModel = null;
            try {
                advertisePageModel = advertiseService.queryAdverByPageAdvise(interPosition,stuAddress,pageNo,pageSize);
            } catch (MyException e) {
                e.printStackTrace();
                throw new MyException(e.getMessage());
            }
            //将pageModel对象存储在modelAndView中
            modelAndView = new ModelAndView();
            modelAndView.addObject("advertisePageModel",advertisePageModel);
            //跳转到adver_stu.jsp
            modelAndView.setViewName("student/advise_stu");
            return modelAndView;
        }else{
            //将pageModel对象存储在modelAndView中
            modelAndView = new ModelAndView();
            modelAndView.addObject("advertisePageModel",null);
            //跳转到adver_stu.jsp
            modelAndView.setViewName("student/advise_stu");
            return modelAndView;
        }
    }

}
