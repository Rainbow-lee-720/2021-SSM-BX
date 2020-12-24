package com.stu.service;

import com.stu.bean.Company;
import com.stu.exception.MyException;
import com.stu.util.PageModel;

import java.util.List;

/**
 * @ClassName CompanyService
 * @Description 企业Service
 * @Author Administrator
 * @Date 2020/12/8 0008 22:39
 * @Version 1.0
 **/
public interface CompanyService {

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [comId, comPwd]
     * @return com.stu.bean.Company
     **/
    Company doLogin(String comId, String comPwd) throws MyException;

    /**
     * @Author BX
     * @Description //企业注册
     * @Date 22:37 2020/12/8 0008
     * @Param [company]
     * @return Boolean
     **/
    Boolean comRegist(Company company) throws MyException;

    /**
     * @Author BX
     * @Description //根据用户名查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:56 2020/12/10 0010
     * @Param [comId]
     * @return Boolean
     **/
    Boolean queryComById(String comId) throws MyException;

    /**
     * @Author BX
     * @Description //根据用户名查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）---查询对象
     * @Date 18:56 2020/12/10 0010
     * @Param [comId]
     * @return Company
     **/
    Company queryComByIdCom(String comId) throws MyException;

    /**
     * @Author BX
     * @Description //根据企业编号查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:57 2020/12/10 0010
     * @Param [comNo]
     * @return Boolean
     **/
    Boolean queryComByNo(int comNo) throws MyException;

    /**
     * @Author BX
     * @Description //根据手机号查询企业信息 注册需要用来校验
     * @Date 22:09 2020/12/10 0010
     * @Param [comPhone]
     * @return com.stu.bean.Boolean
     **/
    Boolean queryComByPhone(String comPhone)  throws MyException;

    /**
     * @Author BX
     * @Description //根据企业编号查询企业信息 用于显示企业详细信息 前端表格展示
     * @Date 11:42 2020/122/5 0005
     * @Param [comNo]
     * @return com.stu.bean.Company
     **/
    Company queryComInfo(int comNo) throws MyException;

    /**
     * @Author BX
     * @Description //分页查询企业信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return
     **/
    PageModel<Company> queryComByPage(int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //根据五个条件动态分页查询企业信息
     * @Date 14:56 2020/12/21 0021
     * @Param [comNo, comName, comAddress, comType]
     * @return java.util.List<com.stu.bean.Student>
     **/
    PageModel<Company> queryComByFiveCon(String comNo,String comName,String comAddress,String comType,String comKind,int pageNo,int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //前端页面删除企业数据
     * @Date 13:50 2020/122/5 0005
     * @Param [comNo]
     * @return java.lang.Boolean
     **/
    Boolean delCom(int comNo) throws MyException;

    /**
     * @Author BX
     * @Description //查询所有企业类型、企业性质 在企业查询的select下拉框中用到
     * @Date 13:25 2020/122/6 0006
     * @Param []
     * @return java.util.List<java.lang.Company>
     **/
    List<Company> queryComTypeAndKind() throws MyException;

    /**
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/122/15 0015
     * @Param [admin]
     * @return java.lang.Boolean
     **/
    Boolean updateComPwd(String newPwd,String oldPwd);

    /**
     * @Author BX
     * @Description //修改企业信息
     * @Date 14:16 2020/122/11 0011
     * @Param [String]
     * @return Boolean
     **/
    Boolean updateCom(int comNo,String comId,String comName,String comPhone,String comAddress,String comKind,long comNum,String comType,String comBack) throws MyException;

    /**
     * @Author BX
     * @Description //企业中心 回显当前登录的企业信息 并在页面中进行企业信息修改
     * @Date 13:13 2020/122/11 0011
     * @Param [comNo]
     * @return com.stu.bean.Company
     **/
    Company queryComByNoCenter(int comNo) throws MyException;

    /**
     * @Author BX
     * @Description //账号注销
     * @Date 10:49 2020/122/19 0019
     * @Param [comNo]
     * @return java.lang.Boolean
     **/
    Boolean logOutCom(int comNo) throws MyException;

}
