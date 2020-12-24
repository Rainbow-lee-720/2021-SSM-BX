package com.stu.util;

import java.io.Serializable;

/**
 * @ClassName ResultAction
 * @Description 响应前端的返回数据封装工具类
 * @Author Administrator
 * @Date 2020/12/7 0007 22:15
 * @Version 1.0
 **/
@SuppressWarnings("serial")
public class ResultAction implements Serializable {
    //boolean型返回值
    private Boolean result;
    //字符串返回值1
    private String msg1;
    //字符串返回值2
    private String msg2;
    //对象类型返回值
    private Object content;
    //名称
    private String kind;
    //数值
    private Integer number;

    /**
     * @Author BX
     * @Description //无参构造
     * @Date 22:19 2020/12/7 0007
     * @Param []
     * @return
     **/
    public ResultAction() {
    }

    /**
     * @Author BX
     * @Description //有参构造
     * @Date 22:19 2020/12/7 0007
     * @Param []
     * @return
     **/
    public ResultAction(Boolean result, String msg1, String msg2) {
        this.result = result;
        this.msg1 = msg1;
        this.msg2 = msg2;
    }

    public ResultAction(String kind,Integer number) {
        this.kind = kind;
        this.number = number;
    }

    public ResultAction(Boolean result) {
        this.result = result;
    }

    public ResultAction(Object content) {
        this.content = content;
    }

    public ResultAction(Boolean result, Object content) {
        this.result = result;
        this.content = content;
    }

    public ResultAction(Boolean result, String msg1) {
        this.result = result;
        this.msg1 = msg1;
    }

    public ResultAction(Boolean result, String msg1, Object content) {
        this.result = result;
        this.msg1 = msg1;
        this.content = content;
    }

    public ResultAction(String msg1, String msg2) {
        this.msg1 = msg1;
        this.msg2 = msg2;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    public String getMsg1() {
        return msg1;
    }

    public void setMsg1(String msg1) {
        this.msg1 = msg1;
    }

    public String getMsg2() {
        return msg2;
    }

    public void setMsg2(String msg2) {
        this.msg2 = msg2;
    }

    public Object getContent() {
        return content;
    }

    public void setContent(Object content) {
        this.content = content;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "ResultAction{" +
                "result=" + result +
                ", msg1='" + msg1 + '\'' +
                ", msg2='" + msg2 + '\'' +
                ", content=" + content +
                ", kind='" + kind + '\'' +
                ", number=" + number +
                '}';
    }
}
