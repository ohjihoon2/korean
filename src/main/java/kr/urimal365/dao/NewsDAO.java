package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import org.apache.ibatis.session.SqlSession;

public class NewsDAO extends MyBatisConfig {
    private static NewsDAO _dao;

    private NewsDAO() {
    }

    public static NewsDAO getDAO() {
        if (_dao == null) {
            _dao = new NewsDAO();
        }

        return _dao;
    }

    public int readNews(int idx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((NewsMapper)sqlSession.getMapper(NewsMapper.class)).readNews(idx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
