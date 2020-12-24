package com.stu.mapper;

import com.stu.bean.Interview;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @ClassName InterviewMapper
 * @Description 求职信息Mapper
 * @Author BX
 * @Date 2020/12/8 0008 22:36
 * @Version 1.0
 **/

@Repository(value = "interviewMapper")
public interface InterviewMapper {

    /**
     * @Author BX
     * @Description //添加求职信息
     * @Date 22:37 2020/12/8 0008
     * @Param [interview]
     * @return Boolean
     **/
    Boolean addInterview(Interview interview);

    /**
     * @Author BX
     * @Description //修改求职信息
     * @Date 14:16 2020/122/11 0011
     * @Param [interview]
     * @return Boolean
     **/
    Boolean updateInterview(Interview interview);

    /**
     * @Author BX
     * @Description //求职信息 回显当前登录的学生求职信息 并在页面中进行求职信息修改
     * @Date 18:57 2020/12/10 0010
     * @Param [interStuNo]
     * @return List
     **/
    List<Interview> queryInterByStuNo(@Param("interStuNo") int interStuNo);

    /**
     * @Author BX
     * @Description //前端页面删除求职信息
     * @Date 13:48 2020/122/5 0005
     * @Param [interStuNo]
     * @return java.lang.Boolean
     **/
    Boolean delInter(@Param("interStuNo") int interStuNo);

    /**
     * @Author BX
     * @Description //根据学生编号、企业编号模糊查询求职信息 用于校验此企业是否已经被申请过
     * @Date 18:57 2020/12/10 0010
     * @Param [comNo]
     * @return com.stu.bean.Interview
     **/
    Interview queryInterByStuNoComNo(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //求职操作 将申请求职的企业编号修改进interview表中的interComNo中
     * @Date 19:10 2020/122/26 0026
     * @Param [map]
     * @return java.lang.Boolean
     **/
    Boolean findJob(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //分页查询所有求职信息
     * @Date 16:02 2020/12/12 0012
     * @Param [params]
     * @return Interview
     **/
    List<Interview> queryInterByPage(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //查询求职数据条数
     * @Date 16:03 2020/12/12 0012
     * @Param []
     * @return long
     **/
    long queryInterCount(@Param("interComNo") String comNo);

    /**
     * @Author BX
     * @Description //根据四个条件动态查询求职信息
     * @Date 14:53 2020/12/21 0021
     * @Param []
     * @return java.util.List<com.stu.bean.Interview>
     **/
    List<Interview> queryInterByFourCon(Map<String, Object> params);

    /**
     * @Author BX
     * @Description //根据四个条件动态所有条数
     * @Date 16:49 2020/12/21 0021
     * @Param [interSex,interDegree,interLocation,startSalary,endSalary]
     * @return long
     **/
    long queryCntByFourCon(@Param("comNo") String comNo,@Param("interSex") String interSex, @Param("interDegree") String interDegree, @Param("interLocation") String interLocation, @Param("startSalary") int startSalary, @Param("endSalary") int endSalary);

    /**
     * @Author BX
     * @Description //根据学号、企业编号查询学生求职信息
     * @Date 18:57 2020/12/10 0010
     * @Param [stuNo,comNo]
     * @return com.stu.bean.Interview
     **/
    Interview queryInterInfo(@Param("interStuNo") int stuNo,@Param("interComNo") int comNo);

}
