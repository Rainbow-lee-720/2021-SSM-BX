package com.stu.mapper;

import com.stu.bean.Company;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @ClassName CompanyMapper
 * @Description 企业Mapper
 * @Author BX
 * @Date 2020/12//8 0008 22:36
 * @Version 1.0
 **/

@Repository(value = "companyMapper")
public interface CompanyMapper {

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12//8 0008
     * @Param [comId, comPwd]
     * @return com.stu.bean.Company
     **/
    Company doLogin(@Param("comId") String comId, @Param("comPwd") String comPwd);

    /**
     * @Author BX
     * @Description //企业注册
     * @Date 22:37 2020/12//8 0008
     * @Param [company]
     * @return Boolean
     **/
    Boolean comRegist(Company company);

    /**
     * @Author BX
     * @Description //根据用户名查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:56 2020/1/10 0010
     * @Param [comId]
     * @return com.stu.bean.Company
     **/
    Company queryComById(@Param("comId") String comId);

    /**
     * @Author BX
     * @Description //根据企业编号查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:57 2020/1/10 0010
     * @Param [comNo]
     * @return com.stu.bean.Company
     **/
    Company queryComByNo(@Param("comNo") int comNo);

    /**
     * @Author BX
     * @Description //根据手机号查询企业信息 注册需要用来校验
     * @Date 22:09 2020/1/10 0010
     * @Param [comPhone]
     * @return com.stu.bean.Company
     **/
    Company queryComByPhone(@Param("comPhone") String comPhone);

    /**
     * @Author BX
     * @Description //分页查询企业信息
     * @Date 16:02 2020/1/12 0012
     * @Param [params]
     * @return Company
     **/
    List<Company> queryComByPage(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //查询企业数据条数
     * @Date 16:03 2020/1/12 0012
     * @Param []
     * @return int
     **/
    long queryComCount();

    /**
     * @Author BX
     * @Description //根据五个条件动态查询企业信息
     * @Date 14:53 2020/1/21 0021
     * @Param []
     * @return java.util.List<com.stu.bean.Company>
     **/
    List<Company> queryComByFiveCon(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //根据五个条件动态所有条数
     * @Date 16:49 2020/1/21 0021
     * @Param [comNo, comName, comAddress, comType]
     * @return long
     **/
    long queryCntByFiveCon(@Param("comNo") String comNo, @Param("comName") String comName, @Param("comAddress") String comAddress, @Param("comType") String comType, @Param("comKind") String comKind);

    /**
     * @Author BX
     * @Description //前端页面删除企业数据
     * @Date 13:48 2020/12/5 0005
     * @Param [stuNo]
     * @return java.lang.Boolean
     **/
    Boolean delCom(@Param("comNo") int comNo);

    /**
     * @Author BX
     * @Description //查询所有企业类型、企业性质 在企业查询的select下拉框中用到
     * @Date 13:25 2020/12/6 0006
     * @Param []
     * @return java.util.List<java.lang.String>
     **/
    List<Company> queryComTypeAndKind();

    /**
     * @Author BX
     * @Description //修改企业信息
     * @Date 14:16 2020/12/11 0011
     * @Param [company]
     * @return Boolean
     **/
    Boolean updateCom(Company company);

    /**
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/12/15 0015
     * @Param [admin]
     * @return java.lang.Boolean
     **/
    Boolean updateComPwd(@Param("newPwd") String newPwd,@Param("oldPwd") String oldPwd);

    /**
     * @Author BX
     * @Description //账号注销
     * @Date 10:49 2020/12/19 0019
     * @Param [comNo]
     * @return java.lang.Boolean
     **/
    Boolean logOutCom(@Param("comNo") int comNo);

}
