package kr.urimal365.config;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.http.HttpServlet;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisConfig extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static SqlSessionFactory sqlsessionFactory;

    public MyBatisConfig() {
    }

    public void init() {
        try {
            InputStream inputStream = Resources.getResourceAsStream("kr/urimal365/config/mybatis-config.xml");
            sqlsessionFactory = (new SqlSessionFactoryBuilder()).build(inputStream);
        } catch (IOException var2) {
            System.out.println("IOEXCEPTION init() method");
        }

    }

    public static SqlSessionFactory getSqlSessionFactory() {
        return sqlsessionFactory;
    }

    public static void setSqlSessionFactory(SqlSessionFactory sqlsessionFactory) {
        MyBatisConfig.sqlsessionFactory = sqlsessionFactory;
    }
}
