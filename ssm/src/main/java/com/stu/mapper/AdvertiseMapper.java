package com.stu.mapper;

import com.stu.bean.Advertise;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @ClassName AdvertiseMapper
 * @Description 招聘信息Mapper
 * @Author BX
 * @Date 2020/12/8 0008 22:36
 * @Version 1.0
 **/

@Repository(value = "advertiseMapper")
public interface AdvertiseMapper {

    /**
     * @Author BX
     * @Description //添加招聘信息
     * @Date 22:37 2020/12/8 0008
     * @Param [advertise]
     * @return Boolean
     **/
    Boolean addAdvertise(Advertise advertise);

    /**
     * @Author BX
     * @Description //根据企业编号查询招聘信息
     * @Date 18:57 2020/12/10 0010
     * @Param [adverComNo]
     * @return com.stu.bean.Advertise
     **/
    List<Advertise> queryAdverByNo(@Param("adverComNo") int adverComNo);

    /**
     * @Author BX
     * @Description //根据招聘编号修改招聘信息
     * @Date 14:16 2020/12/11 0011
     * @Param [advertise]
     * @return Boolean
     **/
    Boolean updateAdvertise(Advertise advertise);

    /**
     * @Author BX
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 18:57 2020/12/10 0010
     * @Param [adverComNo]
     * @return List
     **/
    List<Advertise> queryAdverByComNo(@Param("adverComNo") int adverComNo);

    /**
     * @Author BX
     * @Description //前端页面删除招聘信息
     * @Date 13:48 2020/12/5 0005
     * @Param [adverComNo]
     * @return java.lang.Boolean
     **/
    Boolean delAdver(@Param("adverNo") int adverNo);

    /**
     * @Author BX
     * @Description //分页查询所有招聘信息
     * @Date 16:02 2020/12/12 0012
     * @Param [params]
     * @return Advertise
     **/
    List<Advertise> queryAdverByPage(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //查询招聘数据条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return int
     **/
    long queryAdverCount();

    /**
     * @Author BX
     * @Description //根据三个条件动态分页查询企业招聘信息
     * @Date 14:53 2020/12/21 0021
     * @Param []
     * @return java.util.List<com.stu.bean.Advertise>
     **/
    List<Advertise> queryAdverByThreeCon(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //根据三个条件动态所有条数
     * @Date 16:49 2020/12/21 0021
     * @Param [adverComNo, adverComName, adverLocation]
     * @return long
     **/
    long queryCntByThreeCon(@Param("adverComNo") String adverComNo, @Param("adverComName") String adverComName, @Param("adverLocation") String adverLocation);

    /**
     * @param
     * @return void
     * @Author BX
     * @Description //修改招聘人数
     * @Date 14:16 2020/12/11 0011
     * @Param [string]
     */
    void updateAdverCount(Advertise advertise);

    /**
     * @Author BX
     * @Description //就业推荐
     * @Date 16:02 2020/12/12 0012
     * @Param [params]
     * @return Advertise
     **/
    List<Advertise> queryAdverByPageAdvise(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //就业推荐条数
     * @Date 16:49 2020/12/21 0021
     * @Param [interPosition, stuAddress]
     * @return long
     **/
    long queryAdverAdviseCount(@Param("interPosition") String interPosition, @Param("stuAddress") String stuAddress);

    /**
     * @Author BX
     * @Description //企业模块-分页展示所有招聘信息
     * @Date 16:02 2020/12/12 0012
     * @Param [params]
     * @return Advertise
     **/
    List<Advertise> queryAdverByPageNew(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //企业模块-分页展示所有招聘信息 查询招聘数据条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return int
     **/
    long queryAdverCountNew(@Param("adverComNo") int adverComNo);

    /**
     * @return
     * @Author BX
     * @Description //企业模块-根据三个条件查询
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    List<Advertise> queryAdverByThreeConNew(Map map);

    /**
     * @return
     * @Author BX
     * @Description //企业模块-根据三个条件查询条数
     * @Date 16:06 2020/12/12 0012
     * @Param
     */
    long queryCntByThreeConNew(@Param("adverComNo") int adverComNo, @Param("adverPosition") String adverPosition, @Param("adverLocation") String adverLocation, @Param("startSalary") int startSalary, @Param("endSalary") int endSalary);

    /**
     * @Author BX
     * @Description //招聘信息 回显当前登录的企业招聘信息 并在页面中进行招聘信息修改
     * @Date 18:57 2020/12/10 0010
     * @Param [adverComNo]
     * @return List
     **/
    Advertise updateAdverBefore(@Param("adverNo") int adverNo);

}
