package com.stu.mapper;

import com.stu.bean.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @ClassName StudentMapper
 * @Description 学生Mapper
 * @Author BX
 * @Date 2020/12/7 0007 21:46
 * @Version 1.0
 **/

@Repository(value = "studentMapper")
public interface StudentMapper {

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [stuId, stuPwd]
     * @return com.stu.bean.Student
     **/
    Student doLogin(@Param("stuId") String stuId, @Param("stuPwd") String stuPwd);

    /**
     * @Author BX
     * @Description //学生注册
     * @Date 22:37 2020/12/8 0008
     * @Param [student]
     * @return Boolean
     **/
    Boolean stuRegist(Student student);

    /**
     * @Author BX
     * @Description //根据用户名查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:56 2020/12/10 0010
     * @Param [stuId]
     * @return com.stu.bean.Student
     **/
    Student queryStuById(@Param("stuId") String stuId);

    /**
     * @Author BX
     * @Description //根据学号查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:57 2020/12/10 0010
     * @Param [stuNo]
     * @return com.stu.bean.Student
     **/
    Student queryStuByNo(@Param("stuNo") int stuNo);

    /**
     * @Author BX
     * @Description //根据手机号查询学生信息 注册需要用来校验
     * @Date 22:09 2020/12/10 0010
     * @Param [stuPhone]
     * @return com.stu.bean.Student
     **/
    Student queryStuByPhone(@Param("stuPhone") String stuPhone);

    /**
     * @Author BX
     * @Description //分页查询学生信息
     * @Date 16:02 2020/12/12 0012
     * @Param [params]
     * @return Student
     **/
    List<Student> queryStuByPage(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //查询学生数据条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return int
     **/
    long queryStuCount();

    /**
     * @Author BX
     * @Description //根据四个条件动态查询学生信息
     * @Date 14:53 2020/12/21 0021
     * @Param []
     * @return java.util.List<com.stu.bean.Student>
     **/
//    List<Student> queryStuByFourCon(@Param("stuNo") String stuNo, @Param("stuName") String stuName, @Param("stuSex") String stuSex, @Param("stuSchool") String stuSchool, @Param("pageModel") PageModel<Student> pageModel);
    List<Student> queryStuByFourCon(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //根据四个条件动态所有条数
     * @Date 16:49 2020/12/21 0021
     * @Param [stuNo, stuName, stuSex, stuSchool]
     * @return long
     **/
    long queryCntByFourCon(@Param("stuNo") String stuNo, @Param("stuName") String stuName, @Param("stuSex") String stuSex, @Param("stuSchool") String stuSchool);

    /**
     * @Author BX
     * @Description //前端页面删除学生数据
     * @Date 13:48 2020/12/5 0005
     * @Param [stuNo]
     * @return java.lang.Boolean
     **/
    Boolean delStu(@Param("stuNo") int stuNo);

    /**
     * @Author BX
     * @Description //修改学生个人信息
     * @Date 14:16 2020/12/11 0011
     * @Param [student]
     * @return Boolean
     **/
    Boolean updateStu(Student student);

    /**
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/12/15 0015
     * @Param [admin]
     * @return java.lang.Boolean
     **/
    Boolean updateStuPwd(@Param("newPwd") String newPwd,@Param("oldPwd") String oldPwd);

    /**
     * @Author BX
     * @Description //账号注销
     * @Date 10:49 2020/12/19 0019
     * @Param [stuNo]
     * @return java.lang.Boolean
     **/
    Boolean logOutCom(@Param("stuNo") int stuNo);

}
