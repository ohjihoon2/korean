package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Count;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;

public class NewsViewCountDAO extends MyBatisConfig {
    private static NewsViewCountDAO _dao;

    private NewsViewCountDAO() {
    }

    public static NewsViewCountDAO getDAO() {
        if (_dao == null) {
            _dao = new NewsViewCountDAO();
        }

        return _dao;
    }

    public Count getCount(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Count var4;
        try {
            var4 = ((NewsViewCountMapper)sqlSession.getMapper(NewsViewCountMapper.class)).getCount(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public int updateCount(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((NewsViewCountMapper)sqlSession.getMapper(NewsViewCountMapper.class)).updateCount(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public int insertCount(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((NewsViewCountMapper)sqlSession.getMapper(NewsViewCountMapper.class)).insertCount(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
