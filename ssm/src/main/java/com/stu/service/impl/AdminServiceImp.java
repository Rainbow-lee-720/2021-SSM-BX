package com.stu.service.impl;

import com.stu.bean.Admin;
import com.stu.exception.MyException;
import com.stu.mapper.AdminMapper;
import com.stu.service.AdminService;
import com.stu.util.StringEmpty;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @ClassName AdminServiceImp
 * @Description 管理员业务逻辑Service层
 * @Author BX
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/

@Service(value = "adminService")
public class AdminServiceImp implements AdminService {

    //spring自动注入adminMapper
    @Resource(name = "adminMapper")
    private AdminMapper adminMapper;

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [adminId, adminPwd]
     * @return com.stu.bean.Admin
     **/
    @Override
    public Admin doLogin(String adminId, String adminPwd) throws MyException {
        //校验用户名和密码
        if(StringEmpty.stringIsEmpty(adminId)){
            throw new MyException("用户名不能为空！");
        }
        if(StringEmpty.stringIsEmpty(adminPwd)){
            throw new MyException("密码不能为空！");
        }
        //调用Mapper接口方法
        Admin admin = adminMapper.doLogin(adminId,adminPwd);
        return admin;
    }

    /**
     * @param adminId
     * @return Boolean
     * @Author BX
     * @Description //根据用户名查询管理员信息
     * @Date 18:56 2020/12/10 0010
     * @Param [adminId]
     */
    @Override
    public Boolean queryAdminById(String adminId) throws MyException {
        if(StringEmpty.stringIsEmpty(adminId)){
            throw new MyException("用户名不能为空！");
        }
        //调用Mapper接口方法
        Admin admin = adminMapper.queryAdminById(adminId);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(admin)){
            return false;
        }
        return true;
    }

    /**
     * @param adminNo
     * @return Boolean
     * @Author BX
     * @Description //根据管理员编号查询管理员信息
     * @Date 18:57 2020/12/10 0010
     * @Param [adminNo]
     */
    @Override
    public Boolean queryAdminByNo(int adminNo) throws MyException {
        if(adminNo == 0){
            throw new MyException("管理员编号不能为0！");
        }
        //调用Mapper接口方法
        Admin admin = adminMapper.queryAdminByNo(adminNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(admin)){
            return false;
        }
        return true;
    }

    /**
     * @param adminNo
     * @return com.stu.bean.Admin
     * @Author BX
     * @Description //管理员个人中心 回显当前登录的管理员个人信息 并在页面中进行个人信息修改
     * @Date 13:13 2020/122/11 0011
     * @Param [adminNo]
     */
    @Override
    public Admin queryAdminByNoCenter(int adminNo) throws MyException {
        if(adminNo == 0){
            throw new MyException("管理员编号不能为0！");
        }
        //调用Mapper接口方法
        Admin admin = adminMapper.queryAdminByNo(adminNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(admin)){
            return null;
        }
        return admin;
    }

    /**
     * @param adminNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //修改管理员个人信息
     * @Date 14:16 2020/122/11 0011
     * @Param [admin]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateAdmin(int adminNo,String adminId,String adminName,String adminPhone,String adminSex) throws MyException {
        //封装参数
        Admin admin = new Admin();
        admin.setAdminNo(adminNo);
        admin.setAdminId(adminId);
        admin.setAdminName(adminName);
        admin.setAdminPhone(adminPhone);
        admin.setAdminSex(adminSex);
        //调用Mapper接口方法
        Boolean aBoolean = adminMapper.updateAdmin(admin);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param newPwd
     * @param oldPwd
     * @return java.lang.Boolean
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/122/15 0015
     * @Param [string]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateAdminPwd(String newPwd, String oldPwd) {
        //调用Mapper接口方法
        Boolean aBoolean = adminMapper.updateAdminPwd(newPwd,oldPwd);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

}
