package com.stu.bean;

import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Constant
 * @Description 求职信息实体类
 * @Author BX
 * @Date 2020/12/7 0007 19:43
 * @Version 1.0
 **/

@Component(value = "interview")
public class Interview implements Serializable {

  //求职信息编号(主键)(自增长)
  private int interNo;
  //学生学号
  private int interStuNo;
  //企业编号
  private String interComNo;
  //学生姓名
  private String interName;
  //性别
  private String interSex;
  //年龄
  private long interAge;
  //专业
  private String interSpecialty;
  //学校
  private String interSchool;
  //学历
  private String interDegree;
  //学生电话
  private String interPhone;
  //求职职位
  private String interPosition;
  //期望薪资
  private long interSalary;
  //意向工作地
  private String interLocation;
  //意向工作地
  private Date interDate;

  /**
   * @Author BX
   * @Description 无参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Interview() {
  }

  /**
   * @Author BX
   * @Description 有参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Interview(int interNo, int interStuNo,String interComNo, String interName, String interSex, long interAge, String interSpecialty, String interSchool, String interDegree, String interPhone, String interPosition, long interSalary, String interLocation,Date interDate) {
    this.interNo = interNo;
    this.interStuNo = interStuNo;
    this.interName = interName;
    this.interSex = interSex;
    this.interAge = interAge;
    this.interSpecialty = interSpecialty;
    this.interSchool = interSchool;
    this.interDegree = interDegree;
    this.interPhone = interPhone;
    this.interPosition = interPosition;
    this.interSalary = interSalary;
    this.interLocation = interLocation;
    this.interDate = interDate;
    this.interComNo = interComNo;
  }

  public int getInterNo() {
    return interNo;
  }

  public void setInterNo(int interNo) {
    this.interNo = interNo;
  }


  public int getInterStuNo() {
    return interStuNo;
  }

  public void setInterStuNo(int interStuNo) {
    this.interStuNo = interStuNo;
  }


  public String getInterName() {
    return interName;
  }

  public void setInterName(String interName) {
    this.interName = interName;
  }


  public String getInterSex() {
    return interSex;
  }

  public void setInterSex(String interSex) {
    this.interSex = interSex;
  }


  public long getInterAge() {
    return interAge;
  }

  public void setInterAge(long interAge) {
    this.interAge = interAge;
  }


  public String getInterSpecialty() {
    return interSpecialty;
  }

  public void setInterSpecialty(String interSpecialty) {
    this.interSpecialty = interSpecialty;
  }


  public String getInterSchool() {
    return interSchool;
  }

  public void setInterSchool(String interSchool) {
    this.interSchool = interSchool;
  }


  public String getInterDegree() {
    return interDegree;
  }

  public void setInterDegree(String interDegree) {
    this.interDegree = interDegree;
  }


  public String getInterPhone() {
    return interPhone;
  }

  public void setInterPhone(String interPhone) {
    this.interPhone = interPhone;
  }


  public String getInterPosition() {
    return interPosition;
  }

  public void setInterPosition(String interPosition) {
    this.interPosition = interPosition;
  }


  public long getInterSalary() {
    return interSalary;
  }

  public void setInterSalary(long interSalary) {
    this.interSalary = interSalary;
  }


  public String getInterLocation() {
    return interLocation;
  }

  public void setInterLocation(String interLocation) {
    this.interLocation = interLocation;
  }

  public Date getInterDate() {
    return interDate;
  }

  public void setInterDate(Date interDate) {
    this.interDate = interDate;
  }

  public String getInterComNo() {
    return interComNo;
  }

  public void setInterComNo(String interComNo) {
    this.interComNo = interComNo;
  }

  @Override
  public String toString() {
    return "Interview{" +
            "interNo=" + interNo +
            ", interStuNo=" + interStuNo +
            ", interComNo=" + interComNo +
            ", interName='" + interName + '\'' +
            ", interSex='" + interSex + '\'' +
            ", interAge=" + interAge +
            ", interSpecialty='" + interSpecialty + '\'' +
            ", interSchool='" + interSchool + '\'' +
            ", interDegree='" + interDegree + '\'' +
            ", interPhone='" + interPhone + '\'' +
            ", interPosition='" + interPosition + '\'' +
            ", interSalary=" + interSalary +
            ", interLocation='" + interLocation + '\'' +
            ", interDate=" + interDate +
            '}';
  }

}
