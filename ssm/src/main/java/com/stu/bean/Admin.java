package com.stu.bean;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @ClassName Constant
 * @Description 管理员实体类
 * @Author BX
 * @Date 2020/12/7 0007 19:43
 * @Version 1.0
 **/

@Component(value = "admin")
public class Admin implements Serializable {

  //管理员编号(主键)
  private int adminNo;
  //用户名
  private String adminId;
  //密码
  private String adminPwd;
  //管理员姓名
  private String adminName;
  //管理员电话
  private String adminPhone;
  //管理员性别
  private String adminSex;
  //管理员权限(0)
  private String adminPower;

  /**
   * @Author BX
   * @Description 无参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Admin() {

  }

  /**
   * @Author BX
   * @Description 有参构造
   * @Date 20:07 2020/12/7 0007
   * @Param []
   * @return
   **/
  public Admin(int adminNo, String adminId, String adminPwd, String adminName, String adminPhone, String adminSex, String adminPower) {
    this.adminNo = adminNo;
    this.adminId = adminId;
    this.adminPwd = adminPwd;
    this.adminName = adminName;
    this.adminPhone = adminPhone;
    this.adminSex = adminSex;
    this.adminPower = adminPower;
  }

  public String getAdminId() {
    return adminId;
  }

  public void setAdminId(String adminId) {
    this.adminId = adminId;
  }

  public int getAdminNo() {
    return adminNo;
  }

  public void setAdminNo(int adminNo) {
    this.adminNo = adminNo;
  }


  public String getAdminPwd() {
    return adminPwd;
  }

  public void setAdminPwd(String adminPwd) {
    this.adminPwd = adminPwd;
  }


  public String getAdminName() {
    return adminName;
  }

  public void setAdminName(String adminName) {
    this.adminName = adminName;
  }


  public String getAdminPhone() {
    return adminPhone;
  }

  public void setAdminPhone(String adminPhone) {
    this.adminPhone = adminPhone;
  }


  public String getAdminSex() {
    return adminSex;
  }

  public void setAdminSex(String adminSex) {
    this.adminSex = adminSex;
  }


  public String getAdminPower() {
    return adminPower;
  }

  public void setAdminPower(String adminPower) {
    this.adminPower = adminPower;
  }

  @Override
  public String toString() {
    return "Admin{" +
            "adminNo=" + adminNo +
            ", adminId='" + adminId + '\'' +
            ", adminPwd='" + adminPwd + '\'' +
            ", adminName='" + adminName + '\'' +
            ", adminPhone='" + adminPhone + '\'' +
            ", adminSex='" + adminSex + '\'' +
            ", adminPower='" + adminPower + '\'' +
            '}';
  }
}
