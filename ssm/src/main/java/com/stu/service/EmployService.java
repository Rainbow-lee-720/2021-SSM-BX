package com.stu.service;

import com.stu.bean.Employ;
import com.stu.exception.MyException;
import com.stu.util.PageModel;

import java.text.ParseException;
import java.util.List;

/**
 * @ClassName EmployService
 * @Description 就业信息Service
 * @Author Administrator
 * @Date 2020/12/7 0007 21:46
 * @Version 1.0
 **/
public interface EmployService {

    /**
     * @Author BX
     * @Description //前端页面删除就业信息
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     * @return java.lang.Boolean
     **/
    Boolean delEmp(int empNo) throws MyException;

    /**
     * @Author BX
     * @Description //分页查询所有就业信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return Employ
     **/
    PageModel<Employ> queryEmpByPage(int stuNo,int pageNo, int pageSize) throws MyException, ParseException;

    /**
     * @Author BX
     * @Description //根据三个条件动态查询就业信息
     * @Date 14:56 2020/12/21 0021
     * @Param [empComName,empPosition,startSalary,endSalary,pageNo,pageSize]
     * @return java.util.List<com.stu.bean.Employ>
     **/
    PageModel<Employ> queryEmpByThreeCon(int stuNo,String empComName, String empPosition, int startSalary, int endSalary, int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //确认就业 将状态码由0改为1 标识确认就业
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     * @return java.lang.Boolean
     **/
    Boolean comfirmEmp(int empNo) throws MyException;

    /**
     * @Author BX
     * @Description //校验是否已经确认就业
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     * @return java.lang.Employ
     **/
    Employ queryEmpByStuNoState(int empStuNo) throws MyException;

    /**
     * @Author BX
     * @Description //根据企业编号查询就业信息
     * @Date 13:13 2020/12/11 0011
     * @Param [empComNo]
     * @return com.stu.bean.Employ
     **/
    List<Employ> queryEmpByComNo(int empComNo) throws MyException;

    /**
     * @Author BX
     * @Description //根据学号查询就业信息
     * @Date 13:13 2020/12/11 0011
     * @Param [empStuNo]
     * @return com.stu.bean.Employ
     **/
    List<Employ> queryEmpByStuNo(int empStuNo) throws MyException;

}
