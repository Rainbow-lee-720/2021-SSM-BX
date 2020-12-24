package com.stu.service.impl;

import com.stu.bean.Advertise;
import com.stu.exception.MyException;
import com.stu.mapper.AdvertiseMapper;
import com.stu.service.AdvertiseService;
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
 * @ClassName AdvertiseServiceImp
 * @Description 招聘信息业务逻辑Service层
 * @Author Administrator
 * @Date 2020/12/7 0007 21:48
 * @Version 1.0
 **/

@Service(value = "advertiseService")
public class AdvertiseServiceImp implements AdvertiseService {

    //spring自动注入advertiseMapper
    @Resource(name = "advertiseMapper")
    private AdvertiseMapper advertiseMapper;

    /**
     * @return boolean
     * @Author BX
     * @Description //添加招聘信息
     * @Date 22:37 2020/12/8 0008
     * @Param [advertise]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean addAdvertise(Advertise advertise) throws MyException {
        if(ObjectEmpty.objectIsEmpty(advertise)){
            throw new MyException("服务器出错！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = advertiseMapper.addAdvertise(advertise);
        return aBoolean;
    }

    /**
     * @param
     * @return java.lang.Boolean
     * @Author BX
     * @Description //根据企业编号修改招聘信息
     * @Date 14:16 2020/12/11 0011
     * @Param [string]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean updateAdvertise(int adverNo,String adverComName, String adverComPhone, String adverComAddress,String adverPosition, long adverCount, long adverSalary, String adverLocation, String adverRequire) throws MyException {
        //封装参数
        Advertise advertise = new Advertise();
        advertise.setAdverNo(adverNo);
        advertise.setAdverComName(adverComName);
        advertise.setAdverComPhone(adverComPhone);
        advertise.setAdverComAddress(adverComAddress);
        advertise.setAdverPosition(adverPosition);
        advertise.setAdverCount(adverCount);
        advertise.setAdverSalary(adverSalary);
        advertise.setAdverLocation(adverLocation);
        advertise.setAdverRequire(adverRequire);
        //调用Mapper接口方法
        Boolean aBoolean = advertiseMapper.updateAdvertise(advertise);
        if(aBoolean){
            return true;
        }else{
            return  false;
        }
    }

    /**
     * @param adverComNo
     * @return List
     * @Author BX
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 13:13 2020/12/11 0011
     * @Param [adverComNo]
     */
    @Override
    public List<Advertise> queryAdverByComNo(int adverComNo) throws MyException {
        if(adverComNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        List<Advertise> list = advertiseMapper.queryAdverByComNo(adverComNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(list)){
            return null;
        }
        return list;
    }

    /**
     * @param adverNo
     * @return java.lang.Boolean
     * @Author BX
     * @Description //前端页面删除招聘信息
     * @Date 13:48 2020/12/5 0005
     * @Param [adverComNo]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public Boolean delAdver(int adverNo) throws MyException {
        if(adverNo == 0){
            throw new MyException("招聘信息编号不能为0！");
        }
        //调用Mapper接口方法
        Boolean aBoolean = advertiseMapper.delAdver(adverNo);
        return aBoolean;
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //分页查询所有招聘信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Advertise> queryAdverByPage(int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        PageModel<Advertise> pageModel = new PageModel<Advertise>();
        //调用Mapper接口方法
        List<Advertise> dataList = advertiseMapper.queryAdverByPage(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        pageModel.setCnt(advertiseMapper.queryAdverCount());
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param adverComNo
     * @param adverComName
     * @param adverLocation
     * @param pageNo
     * @param pageSize
     * @return java.util.List<com.stu.bean.Advertise>
     * @Author BX
     * @Description //根据三个条件动态分页查询企业招聘信息
     * @Date 14:56 2020/12/21 0021
     * @Param [adverComNo, adverComName, adverLocation]
     */
    @Override
    public PageModel<Advertise> queryAdverByThreeCon(String adverComNo,String adverComName,String adverLocation, int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        map.put("adverComNo", adverComNo);
        map.put("adverComName", adverComName);
        map.put("adverLocation", adverLocation);
        PageModel<Advertise> pageModel = new PageModel<Advertise>();
        //调用Mapper接口方法
        List<Advertise> dataList = advertiseMapper.queryAdverByThreeCon(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        long cnt = advertiseMapper.queryCntByThreeCon(adverComNo,adverComName,adverLocation);
        pageModel.setCnt(cnt);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param comNo
     * @return com.stu.bean.Advertise
     * @Author BX
     * @Description //根据企业编号查询招聘信息 用于显示企业招聘详细信息 前端表格展示
     * @Date 11:42 2020/12/5 0005
     * @Param [comNo]
     */
    @Override
    public List<Advertise> queryAdverInfo(int comNo) throws MyException {
        if(comNo == 0){
            throw new MyException("企业编号不能为0！");
        }
        //调用Mapper接口方法
        List<Advertise> list = advertiseMapper.queryAdverByNo(comNo);
        //判断查询结果是否存在
        if(StringEmpty.stringIsEmpty(list)){
            throw new MyException("该招聘信息不存在！");
        }
        return list;
    }

    /**
     * @param
     * @return void
     * @Author BX
     * @Description //修改招聘人数
     * @Date 14:16 2020/12/11 0011
     * @Param [string]
     */
    @Override
    @Transactional(rollbackFor = Exception.class,propagation = Propagation.REQUIRED)
    public void updateAdverCount(int adverComNo,long adverCount) throws MyException {
        //封装参数
        Advertise advertise = new Advertise();
        advertise.setAdverComNo(adverComNo);
        advertise.setAdverCount(adverCount);
        //调用Mapper接口方法
        advertiseMapper.updateAdverCount(advertise);
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //就业推荐
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Advertise> queryAdverByPageAdvise(String interPosition,String stuAddress,int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        map.put("interPosition", interPosition);
        map.put("stuAddress", stuAddress);
        PageModel<Advertise> pageModel = new PageModel<Advertise>();
        //调用Mapper接口方法
        List<Advertise> dataList = advertiseMapper.queryAdverByPageAdvise(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        pageModel.setCnt(advertiseMapper.queryAdverAdviseCount(interPosition,stuAddress));
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //企业模块-分页展示所有招聘信息 分页查询所有招聘信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Advertise> queryAdverByPageNew(int adverComNo,int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("adverComNo", adverComNo);
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("pageSize", pageSize);
        PageModel<Advertise> pageModel = new PageModel<Advertise>();
        //调用Mapper接口方法
        List<Advertise> dataList = advertiseMapper.queryAdverByPageNew(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        pageModel.setCnt(advertiseMapper.queryAdverCountNew(adverComNo));
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //企业模块-根据三个条件查询
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    @Override
    public PageModel<Advertise> queryAdverByThreeConNew(int adverComNo, String adverPosition, String adverLocation, int startSalary, int endSalary, int pageNo, int pageSize) throws MyException {
        Map<String, Object> map = new HashMap<String, Object>();
        //封装参数到map中
        map.put("pageNo", (pageNo-1)*pageSize);
        map.put("adverComNo", adverComNo);
        map.put("pageSize", pageSize);
        map.put("adverPosition", adverPosition);
        map.put("adverLocation", adverLocation);
        map.put("startSalary", startSalary);
        map.put("endSalary", endSalary);
        PageModel<Advertise> pageModel = new PageModel<Advertise>();
        //调用Mapper接口方法
        List<Advertise> dataList = advertiseMapper.queryAdverByThreeConNew(map);
        //将查询出来的数据保存在分页模型中
        pageModel.setDataList(dataList);
        //将pageNo pageSize存进pageModel中
        pageModel.setPageNo(pageNo);
        pageModel.setPageSize(pageSize);
        //调用Mapper接口方法
        long cnt = advertiseMapper.queryCntByThreeConNew(adverComNo,adverPosition,adverLocation,startSalary,endSalary);
        pageModel.setCnt(cnt);
        //pagemodel变量中有pageNo、pageSize、cnt、dataList值
        return pageModel;
    }

    /**
     * @param adverNo
     * @return List
     * @Author BX
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 13:13 2020/12/11 0011
     * @Param [adverNo]
     */
    @Override
    public Advertise updateAdverBefore(int adverNo) throws MyException {
        if(adverNo == 0){
            throw new MyException("招聘编号不能为0！");
        }
        //调用Mapper接口方法
        Advertise advertise = advertiseMapper.updateAdverBefore(adverNo);
        return advertise;
    }

}
