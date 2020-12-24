package com.stu.bean;

import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Constant
 * @Description 招聘信息实体类
 * @Author BX
 * @Date 2020/12/7 0007 19:43
 * @Version 1.0
 **/

@Component(value = "advertise")
public class Advertise implements Serializable {

  //招聘信息编号(主键)(自增长)
  private int adverNo;
  //企业编号(外键)
  private int adverComNo;
  //招聘职位
  private String adverPosition;
  //企业名称
  private String adverComName;
  //招聘电话
  private String adverComPhone;
  //企业地址
  private String adverComAddress;
  //招聘人数
  private long adverCount;
  //薪资待遇
  private long adverSalary;
  //工作地点
  private String adverLocation;
  //招聘要求
  private String adverRequire;
  //创建日期
  private Date adverDate;

  /**
   * @Author BX
   * @Description 无参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Advertise() {
  }

  /**
   * @Author Lee
   * @Description 有参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Advertise(int adverNo, int adverComNo, String adverPosition, String adverComName, String adverComPhone, String adverComAddress, long adverCount, long adverSalary, String adverLocation, String adverRequire, Date adverDate) {
    this.adverNo = adverNo;
    this.adverComNo = adverComNo;
    this.adverPosition = adverPosition;
    this.adverComName = adverComName;
    this.adverComPhone = adverComPhone;
    this.adverComAddress = adverComAddress;
    this.adverCount = adverCount;
    this.adverSalary = adverSalary;
    this.adverLocation = adverLocation;
    this.adverRequire = adverRequire;
    this.adverDate = adverDate;
  }

  public int getAdverNo() {
    return adverNo;
  }

  public void setAdverNo(int adverNo) {
    this.adverNo = adverNo;
  }
  public int getAdverComNo() {
    return adverComNo;
  }

  public void setAdverComNo(int adverComNo) {
    this.adverComNo = adverComNo;
  }


  public String getAdverPosition() {
    return adverPosition;
  }

  public void setAdverPosition(String adverPosition) {
    this.adverPosition = adverPosition;
  }


  public String getAdverComName() {
    return adverComName;
  }

  public void setAdverComName(String adverComName) {
    this.adverComName = adverComName;
  }


  public String getAdverComPhone() {
    return adverComPhone;
  }

  public void setAdverComPhone(String adverComPhone) {
    this.adverComPhone = adverComPhone;
  }


  public String getAdverComAddress() {
    return adverComAddress;
  }

  public void setAdverComAddress(String adverComAddress) {
    this.adverComAddress = adverComAddress;
  }


  public long getAdverCount() {
    return adverCount;
  }

  public void setAdverCount(long adverCount) {
    this.adverCount = adverCount;
  }


  public long getAdverSalary() {
    return adverSalary;
  }

  public void setAdverSalary(long adverSalary) {
    this.adverSalary = adverSalary;
  }


  public String getAdverLocation() {
    return adverLocation;
  }

  public void setAdverLocation(String adverLocation) {
    this.adverLocation = adverLocation;
  }


  public String getAdverRequire() {
    return adverRequire;
  }

  public void setAdverRequire(String adverRequire) {
    this.adverRequire = adverRequire;
  }

  public Date getAdverDate() {
    return adverDate;
  }

  public void setAdverDate(Date adverDate) {
    this.adverDate = adverDate;
  }

  @Override
  public String toString() {
    return "Advertise{" +
            "adverNo=" + adverNo +
            ", adverComNo=" + adverComNo +
            ", adverPosition='" + adverPosition + '\'' +
            ", adverComName='" + adverComName + '\'' +
            ", adverComPhone='" + adverComPhone + '\'' +
            ", adverComAddress='" + adverComAddress + '\'' +
            ", adverCount=" + adverCount +
            ", adverSalary=" + adverSalary +
            ", adverLocation='" + adverLocation + '\'' +
            ", adverRequire='" + adverRequire + '\'' +
            ", adverDate=" + adverDate +
            '}';
  }
}
