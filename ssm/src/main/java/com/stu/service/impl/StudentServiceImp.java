package com.stu.service.impl;

import com.stu.bean.Student;
import com.stu.exception.MyException;
import com.stu.mapper.StudentMapper;
import com.stu.service.StudentService;
import com.stu.util.ObjectEmpty;
import com.stu.util.PageModel;
import com.stu.util.StringEmpty;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName StudentServiceImp
 * @Description 学生业务逻辑Service层
 * @Author Administrator
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/

@Service(value = "studentService")
public class StudentServiceImp implements StudentService {

    //spring自动注入studentMapper
    @Resource(name = "studentMapper")
    private StudentMapper studentMapper;

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [stuId, stuPwd]
     * @return com.stu.bean.Student
     **/
    @Override
    public Student doLogin(String stuId, String stuPwd) throws MyException {
        //校验用户名和密码
        if(StringEmpty.stringIsEmpty(stuId)){
            throw new MyException("用户名不能为空！");
        }
        if(StringEmpty.stringIsEmpty(stuPwd)){
            throw new MyException("密码不能为空！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.doLogin(stuId,stuPwd);
        return student;
    }

    /**
     * @param student
     * @return boolean
     * @Author BX
     * @Description //学生注册 insert需要加上事务
     * @Date 22:37 2020/12/8 0008
     * @Param [student]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean stuRegist(Student student) throws MyException {
        if(ObjectEmpty.objectIsEmpty(student)){
            throw new MyException("服务器出错！");
        }else if(queryStuByNo(student.getStuNo())){
            //调用Mapper层方法校验学号是否已经注册
            throw new MyException("该学号已注册！请重新注册！");
        }else if(queryStuById(student.getStuId())){
            //调用Mapper层方法校验学生用户名是否已经存在
            throw new MyException("该用户名已存在！请重新注册！");
        }else if(queryStuByPhone(student.getStuPhone())){
            //调用Mapper层方法校验学生手机号是否已经存在
            throw new MyException("学生手机号已存在！请重新填写！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = studentMapper.stuRegist(student);
        return aBoolean;
    }

    /**
     * @param stuId
     * @return com.stu.bean.Student
     * @Author BX
     * @Description //根据用户名查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:56 2020/12/10 0010
     * @Param [stuId]
     */
    @Override
    public Boolean queryStuById(String stuId) throws MyException {
        if(StringEmpty.stringIsEmpty(stuId)){
            throw new MyException("用户名不能为空！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.queryStuById(stuId);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(student)){
            return false;
        }
        return true;
    }

    /**
     * @param stuId
     * @return Boolean
     * @Author BX
     * @Description //根据用户名查询学生信息--获取对象
     * @Date 18:56 2020/12/10 0010
     * @Param [stuId]
     */
    @Override
    public Student queryStuByIdStu(String stuId) throws MyException {
        if(StringEmpty.stringIsEmpty(stuId)){
            throw new MyException("用户名不能为空！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.queryStuById(stuId);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(student)){
            return student;
        }
        return student;
    }

    /**
     * @param stuNo
     * @return com.stu.bean.Student
     * @Author BX
     * @Description //根据学号查询学生信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:57 2020/12/10 0010
     * @Param [stuNo]
     */
    @Override
    public Boolean queryStuByNo(int stuNo) throws MyException {
        if(stuNo == 0){
            throw new MyException("学号不能为0！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.queryStuByNo(stuNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(student)){
            return false;
        }
        return true;
    }

    /**
     * @param stuNo
     * @return com.stu.bean.Student
     * @Author BX
     * @Description //根据学号查询学生信息 用于显示学生详细信息 前端表格展示
     * @Date 11:42 2020/12/5 0005
     * @Param [stuNo]
     */
    @Override
    public Student queryStuInfo(int stuNo) throws MyException {
        if(stuNo == 0){
            throw new MyException("学号不能为0！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.queryStuByNo(stuNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(student)){
            throw new MyException("该学生信息不存在！");
        }
        return student;
    }

    /**
     * @param stuPhone
     * @return com.stu.bean.Boolean
     * @Author BX
     * @Description //根据手机号查询学生信息 注册需要用来校验
     * @Date 22:09 2020/12/10 0010
     * @Param [stuPhone]
     */
    @Override
    public Boolean queryStuByPhone(String stuPhone) throws MyException {
        if(StringEmpty.stringIsEmpty(stuPhone)){
            throw new MyException("学生手机号不能为空！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.queryStuByPhone(stuPhone);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(student)){
            return false;
        }
        return true;
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //分页查询学生信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Student> queryStuByPage(int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        PageModel<Student> pageModel = new PageModel<Student>();
        //调用Mapper接口方法
        List<Student> dataList = studentMapper.queryStuByPage(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        pageModel.setCnt(studentMapper.queryStuCount());
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param stuNo
     * @param stuName
     * @param stuSex
     * @param stuSchool
     * @return java.util.List<com.stu.bean.Student>
     * @Author BX
     * @Description //根据四个条件动态分页查询学生信息
     * @Date 14:56 2020/12/21 0021
     * @Param [stuNo, stuName, stuSex, stuSchool]
     */
    @Override
    public PageModel<Student> queryStuByFourCon(String stuNo, String stuName, String stuSex, String stuSchool,int pageNo,int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        map.put("stuNo", stuNo);
        map.put("stuName", stuName);
        map.put("stuSex", stuSex);
        map.put("stuSchool", stuSchool);
        PageModel<Student> pageModel = new PageModel<Student>();
        //调用Mapper接口方法
        List<Student> dataList = studentMapper.queryStuByFourCon(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        long cnt = studentMapper.queryCntByFourCon(stuNo,stuName,stuSex,stuSchool);
        pageModel.setCnt(cnt);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param stuNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //前端页面删除学生数据
     * @Date 13:50 2020/12/5 0005
     * @Param [stuNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean delStu(int stuNo) throws MyException {
        if(stuNo == 0){
            throw new MyException("学号不能为0！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = studentMapper.delStu(stuNo);
        return aBoolean;
    }

    /**
     * @param stuNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //修改学生个人信息
     * @Date 14:16 2020/12/11 0011
     * @Param [string]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateStu(int stuNo,String stuId,String stuName,long stuAge,String stuSex,String stuSchool,String stuSpecialty,String stuPhone,String stuAddress,String stuDegree) throws MyException {
        //封装参数
        Student student = new Student();
        student.setStuNo(stuNo);
        student.setStuId(stuId);
        student.setStuName(stuName);
        student.setStuAge(stuAge);
        student.setStuSex(stuSex);
        student.setStuSchool(stuSchool);
        student.setStuSpecialty(stuSpecialty);
        student.setStuPhone(stuPhone);
        student.setStuAddress(stuAddress);
        student.setStuDegree(stuDegree);
        //调用Mapper接口方法
        Boolean aBoolean = studentMapper.updateStu(student);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param stuNo
     * @return com.stu.bean.Student
     * @Author BX
     * @Description //学生个人中心 回显当前登录的学生个人信息 并在页面中进行个人信息修改
     * @Date 13:13 2020/12/11 0011
     * @Param [stuNo]
     */
    @Override
    public Student queryStuByNoCenter(int stuNo) throws MyException {
        if(stuNo == 0){
            throw new MyException("学生学号不能为0！");
        }
        //调用Mapper接口方法
        Student student = studentMapper.queryStuByNo(stuNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(student)){
            return null;
        }
        return student;
    }

    /**
     * @param newPwd
     * @param oldPwd
     * @return java.lang.Boolean
     * @Author BX
     * @Description //账号管理 修改用户密码
     * @Date 13:22 2020/12/15 0015
     * @Param [string]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateStuPwd(String newPwd, String oldPwd) {
        //调用Mapper接口方法
        Boolean aBoolean = studentMapper.updateStuPwd(newPwd,oldPwd);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param stuNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //账号注销
     * @Date 10:49 2020/12/19 0019
     * @Param [stuNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean logOutCom(int stuNo) throws MyException {
        //调用Mapper接口方法
        Boolean aBoolean = studentMapper.logOutCom(stuNo);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

}
