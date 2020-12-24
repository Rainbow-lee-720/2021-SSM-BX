package com.stu.util;

import com.stu.bean.*;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * @ClassName SubmitData
 * @Description 前端传送到后端的参数封装工具类
 * @Author BX
 * @Date 2020/12/7 0007 22:22
 * @Version 1.0
 **/
@SuppressWarnings("serial")
public class SubmitData implements Serializable {

    //封装前端传送的数据 键值对形式封装
    private LinkedHashMap<String,Object> entityData;

    //List集合类型封装
    private List<Object> refData;

    //Student学生对象
    private Student student;

    //Company公司对象
    private Company company;

    //Admin管理员对象
    private Admin admin;

    //Interview求职信息对象
    private Interview interview;

    //Advertise招聘信息对象
    private Advertise advertise;

    //Employ就业信息对象
    private Employ employ;

    //用户名
    private String username;

    //原密码
    private String oldPwd;

    //备用参数
    private Object args;


    /**
     * @Author Lee
     * @Description //无参构造
     * @Date 22:19 2020/1/7 0007
     * @Param []
     * @return
     **/
    public SubmitData() {
    }

    /**
     * @Author Lee
     * @Description //有参构造
     * @Date 22:19 2020/1/7 0007
     * @Param []
     * @return
     **/
    public SubmitData(LinkedHashMap<String, Object> entityData, List<Object> refData, Student student, Company company, Admin admin) {
        this.entityData = entityData;
        this.refData = refData;
        this.student = student;
        this.company = company;
        this.admin = admin;
    }

    public LinkedHashMap<String, Object> getEntityData() {
        return entityData;
    }

    public void setEntityData(LinkedHashMap<String, Object> entityData) {
        this.entityData = entityData;
    }

    public List<Object> getRefData() {
        return refData;
    }

    public void setRefData(List<Object> refData) {
        this.refData = refData;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public String getOldPwd() {
        return oldPwd;
    }

    public void setOldPwd(String oldPwd) {
        this.oldPwd = oldPwd;
    }

    public Object getArgs() {
        return args;
    }

    public void setArgs(Object args) {
        this.args = args;
    }

    public Interview getInterview() {
        return interview;
    }

    public void setInterview(Interview interview) {
        this.interview = interview;
    }

    public Advertise getAdvertise() {
        return advertise;
    }

    public void setAdvertise(Advertise advertise) {
        this.advertise = advertise;
    }

    public Employ getEmploy() {
        return employ;
    }

    public void setEmploy(Employ employ) {
        this.employ = employ;
    }

    @Override
    public String toString() {
        return "SubmitData{" +
                "entityData=" + entityData +
                ", refData=" + refData +
                ", student=" + student +
                ", company=" + company +
                ", admin=" + admin +
                ", interview=" + interview +
                ", advertise=" + advertise +
                ", employ=" + employ +
                ", username='" + username + '\'' +
                ", oldPwd='" + oldPwd + '\'' +
                ", args=" + args +
                '}';
    }
}
