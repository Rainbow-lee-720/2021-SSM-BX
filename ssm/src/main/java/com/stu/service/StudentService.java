package com.stu.service;

import com.stu.bean.Student;
import com.stu.exception.MyException;
import com.stu.util.PageModel;

/**
 * @ClassName StudentService
 * @Description 学生Service
 * @Author Administrator
 * @Date 2020/12/7 0007 21:46
 * @Version 1.0
 **/
public interface StudentService {

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [stuId, stuPwd]
     * @return com.stu.bean.Student
     **/
    Student doLogin(String stuId, String stuPwd) throws MyException;

    /**
     * @Author BX
     * @Description //学生注册
     * @Date 22:37 2020/12/8 0008
     * @Param [student]
     * @return Boolean
     **/
    Boolean stuRegist(Student student) throws MyException;

    /**
     * @Author BX
     * @Description //根据用户名查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:56 2020/12/10 0010
     * @Param [stuId]
     * @return Boolean
     **/
    Boolean queryStuById(String stuId) throws MyException;

    /**
     * @Author BX
     * @Description //根据用户名查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）---查询对象
     * @Date 18:56 2020/12/10 0010
     * @Param [stuId]
     * @return Student
     **/
    Student queryStuByIdStu(String stuId) throws MyException;

    /**
     * @Author BX
     * @Description //根据学号查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:57 2020/12/10 0010
     * @Param [stuNo]
     * @return Boolean
     **/
    Boolean queryStuByNo(int stuNo) throws MyException;

    /**
     * @Author BX
     * @Description //根据手机号查询学生信息 注册需要用来校验
     * @Date 22:09 2020/12/10 0010
     * @Param [stuPhone]
     * @return com.stu.bean.Boolean
     **/
    Boolean queryStuByPhone(String stuPhone)  throws MyException;

    /**
     * @Author BX
     * @Description //根据学号查询学生信息 用于显示学生详细信息 前端表格展示
     * @Date 11:42 2020/12/5 0005
     * @Param [stuNo]
     * @return com.stu.bean.Student
     **/
    Student queryStuInfo(int stuNo) throws MyException;

    /**
     * @Author BX
     * @Description //分页查询学生信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return
     **/
    PageModel<Student> queryStuByPage(int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //根据四个条件动态分页查询学生信息
     * @Date 14:56 2020/12/21 0021
     * @Param [stuNo, stuName, stuSex, stuSchool]
     * @return java.util.List<com.stu.bean.Student>
     **/
    PageModel<Student> queryStuByFourCon(String stuNo,String stuName,String stuSex,String stuSchool,int pageNo,int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //前端页面删除学生数据
     * @Date 13:50 2020/12/5 0005
     * @Param [stuNo]
     * @return java.lang.Boolean
     **/
    Boolean delStu(int stuNo) throws MyException;

    /**
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/12/15 0015
     * @Param [admin]
     * @return java.lang.Boolean
     **/
    Boolean updateStuPwd(String newPwd,String oldPwd);

    /**
     * @Author BX
     * @Description //修改学生个人信息
     * @Date 14:16 2020/12/11 0011
     * @Param [String]
     * @return Boolean
     **/
    Boolean updateStu(int stuNo,String stuId,String stuName,long stuAge,String stuSex,String stuSchool,String stuSpecialty,String stuPhone,String stuAddress,String stuDegree) throws MyException;

    /**
     * @Author BX
     * @Description //学生个人中心 回显当前登录的学生个人信息 并在页面中进行个人信息修改
     * @Date 13:13 2020/12/11 0011
     * @Param [stuNo]
     * @return com.stu.bean.Student
     **/
    Student queryStuByNoCenter(int stuNo) throws MyException;

    /**
     * @Author BX
     * @Description //账号注销
     * @Date 10:49 2020/12/19 0019
     * @Param [stuNo]
     * @return java.lang.Boolean
     **/
    Boolean logOutCom(int stuNo) throws MyException;


}
