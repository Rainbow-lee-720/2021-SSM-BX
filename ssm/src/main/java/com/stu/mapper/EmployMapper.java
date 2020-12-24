package com.stu.mapper;

import com.stu.bean.Employ;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @ClassName EmployMapper
 * @Description 就业信息Mapper
 * @Author BX
 * @Date 2020/12/8 0008 22:36
 * @Version 1.0
 **/

@Repository(value = "employMapper")
public interface EmployMapper {

    /**
     * @Author BX
     * @Description //添加就业信息
     * @Date 22:37 2020/12/8 0008
     * @Param [interview]
     * @return Boolean
     **/
    Boolean addEmploy(Employ employ);

    /**
     * @Author BX
     * @Description //前端页面删除就业信息
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     * @return java.lang.Boolean
     **/
    Boolean delEmp(@Param("empNo") int empNo);

    /**
     * @Author BX
     * @Description //确认就业 将状态码由0改为1 标识确认就业
     * @Date 19:10 2020/12/26 0026
     * @Param [empNo]
     * @return java.lang.Boolean
     **/
    Boolean comfirmEmp(@Param("empNo") int empNo);

    /**
     * @Author BX
     * @Description //分页查询所有就业信息
     * @Date 16:02 2020/12/12 0012
     * @Param [params]
     * @return Employ
     **/
    List<Employ> queryEmpByPage(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //查询就业数据条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    long queryEmpCount(@Param("stuNo") int stuNo);

    /**
     * @Author BX
     * @Description //根据三个条件动态查询就业信息
     * @Date 14:53 2020/12/21 0021
     * @Param []
     * @return java.util.List<com.stu.bean.Employ>
     **/
    List<Employ> queryEmpByThreeCon(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //根据三个条件动态查询就业信息
     * @Date 16:49 2020/12/21 0021
     * @Param [empComName, empPosition, startSalary, endSalary, pageNo, pageSize]
     * @return long
     **/
    long queryCntByThreeCon(@Param("stuNo") int stuNo,@Param("empComName") String empComName, @Param("empPosition") String empPosition, @Param("startSalary") int startSalary, @Param("endSalary") int endSalary);

    /**
     * @Author BX
     * @Description //校验是否已经确认就业
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     * @return java.lang.Employ
     **/
    Employ queryEmpByStuNoState(@Param("empStuNo") int empStuNo);

    /**
     * @Author BX
     * @Description //查询薪资在3000以下的条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    Integer queryEmpSalaryCount1();

    /**
     * @Author BX
     * @Description //查询薪资在3001-5000的条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    Integer queryEmpSalaryCount2();

    /**
     * @Author BX
     * @Description //查询薪资在5001-7000的条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    Integer queryEmpSalaryCount3();

    /**
     * @Author BX
     * @Description //查询薪资在7001-10000的条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    Integer queryEmpSalaryCount4();

    /**
     * @Author BX
     * @Description //查询薪资在10000以上的条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    Integer queryEmpSalaryCount5();

    /**
     * @Author BX
     * @Description //查询所有就业信息
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    List<Employ> queryAllEmp();

    /**
     * @Author BX
     * @Description //根据企业编号查询就业信息
     * @Date 13:13 2020/12/11 0011
     * @Param [empComNo]
     * @return com.stu.bean.Employ
     **/
    List<Employ> queryEmpByComNo(@Param("empComNo") int empComNo);

    /**
     * @Author BX
     * @Description //根据学号查询就业信息
     * @Date 13:13 2020/12/11 0011
     * @Param [empStuNo]
     * @return com.stu.bean.Employ
     **/
    List<Employ> queryEmpByStuNo(@Param("empStuNo") int empStuNo);

}
