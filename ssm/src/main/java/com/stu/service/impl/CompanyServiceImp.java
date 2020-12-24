package com.stu.service.impl;

import com.stu.bean.Company;
import com.stu.exception.MyException;
import com.stu.mapper.CompanyMapper;
import com.stu.service.CompanyService;
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
 * @ClassName CompanyServiceImp
 * @Description 企业业务逻辑Service层
 * @Author BX
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/

@Service(value = "companyService")
public class CompanyServiceImp implements CompanyService {

    //spring自动注入companyMapper
    @Resource(name = "companyMapper")
    private CompanyMapper companyMapper;

    /**
     * @Author BX
     * @Description //登录校验--根据用户名和密码查询
     * @Date 22:37 2020/12/8 0008
     * @Param [comId, comPwd]
     * @return com.stu.bean.Company
     **/
    @Override
    public Company doLogin(String comId, String comPwd) throws MyException {
        //校验用户名和密码
        if(StringEmpty.stringIsEmpty(comId)){
            throw new MyException("用户名不能为空！");
        }
        if(StringEmpty.stringIsEmpty(comPwd)){
            throw new MyException("密码不能为空！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.doLogin(comId,comPwd);
        return company;
    }

    /**
     * @param company
     * @return Boolean
     * @Author BX
     * @Description //企业注册
     * @Date 22:37 2020/12/8 0008
     * @Param [company]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean comRegist(Company company) throws MyException {
        if(ObjectEmpty.objectIsEmpty(company)){
            throw new MyException("服务器出错！");
        }else if(queryComByNo(company.getComNo())){
            //调用Mapper层方法校验企业编号是否已经注册
            throw new MyException("该企业编号已注册！请重新注册！");
        }else if(queryComById(company.getComId())){
            //调用Mapper层方法校验企业用户名是否已经存在
            throw new MyException("该用户名已存在！请重新注册！");
        }else if(queryComByPhone(company.getComPhone())){
            //调用Mapper层方法校验企业手机号是否已经存在
            throw new MyException("企业手机号已存在！请重新填写！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = companyMapper.comRegist(company);
        return aBoolean;
    }

    /**
     * @param comId
     * @return Boolean
     * @Author BX
     * @Description //根据用户名查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:56 2020/12/10 0010
     * @Param [comId]
     */
    @Override
    public Boolean queryComById(String comId) throws MyException {
        if(StringEmpty.stringIsEmpty(comId)){
            throw new MyException("用户名不能为空！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.queryComById(comId);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(company)){
            return false;
        }
        return true;
    }

    /**
     * @param comId
     * @return Boolean
     * @Author BX
     * @Description //根据用户名查询企业信息--获取对象
     * @Date 18:56 2020/12/10 0010
     * @Param [comId]
     */
    @Override
    public Company queryComByIdCom(String comId) throws MyException {
        if(StringEmpty.stringIsEmpty(comId)){
            throw new MyException("用户名不能为空！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.queryComById(comId);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(company)){
            return company;
        }
        return company;
    }

    /**
     * @param comNo
     * @return Boolean
     * @Author BX
     * @Description //根据企业编号查询企业信息 前端Ajax需要局部校验（登录 注册 service层校验）
     * @Date 18:57 2020/12/10 0010
     * @Param [comNo]
     */
    @Override
    public Boolean queryComByNo(int comNo) throws MyException {
        if(comNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.queryComByNo(comNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(company)){
            return false;
        }
        return true;
    }

    /**
     * @param comPhone
     * @return com.stu.bean.Boolean
     * @Author BX
     * @Description //根据手机号查询企业信息 注册需要用来校验
     * @Date 22:09 2020/12/10 0010
     * @Param [comPhone]
     */
    @Override
    public Boolean queryComByPhone(String comPhone) throws MyException {
        if(StringEmpty.stringIsEmpty(comPhone)){
            throw new MyException("企业手机号不能为空！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.queryComByPhone(comPhone);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(company)){
            return false;
        }
        return true;
    }

    /**
     * @param comNo
     * @return com.stu.bean.Company
     * @Author BX
     * @Description //根据企业编号查询企业信息 用于显示企业详细信息 前端表格展示
     * @Date 11:42 2020/122/5 0005
     * @Param [comNo]
     */
    @Override
    public Company queryComInfo(int comNo) throws MyException {
        if(comNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.queryComByNo(comNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(company)){
            throw new MyException("该企业信息不存在！");
        }
        return company;
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //分页查询企业信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Company> queryComByPage(int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        PageModel<Company> pageModel = new PageModel<Company>();
        //调用Mapper接口方法
        List<Company> dataList = companyMapper.queryComByPage(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        pageModel.setCnt(companyMapper.queryComCount());
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param comNo
     * @param comName
     * @param comAddress
     * @param comType
     * @param comKind
     * @param pageNo
     * @param pageSize
     * @return java.util.List<com.stu.bean.Company>
     * @Author BX
     * @Description //根据五个条件动态分页查询企业信息
     * @Date 14:56 2020/12/21 0021
     * @Param [comNo, comName, comAddress, comType,comKind]
     */
    @Override
    public PageModel<Company> queryComByFiveCon(String comNo, String comName, String comAddress, String comType, String comKind, int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        map.put("comNo", comNo);
        map.put("comName", comName);
        map.put("comAddress", comAddress);
        map.put("comType", comType);
        map.put("comKind", comKind);
        PageModel<Company> pageModel = new PageModel<Company>();
        //调用Mapper接口方法
        List<Company> dataList = companyMapper.queryComByFiveCon(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        long cnt = companyMapper.queryCntByFiveCon(comNo,comName,comAddress,comType,comKind);
        pageModel.setCnt(cnt);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param comNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //前端页面删除企业数据
     * @Date 13:50 2020/122/5 0005
     * @Param [comNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean delCom(int comNo) throws MyException {
        if(comNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = companyMapper.delCom(comNo);
        return aBoolean;
    }

    /**
     * @return java.util.List<java.lang.Company>
     * @Author BX
     * @Description //查询所有企业类型 在企业查询、注册表单中的select下拉框中用到
     * @Date 13:25 2020/122/6 0006
     * @Param []
     **/
    @Override
    public List<Company> queryComTypeAndKind() throws MyException {
        //调用Mapper接口方法
        List<Company> list = companyMapper.queryComTypeAndKind();
        return list;
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
    public Boolean updateComPwd(String newPwd, String oldPwd) {
        //调用Mapper接口方法
        Boolean aBoolean = companyMapper.updateComPwd(newPwd,oldPwd);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param comNo
     * @param comId
     * @param comName
     * @param comPhone
     * @param comAddress
     * @param comKind
     * @param comNum
     * @param comType
     * @param comBack
     * @return Boolean
     * @Author BX
     * @Description //修改企业信息
     * @Date 14:16 2020/122/11 0011
     * @Param [String]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateCom(int comNo, String comId, String comName, String comPhone, String comAddress, String comKind, long comNum, String comType, String comBack) throws MyException {
        //封装参数
        Company company = new Company();
        company.setComNo(comNo);
        company.setComId(comId);
        company.setComName(comName);
        company.setComPhone(comPhone);
        company.setComAddress(comAddress);
        company.setComKind(comKind);
        company.setComNum(comNum);
        company.setComType(comType);
        company.setComBack(comBack);
        //调用Mapper接口方法
        Boolean aBoolean = companyMapper.updateCom(company);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param comNo
     * @return com.stu.bean.Company
     * @Author BX
     * @Description //企业中心 回显当前登录的企业信息 并在页面中进行企业信息修改
     * @Date 13:13 2020/122/11 0011
     * @Param [comNo]
     */
    @Override
    public Company queryComByNoCenter(int comNo) throws MyException {
        if(comNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        Company company = companyMapper.queryComByNo(comNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(company)){
            return null;
        }
        return company;
    }

    /**
     * @param comNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //账号注销
     * @Date 10:49 2020/122/19 0019
     * @Param [comNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean logOutCom(int comNo) throws MyException {
        //调用Mapper接口方法
        Boolean aBoolean = companyMapper.logOutCom(comNo);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

}
