package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Count;
import kr.urimal365.dto.Event;
import org.apache.ibatis.session.SqlSession;

public class EventDAO extends MyBatisConfig {
    private static EventDAO _dao;

    private EventDAO() {
    }

    public static EventDAO getDAO() {
        if (_dao == null) {
            _dao = new EventDAO();
        }

        return _dao;
    }

    public int insertEvent(Event event) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((EventMapper)sqlSession.getMapper(EventMapper.class)).insertEvent(event);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public Count recodeCount(int idx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Count var4;
        try {
            var4 = ((EventMapper)sqlSession.getMapper(EventMapper.class)).recodeCount(idx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
