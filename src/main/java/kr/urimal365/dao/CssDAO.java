package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.CssDB;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CssDAO extends MyBatisConfig {
    private static CssDAO _dao;

    private CssDAO() {
    }

    public static CssDAO getDAO() {
        if (_dao == null) {
            _dao = new CssDAO();
        }

        return _dao;
    }

    public List<CssDB> getCssList(String gbn) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((CssMapper)sqlSession.getMapper(CssMapper.class)).getCssList(gbn);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
