package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Reception;
import org.apache.ibatis.session.SqlSession;

public class ReceptionDAO extends MyBatisConfig {
    private static ReceptionDAO _dao;

    private ReceptionDAO() {
    }

    public static ReceptionDAO getDAO() {
        if (_dao == null) {
            _dao = new ReceptionDAO();
        }

        return _dao;
    }

    public int insertReception(Reception reception) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((ReceptionMapper)sqlSession.getMapper(ReceptionMapper.class)).insertReception(reception);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
