package com.stu.service;

import com.stu.bean.Advertise;
import com.stu.exception.MyException;
import com.stu.util.PageModel;

import java.util.List;

/**
 * @ClassName AdvertiseService
 * @Description 招聘信息Service
 * @Author Administrator
 * @Date 2020/12/7 0007 21:46
 * @Version 1.0
 **/
public interface AdvertiseService {

    /**
     * @Author BX
     * @Description //添加招聘信息
     * @Date 22:37 2020/12/8 0008
     * @Param [advertise]
     * @return Boolean
     **/
    Boolean addAdvertise(Advertise advertise) throws MyException;

    /**
     * @Author BX
     * @Description //根据企业编号修改招聘信息
     * @Date 14:16 2020/12/11 0011
     * @Param [String]
     * @return Boolean  adverNo,adverComName,adverComPhone,adverComAddress,adverPosition,adverCount,adverSalary,adverLocation,adverRequire
     **/
    Boolean updateAdvertise(int adverNo,String adverComName, String adverComPhone, String adverComAddress,String adverPosition, long adverCount, long adverSalary, String adverLocation, String adverRequire) throws MyException;

    /**
     * @Author BX
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 13:13 2020/12/11 0011
     * @Param [adverComNo]
     * @return com.stu.bean.Advertise
     **/
    List<Advertise> queryAdverByComNo(int adverComNo) throws MyException;

    /**
     * @Author BX
     * @Description //前端页面删除招聘信息
     * @Date 13:48 2020/12/5 0005
     * @Param [adverComNo]
     * @return java.lang.Boolean
     **/
    Boolean delAdver(int adverNo) throws MyException;

    /**
     * @Author BX
     * @Description //分页查询所有招聘信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return Advertise
     **/
    PageModel<Advertise> queryAdverByPage(int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //根据三个条件动态分页查询企业招聘信息
     * @Date 14:56 2020/12/21 0021
     * @Param [adverComNo, adverComName, adverLocation]
     * @return java.util.List<com.stu.bean.Advertise>
     **/
    PageModel<Advertise> queryAdverByThreeCon(String adverComNo,String adverComName,String adverLocation,int pageNo,int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //根据企业编号查询招聘信息 用于显示企业招聘详细信息 前端表格展示
     * @Date 11:42 2020/12/5 0005
     * @Param [comNo]
     * @return com.stu.bean.Advertise
     **/
    List<Advertise> queryAdverInfo(int comNo) throws MyException;

    /**
     * @param
     * @return void
     * @Author BX
     * @Description //修改招聘人数
     * @Date 14:16 2020/12/11 0011
     * @Param [string]
     */
    void updateAdverCount(int adverComNo,long adverCount) throws MyException;

    /**
     * @Author BX
     * @Description //就业推荐
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return Advertise
     **/
    PageModel<Advertise> queryAdverByPageAdvise(String interPosition,String stuAddress,int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //企业模块-分页展示所有招聘信息 分页查询所有招聘信息
     * @Date 16:06 2020/12/12 0012
     * @Param
     * @return Advertise
     **/
    PageModel<Advertise> queryAdverByPageNew(int adverComNo,int pageNo, int pageSize) throws MyException;

    /**
     * @param pageNo
     * @param pageSize
     * @return
     * @Author BX
     * @Description //企业模块-根据三个条件查询
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    PageModel<Advertise> queryAdverByThreeConNew(int adverComNo, String adverPosition, String adverLocation, int startSalary, int endSalary, int pageNo, int pageSize) throws MyException;

    /**
     * @Author BX
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 13:13 2020/12/11 0011
     * @Param [adverComNo]
     * @return com.stu.bean.Advertise
     **/
    Advertise updateAdverBefore(int adverNo) throws MyException;

}
