package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Contents;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ContentsDAO extends MyBatisConfig {
    private static ContentsDAO _dao;

    private ContentsDAO() {
    }

    public static ContentsDAO getDAO() {
        if (_dao == null) {
            _dao = new ContentsDAO();
        }

        return _dao;
    }

    public List<Contents> getBanner(String gbn) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List<Contents> var4;

        Map<String, Object> paraMap = new HashMap<>();

        paraMap.put("gbn", gbn);
        try {
            var4 = ((ContentsMapper)sqlSession.getMapper(ContentsMapper.class)).getBanner(paraMap);
        } finally {
            sqlSession.close();
        }
        return var4;
    }

    public Contents getFooter(String gbn) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Contents var4;
        try {
            var4 = ((ContentsMapper)sqlSession.getMapper(ContentsMapper.class)).getFooter(gbn);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
