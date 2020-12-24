package com.stu.bean;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @ClassName Constant
 * @Description 企业实体类
 * @Author BX
 * @Date 2020/12/7 0007 19:43
 * @Version 1.0
 **/

@Component(value = "company")
public class Company implements Serializable {

  //公司编号(主键)
  private int comNo;
  //公司用户名
  private String comId;
  //公司登录密码
  private String comPwd;
  //公司名称
  private String comName;
  //公司电话
  private String comPhone;
  //公司地址
  private String comAddress;
  //公司
  private String comKind;
  //公司规模
  private long comNum;
  //公司类型
  private String comType;
  //公司简介
  private String comBack;
  //公司权限(2)
  private String comPower;

  /**
   * @Author Lee
   * @Description 无参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Company() {
  }

  /**
   * @Author BX
   * @Description 有参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Company(int comNo,String comId, String comPwd, String comName, String comPhone, String comAddress, String comKind, long comNum, String comType, String comBack, String comPower) {
    this.comNo = comNo;
    this.comId = comId;
    this.comPwd = comPwd;
    this.comName = comName;
    this.comPhone = comPhone;
    this.comAddress = comAddress;
    this.comKind = comKind;
    this.comNum = comNum;
    this.comType = comType;
    this.comBack = comBack;
    this.comPower = comPower;
  }

  public int getComNo() {
    return comNo;
  }

  public void setComNo(int comNo) {
    this.comNo = comNo;
  }

  public String getComId() {
    return comId;
  }

  public void setComId(String comId) {
    this.comId = comId;
  }

  public String getComPwd() {
    return comPwd;
  }

  public void setComPwd(String comPwd) {
    this.comPwd = comPwd;
  }


  public String getComName() {
    return comName;
  }

  public void setComName(String comName) {
    this.comName = comName;
  }


  public String getComPhone() {
    return comPhone;
  }

  public void setComPhone(String comPhone) {
    this.comPhone = comPhone;
  }


  public String getComAddress() {
    return comAddress;
  }

  public void setComAddress(String comAddress) {
    this.comAddress = comAddress;
  }


  public String getComKind() {
    return comKind;
  }

  public void setComKind(String comKind) {
    this.comKind = comKind;
  }


  public long getComNum() {
    return comNum;
  }

  public void setComNum(long comNum) {
    this.comNum = comNum;
  }


  public String getComType() {
    return comType;
  }

  public void setComType(String comType) {
    this.comType = comType;
  }


  public String getComBack() {
    return comBack;
  }

  public void setComBack(String comBack) {
    this.comBack = comBack;
  }


  public String getComPower() {
    return comPower;
  }

  public void setComPower(String comPower) {
    this.comPower = comPower;
  }

  @Override
  public String toString() {
    return "Company{" +
            "comNo=" + comNo +
            ", comId='" + comId + '\'' +
            ", comPwd='" + comPwd + '\'' +
            ", comName='" + comName + '\'' +
            ", comPhone='" + comPhone + '\'' +
            ", comAddress='" + comAddress + '\'' +
            ", comKind='" + comKind + '\'' +
            ", comNum=" + comNum +
            ", comType='" + comType + '\'' +
            ", comBack='" + comBack + '\'' +
            ", comPower='" + comPower + '\'' +
            '}';
  }
}
