package com.stu.service;

import com.stu.bean.Employ;
import com.stu.bean.Interview;
import com.stu.exception.MyException;
import com.stu.util.PageModel;

import java.util.List;

/**
 * @ClassName InterviewService
 * @Description 求职信息Service
 * @Author Administrator
 * @Date 2020/12/7 0007 21:46
 * @Version 1.0
 **/
public interface InterviewService {

    /**
     * @Author BX
     * @Description //添加求职信息
     * @Date 22:37 2020/12/8 0008
     * @Param [student]
     * @return Boolean
     **/
    Boolean addInterview(Interview interview) throws MyException;

    /**
     * @Author BX
     * @Description //修改求职信息
     * @Date 14:16 2020/122/11 0011
     * @Param [String]
     * @return Boolean  ,interStuNo,,interName,interSex,interAge,interSpecialty,interSchool,interDegree,interPhone,interPosition,interSalary,interLocation,interDate
     **/
    Boolean updateInterview(int interStuNo, String interName, String interSex, long interAge, String interSpecialty, String interSchool, String interDegree, String interPhone, String interPosition,long interSalary, String interLocation) throws MyException;

    /**
     * @Author BX
     * @Description //求职信息 回显当前登录的学生求职信息 并在页面中进行求职信息修改
     * @Date 13:13 2020/122/11 0011
     * @Param [interStuNo]
     * @return com.stu.bean.Student
     **/
    List<Interview> queryInterByStuNo(int interStuNo) throws MyException;

    /**
     * @Author BX
     * @Description //前端页面删除求职信息
     * @Date 13:48 2020/122/5 0005
     * @Param [interStuNo]
     * @return java.lang.Boolean
     **/
    Boolean delInter(int interStuNo) throws MyException;

    /**
     * @Author BX
     * @Description //根据学生编号、企业编号模糊查询求职信息 用于校验此企业是否已经被申请过
     * @Date 18:57 2020/12/10 0010
     * @Param [comNo]
     * @return com.stu.bean.Interview
     **/
    Interview queryInterByStuNoComNo(int interStuNo,String interComNo) throws MyException;

    /**
     * @Author BX
     * @Description //求职操作 将申请求职的企业编号修改进interview表中的interComNo中
     * @Date 19:10 2020/122/26 0026
     * @Param [interStuNo, interComNo]
     * @return java.lang.Boolean
     **/
    Boolean findJob(int interStuNo,String interComNo) throws MyException;

    /**
     * @Author BX
     * @Description //分页查询所有求职信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return Interview
     **/
    PageModel<Interview> queryInterByPage(String comNo, int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //根据四个条件动态查询求职信息
     * @Date 14:56 2020/12/21 0021
     * @Param [comNo,interSex,interDegree,interLocation,startSalary,endSalary,pageNo,pageSize]
     * @return java.util.List<com.stu.bean.Interview>
     **/
    PageModel<Interview> queryInterByFourCon(String comNo,String interSex, String interDegree, String interLocation, int startSalary,int endSalary, int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //根据学号、企业编号查询学生求职信息 用于显示学生求职详细信息 前端模态框展示
     * @Date 11:42 2020/122/5 0005
     * @Param [stuNo,comNo]
     * @return com.stu.bean.Interview
     **/
    Interview queryInterInfo(int stuNo,int comNo) throws MyException;

    /**
     * @Author BX
     * @Description //添加就业信息
     * @Date 22:37 2020/12/8 0008
     * @Param [employ]
     * @return Boolean
     **/
    Boolean addEmploy(Employ employ) throws MyException;

}
