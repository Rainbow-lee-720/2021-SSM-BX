package com.stu.bean;

import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Constant
 * @Description 就业信息实体类
 * @Author BX
 * @Date 2020/12/7 0007 19:43
 * @Version 1.0
 **/

@Component(value = "employ")
public class Employ implements Serializable {

  //就业信息编号(主键)(自增长)
  private int empNo;
  //学生学号
  private int empStuNo;
  //企业编号*
  private int empComNo;
  //学生姓名
  private String empName;
  //学生性别
  private String empSex;
  //学生年龄*
  private long empAge;
  //学生电话
  private String empStuPhone;
  //学历
  private String empDegree;
  //学校
  private String empSchool;
  //专业
  private String empSpecialty;
  //公司名称
  private String empComName;
  //职位
  private String empPosition;
  //薪资
  private long empSalary;
  //技能
  private String empLocation;
  //创建时间
  private Date empDate;
  //状态
  private int empState;

  /**
   * @Author BX
   * @Description 无参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Employ() {
  }

  /**
   * @Author BX
   * @Description 有参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Employ(int empNo,int empStuNo,int empComNo,String empName, String empSex,long empAge, String empStuPhone, String empDegree, String empSchool, String empSpecialty, String empComName, String empPosition, long empSalary, String empLocation,Date empDate,int empState) {
    this.empNo = empNo;
    this.empStuNo = empStuNo;
    this.empComNo = empComNo;
    this.empName = empName;
    this.empSex = empSex;
    this.empAge = empAge;
    this.empStuPhone = empStuPhone;
    this.empDegree = empDegree;
    this.empSchool = empSchool;
    this.empSpecialty = empSpecialty;
    this.empComName = empComName;
    this.empPosition = empPosition;
    this.empSalary = empSalary;
    this.empLocation = empLocation;
    this.empDate = empDate;
    this.empState = empState;
  }

  public int getEmpNo() {
    return empNo;
  }

  public void setEmpNo(int empNo) {
    this.empNo = empNo;
  }

  public String getEmpName() {
    return empName;
  }

  public void setEmpName(String empName) {
    this.empName = empName;
  }


  public String getEmpSex() {
    return empSex;
  }

  public void setEmpSex(String empSex) {
    this.empSex = empSex;
  }


  public String getEmpStuPhone() {
    return empStuPhone;
  }

  public void setEmpStuPhone(String empStuPhone) {
    this.empStuPhone = empStuPhone;
  }


  public String getEmpDegree() {
    return empDegree;
  }

  public void setEmpDegree(String empDegree) {
    this.empDegree = empDegree;
  }


  public String getEmpSchool() {
    return empSchool;
  }

  public void setEmpSchool(String empSchool) {
    this.empSchool = empSchool;
  }


  public String getEmpSpecialty() {
    return empSpecialty;
  }

  public void setEmpSpecialty(String empSpecialty) {
    this.empSpecialty = empSpecialty;
  }


  public String getEmpComName() {
    return empComName;
  }

  public void setEmpComName(String empComName) {
    this.empComName = empComName;
  }


  public String getEmpPosition() {
    return empPosition;
  }

  public void setEmpPosition(String empPosition) {
    this.empPosition = empPosition;
  }


  public long getEmpSalary() {
    return empSalary;
  }

  public void setEmpSalary(long empSalary) {
    this.empSalary = empSalary;
  }


  public String getEmpLocation() {
    return empLocation;
  }

  public void setEmpLocation(String empLocation) {
    this.empLocation = empLocation;
  }

  public Date getEmpDate() {
    return empDate;
  }

  public void setEmpDate(Date empDate) {
    this.empDate = empDate;
  }

  public int getEmpStuNo() {
    return empStuNo;
  }

  public void setEmpStuNo(int empStuNo) {
    this.empStuNo = empStuNo;
  }

  public int getEmpComNo() {
    return empComNo;
  }

  public void setEmpComNo(int empComNo) {
    this.empComNo = empComNo;
  }

  public long getEmpAge() {
    return empAge;
  }

  public void setEmpAge(long empAge) {
    this.empAge = empAge;
  }

  public int getEmpState() {
    return empState;
  }

  public void setEmpState(int empState) {
    this.empState = empState;
  }

  @Override
  public String toString() {
    return "Employ{" +
            "empNo=" + empNo +
            ", empStuNo=" + empStuNo +
            ", empComNo=" + empComNo +
            ", empName='" + empName + '\'' +
            ", empSex='" + empSex + '\'' +
            ", empAge=" + empAge +
            ", empStuPhone='" + empStuPhone + '\'' +
            ", empDegree='" + empDegree + '\'' +
            ", empSchool='" + empSchool + '\'' +
            ", empSpecialty='" + empSpecialty + '\'' +
            ", empComName='" + empComName + '\'' +
            ", empPosition='" + empPosition + '\'' +
            ", empSalary=" + empSalary +
            ", empLocation='" + empLocation + '\'' +
            ", empDate=" + empDate +
            ", empState=" + empState +
            '}';
  }

}
