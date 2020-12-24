package com.stu.service;

import com.stu.bean.Admin;
import com.stu.exception.MyException;

/**
 * @ClassName AdminService
 * @Description 管理员Service
 * @Author Administrator
 * @Date 2020/12/8 0008 22:39
 * @Version 1.0
 **/
public interface AdminService {

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [adminId, adminPwd]
     * @return com.stu.bean.Admin
     **/
    Admin doLogin(String adminId, String adminPwd) throws MyException;

    /**
     * @Author BX
     * @Description //根据用户名查询管理员信息
     * @Date 18:56 2020/12/10 0010
     * @Param [adminId]
     * @return Boolean
     **/
    Boolean queryAdminById(String adminId) throws MyException;

    /**
     * @Author BX
     * @Description //根据管理员编号查询管理员信息
     * @Date 18:57 2020/12/10 0010
     * @Param [adminNo]
     * @return Boolean
     **/
    Boolean queryAdminByNo(int adminNo) throws MyException;

    /**
     * @Author BX
     * @Description //管理员个人中心 回显当前登录的管理员个人信息 并在页面中进行个人信息修改
     * @Date 13:13 2020/122/11 0011
     * @Param [adminNo]
     * @return com.stu.bean.Admin
     **/
    Admin queryAdminByNoCenter(int adminNo) throws MyException;

    /**
     * @Author BX
     * @Description //修改管理员个人信息
     * @Date 14:16 2020/122/11 0011
     * @Param [string]
     * @return Boolean
     **/
    Boolean updateAdmin(int adminNo,String adminId,String adminName,String adminPhone,String adminSex) throws MyException;

    /**
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/122/15 0015
     * @Param [admin]
     * @return java.lang.Boolean
     **/
    Boolean updateAdminPwd(String newPwd,String oldPwd);

}
