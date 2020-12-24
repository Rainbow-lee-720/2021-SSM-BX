package com.stu.util;

/**
 * @ClassName StringUtils
 * @Description 字符串工具类
 * @Author BX
 * @Date 2020/12/7 0007 22:08
 * @Version 1.0
 **/
public class StringEmpty {
    /**
     * @Author BX
     * @Description //判断字符串是否为空
     * @Date 22:09 2020/12/7 0007
     * @Param [str]
     * @return boolean
     **/
    public static boolean stringIsEmpty(Object object) {
        return (object == null || "".equals(object));
    }

}
