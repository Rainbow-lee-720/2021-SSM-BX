package com.stu.bean;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @ClassName Constant
 * @Description 学生实体类
 * @Author BX
 * @Date 2020/12/7 0007 19:43
 * @Version 1.0
 **/

@Component(value = "student")
public class Student implements Serializable {

  //学号(主键)
  private int stuNo;
  //用户名
  private String stuId;
  //密码
  private String stuPwd;
  //学生姓名
  private String stuName;
  //年龄
  private long stuAge;
  //性别
  private String stuSex;
  //学校
  private String stuSchool;
  //专业
  private String stuSpecialty;
  //电话
  private String stuPhone;
  //学生地址
  private String stuAddress;
  //学历
  private String stuDegree;
  //学生权限(1)
  private String stuPower;

  /**
   * @Author BX
   * @Description 无参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Student() {
  }

  /**
   * @Author BX
   * @Description 有参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Student(int stuNo, String stuId, String stuPwd, String stuName, long stuAge, String stuSex, String stuSchool, String stuSpecialty, String stuPhone, String stuAddress, String stuDegree, String stuPower) {
    this.stuNo = stuNo;
    this.stuId = stuId;
    this.stuPwd = stuPwd;
    this.stuName = stuName;
    this.stuAge = stuAge;
    this.stuSex = stuSex;
    this.stuSchool = stuSchool;
    this.stuSpecialty = stuSpecialty;
    this.stuPhone = stuPhone;
    this.stuAddress = stuAddress;
    this.stuDegree = stuDegree;
    this.stuPower = stuPower;
  }

  public int getStuNo() {
    return stuNo;
  }

  public void setStuNo(int stuNo) {
    this.stuNo = stuNo;
  }

  public String getStuId() {
    return stuId;
  }

  public void setStuId(String stuId) {
    this.stuId = stuId;
  }

  public String getStuPwd() {
    return stuPwd;
  }

  public void setStuPwd(String stuPwd) {
    this.stuPwd = stuPwd;
  }


  public String getStuName() {
    return stuName;
  }

  public void setStuName(String stuName) {
    this.stuName = stuName;
  }


  public long getStuAge() {
    return stuAge;
  }

  public void setStuAge(long stuAge) {
    this.stuAge = stuAge;
  }


  public String getStuSex() {
    return stuSex;
  }

  public void setStuSex(String stuSex) {
    this.stuSex = stuSex;
  }


  public String getStuSchool() {
    return stuSchool;
  }

  public void setStuSchool(String stuSchool) {
    this.stuSchool = stuSchool;
  }


  public String getStuSpecialty() {
    return stuSpecialty;
  }

  public void setStuSpecialty(String stuSpecialty) {
    this.stuSpecialty = stuSpecialty;
  }


  public String getStuPhone() {
    return stuPhone;
  }

  public void setStuPhone(String stuPhone) {
    this.stuPhone = stuPhone;
  }


  public String getStuAddress() {
    return stuAddress;
  }

  public void setStuAddress(String stuAddress) {
    this.stuAddress = stuAddress;
  }


  public String getStuDegree() {
    return stuDegree;
  }

  public void setStuDegree(String stuDegree) {
    this.stuDegree = stuDegree;
  }


  public String getStuPower() {
    return stuPower;
  }

  public void setStuPower(String stuPower) {
    this.stuPower = stuPower;
  }

  @Override
  public String toString() {
    return "Student{" +
            "stuNo=" + stuNo +
            ", stuId='" + stuId + '\'' +
            ", stuPwd='" + stuPwd + '\'' +
            ", stuName='" + stuName + '\'' +
            ", stuAge=" + stuAge +
            ", stuSex='" + stuSex + '\'' +
            ", stuSchool='" + stuSchool + '\'' +
            ", stuSpecialty='" + stuSpecialty + '\'' +
            ", stuPhone='" + stuPhone + '\'' +
            ", stuAddress='" + stuAddress + '\'' +
            ", stuDegree='" + stuDegree + '\'' +
            ", stuPower='" + stuPower + '\'' +
            '}';
  }
}
