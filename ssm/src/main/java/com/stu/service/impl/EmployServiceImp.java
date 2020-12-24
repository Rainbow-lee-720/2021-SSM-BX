package com.stu.service.impl;

import com.stu.bean.Employ;
import com.stu.exception.MyException;
import com.stu.mapper.EmployMapper;
import com.stu.service.EmployService;
import com.stu.util.PageModel;
import com.stu.util.StringEmpty;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName EmployServiceImp
 * @Description 就业信息业务逻辑Service层
 * @Author BX
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/

@Service(value = "employServiceImp")
public class EmployServiceImp implements EmployService {

    //spring自动注入employMapper
    @Resource(name = "employMapper")
    private EmployMapper employMapper;

    /**
     * @param empNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //前端页面删除就业信息
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean delEmp(int empNo) throws MyException {
        if(empNo == 0){
            throw new MyException("就业编号不能为0！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = employMapper.delEmp(empNo);
        return aBoolean;
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return Employ
     * @Author BX
     * @Description //分页查询所有就业信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Employ> queryEmpByPage(int stuNo,int pageNo, int pageSize) throws MyException, ParseException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("stuNo", stuNo);
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        PageModel<Employ> pageModel = new PageModel<Employ>();
        //调用Mapper接口方法
        List<Employ> dataList = employMapper.queryEmpByPage(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        long count = employMapper.queryEmpCount(stuNo);
        //调用Mapper接口方法
        pageModel.setCnt(count);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param empComName
     * @param empPosition
     * @param startSalary
     * @param endSalary
     * @param pageNo
     * @param pageSize
     * @return java.util.List<com.stu.bean.Employ>
     * @Author BX
     * @Description //根据三个条件动态查询就业信息
     * @Date 14:56 2020/12/21 0021
     * @Param [empComName, empPosition, startSalary, endSalary, pageNo, pageSize]
     */
    @Override
    public PageModel<Employ> queryEmpByThreeCon(int stuNo,String empComName, String empPosition, int startSalary, int endSalary, int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("stuNo", stuNo);
        map.put("pageSize", pageSize);
        map.put("empComName", empComName);
        map.put("empPosition", empPosition);
        map.put("startSalary", startSalary);
        map.put("endSalary", endSalary);
        PageModel<Employ> pageModel = new PageModel<Employ>();
        //调用Mapper接口方法
        List<Employ> dataList = employMapper.queryEmpByThreeCon(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        long cnt = employMapper.queryCntByThreeCon(stuNo,empComName,empPosition,startSalary,endSalary);
        pageModel.setCnt(cnt);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param empNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //确认就业 将状态码由0改为1 标识确认就业
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean comfirmEmp(int empNo) throws MyException {
        if(empNo == 0){
            throw new MyException("就业编号不能为0！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = employMapper.comfirmEmp(empNo);
        return aBoolean;
    }

    /**
     * @param empStuNo
     * @return java.lang.Employ
     * @Author BX
     * @Description //校验是否已经确认就业
     * @Date 13:48 2020/12/5 0005
     * @Param [empNo]
     */
    @Override
    public Employ queryEmpByStuNoState(int empStuNo) throws MyException {
        if(empStuNo == 0){
            throw new MyException("学生学号不能为0！");
        }
        //调用Mapper接口方法
        Employ employ = employMapper.queryEmpByStuNoState(empStuNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(employ)){
            return null;
        }
        return employ;
    }

    /**
     * @Author BX
     * @Description //根据企业编号查询就业信息
     * @Date 13:13 2020/12/11 0011
     * @Param [empComNo]
     * @return com.stu.bean.Employ
     **/
    @Override
    public List<Employ> queryEmpByComNo(int empComNo) throws MyException {
        if(empComNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        List<Employ> list = employMapper.queryEmpByComNo(empComNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(list)){
            return null;
        }
        return list;
    }

    /**
     * @Author BX
     * @Description //根据学号查询就业信息
     * @Date 13:13 2020/12/11 0011
     * @Param [empComNo]
     * @return com.stu.bean.Employ
     **/
    @Override
    public List<Employ> queryEmpByStuNo(int empStuNo) throws MyException {
        if(empStuNo == 0){
            throw new MyException("学号不能为0！");
        }
        //调用Mapper接口方法
        List<Employ> list = employMapper.queryEmpByStuNo(empStuNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(list)){
            return null;
        }
        return list;
    }

}
