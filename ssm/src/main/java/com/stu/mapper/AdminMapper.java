package com.stu.mapper;

import com.stu.bean.Admin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @ClassName AdminMapper
 * @Description 管理员Mapper
 * @Author BX
 * @Date 2020/12/8 0008 22:36
 * @Version 1.0
 **/

@Repository(value = "adminMapper")
public interface AdminMapper {

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [adminId, adminPwd]
     * @return com.stu.bean.Admin
     **/
    Admin doLogin(@Param("adminId") String adminId, @Param("adminPwd") String adminPwd);

    /**
     * @Author BX
     * @Description //根据管理员用户名查询管理员信息
     * @Date 18:56 2020/12/10 0010
     * @Param [adminId]
     * @return com.stu.bean.Admin
     **/
    Admin queryAdminById(@Param("adminId") String adminId);

    /**
     * @Author BX
     * @Description //根据管理员编号查询管理员信息
     * @Date 18:57 2020/12/10 0010
     * @Param [adminNo]
     * @return com.stu.bean.Admin
     **/
    Admin queryAdminByNo(@Param("adminNo") int adminNo);

    /**
     * @Author BX
     * @Description //修改管理员个人信息
     * @Date 14:16 2020/12/11 0011
     * @Param [admin]
     * @return Boolean
     **/
    Boolean updateAdmin(Admin admin);

    /**
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/12/15 0015
     * @Param [string]
     * @return java.lang.Boolean
     **/
    Boolean updateAdminPwd(@Param("newPwd") String newPwd,@Param("oldPwd") String oldPwd);

}
