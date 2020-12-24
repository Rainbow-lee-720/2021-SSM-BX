package com.stu.util;

/**
 * @ClassName ObjectEmpty
 * @Description 判断对象是否为空
 * @Author BX
 * @Date 2020/12/10 0010 16:29
 * @Version 1.0
 **/
public class ObjectEmpty {

    public static boolean objectIsEmpty(Object object) {
        if(object == null || object.equals("")){
            return true;
        }
        return false;
    }
}
