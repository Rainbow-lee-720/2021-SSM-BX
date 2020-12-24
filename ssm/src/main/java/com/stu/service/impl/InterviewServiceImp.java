package com.stu.service.impl;

import com.stu.bean.Employ;
import com.stu.bean.Interview;
import com.stu.exception.MyException;
import com.stu.mapper.EmployMapper;
import com.stu.mapper.InterviewMapper;
import com.stu.service.InterviewService;
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
 * @ClassName InterviewServiceImp
 * @Description 求职信息业务逻辑Service层
 * @Author Administrator
 * @Date 2020/122/7 0007 21:48
 * @Version 1.0
 **/

@Service(value = "interviewService")
public class InterviewServiceImp implements InterviewService {

    //spring自动注入interviewMapper
    @Resource(name = "interviewMapper")
    private InterviewMapper interviewMapper;
    @Resource(name = "employMapper")
    private EmployMapper employMapper;

    /**
     * @param interview
     * @return boolean
     * @Author BX
     * @Description //添加求职信息
     * @Date 22:37 2020/122/8 0008
     * @Param [interview]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean addInterview(Interview interview) throws MyException {
        if(ObjectEmpty.objectIsEmpty(interview)){
            throw new MyException("服务器出错！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = interviewMapper.addInterview(interview);
        return aBoolean;
    }

    /**
     * @param
     * @return java.lang.Boolean
     * @Author BX
     * @Description //修改求职信息
     * @Date 14:16 2020/1222/11 0011
     * @Param [string]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateInterview(int interStuNo, String interName, String interSex, long interAge, String interSpecialty, String interSchool, String interDegree, String interPhone, String interPosition,long interSalary, String interLocation) throws MyException {
        //封装参数
        Interview interview = new Interview();
        interview.setInterStuNo(interStuNo);
        interview.setInterName(interName);
        interview.setInterSex(interSex);
        interview.setInterAge(interAge);
        interview.setInterSpecialty(interSpecialty);
        interview.setInterSchool(interSchool);
        interview.setInterDegree(interDegree);
        interview.setInterPhone(interPhone);
        interview.setInterPosition(interPosition);
        interview.setInterSalary(interSalary);
        interview.setInterLocation(interLocation);
        //调用Mapper接口方法
        Boolean aBoolean = interviewMapper.updateInterview(interview);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param interStuNo
     * @return List
     * @Author BX
     * @Description //求职信息 回显当前登录的学生求职信息 并在页面中进行求职信息修改
     * @Date 13:13 2020/1222/11 0011
     * @Param [interStuNo]
     */
    @Override
    public List<Interview> queryInterByStuNo(int interStuNo) throws MyException {
        if(interStuNo == 0){
            throw new MyException("学生学号不能为0！");
        }
        //调用Mapper接口方法
        List<Interview> list = interviewMapper.queryInterByStuNo(interStuNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(list)){
            return null;
        }
        return list;
    }

    /**
     * @param interStuNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //前端页面删除求职信息
     * @Date 13:48 2020/1222/5 0005
     * @Param [interStuNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean delInter(int interStuNo) throws MyException {
        if(interStuNo == 0){
            throw new MyException("学号不能为0！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = interviewMapper.delInter(interStuNo);
        return aBoolean;
    }

    /**
     * @param interStuNo
     * @param interComNo
     * @return com.stu.bean.Interview
     * @Author BX
     * @Description //根据学生编号、企业编号模糊查询求职信息 用于校验此企业是否已经被申请过
     * @Date 18:57 2020/122/10 0010
     * @Param [comNo]
     */
    @Override
    public Interview queryInterByStuNoComNo(int interStuNo, String interComNo) throws MyException {
        if(interStuNo == 0){
            throw new MyException("学号不能为0！");
        }else if(interComNo == null){
            throw new MyException("企业编号不能为空！");
        }
        //调用Mapper接口方法
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("interStuNo",interStuNo);
        map.put("interComNo",interComNo);
        Interview interview = interviewMapper.queryInterByStuNoComNo(map);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(interview)){
            return null;
        }
        return interview;
    }

    /**
     * @param interStuNo
     * @param interComNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //求职操作 将申请求职的企业编号修改进interview表中的interComNo中
     * @Date 19:10 2020/1222/26 0026
     * @Param [interStuNo, interComNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean findJob(int interStuNo, String interComNo) throws MyException {
        if(interStuNo == 0){
            throw new MyException("学号不能为0！");
        }else if(interComNo == null){
            throw new MyException("企业编号不能为空！");
        }
        //调用Mapper接口方法
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("interStuNo",interStuNo);
        map.put("interComNo",interComNo);
        Boolean aBoolean = interviewMapper.findJob(map);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param pageNo
     * @param pageSize
     * @param interComNo
     * @return
     * @Author BX
     * @Description //分页查询所有求职信息
     * @Date 16:06 2020/122/12 0012
     * @Param
     */
    @Override
    public PageModel<Interview> queryInterByPage(String interComNo, int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("interComNo", interComNo);
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        PageModel<Interview> pageModel = new PageModel<Interview>();
        //调用Mapper接口方法
        List<Interview> dataList = interviewMapper.queryInterByPage(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        long count = interviewMapper.queryInterCount(interComNo);
        //调用Mapper接口方法
        pageModel.setCnt(count);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param interSex
     * @param interDegree
     * @param interLocation
     * @param startSalary
     * @return java.util.List<com.stu.bean.Interview>
     * @Author BX
     * @Description //根据四个条件动态查询求职信息
     * @Date 14:56 2020/122/21 0021
     * @Param [interSex,interDegree,interLocation,startSalary,endSalary,pageNo,pageSize]
     */
    @Override
    public PageModel<Interview> queryInterByFourCon(String comNo,String interSex, String interDegree, String interLocation, int startSalary,int endSalary, int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        map.put("comNo", comNo);
        map.put("interSex", interSex);
        map.put("interDegree", interDegree);
        map.put("interLocation", interLocation);
        map.put("startSalary", startSalary);
        map.put("endSalary", endSalary);
        PageModel<Interview> pageModel = new PageModel<Interview>();

        //调用Mapper接口方法
        List<Interview> dataList = interviewMapper.queryInterByFourCon(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        long cnt = interviewMapper.queryCntByFourCon(comNo,interSex,interDegree,interLocation,startSalary,endSalary);
        pageModel.setCnt(cnt);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param comNo
     * @param stuNo
     * @return com.stu.bean.Interview
     * @Author BX
     * @Description //根据学号、企业编号查询学生求职信息 用于显示学生求职详细信息 前端模态框展示
     * @Date 11:42 2020/1222/5 0005
     * @Param [stuNo,comNo]
     */
    @Override
    public Interview queryInterInfo(int stuNo,int comNo) throws MyException {
        if(comNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        Interview interview = interviewMapper.queryInterInfo(stuNo,comNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(interview)){
            throw new MyException("该学生求职信息不存在！");
        }
        return interview;
    }

    /**
     * @return boolean
     * @Author BX
     * @Description //添加就业信息
     * @Date 22:37 2020/122/8 0008
     * @Param [employ]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean addEmploy(Employ employ) throws MyException {
        if(ObjectEmpty.objectIsEmpty(employ)){
            throw new MyException("服务器出错！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = employMapper.addEmploy(employ);
        return aBoolean;
    }

}
