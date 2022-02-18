package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Contents;
import kr.urimal365.dto.NewsCategory;
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

    public Contents getSelectOneBanner(String gbn) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Contents var4;
        try {
            var4 = ((ContentsMapper)sqlSession.getMapper(ContentsMapper.class)).getSelectOneBanner(gbn);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    // 카테고리 정보
    public Map<String, Object> getCategoryInfo(int idx){
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Map<String, Object> var;

        try {
            var = ((ContentsMapper)sqlSession.getMapper(ContentsMapper.class)).getCategoryInfo(idx);
        } finally {
            sqlSession.close();
        }
        return var;
    }

    // 새로운 글 모음
    public List<Map<String,Object>> getCategoryNewList() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List<Map<String,Object>> var4;

        try {
            var4 = ((ContentsMapper)sqlSession.getMapper(ContentsMapper.class)).getCategoryNewList();
        } finally {
            sqlSession.close();
        }
        return var4;
    }

    // 메인페이지 contentList
    public List<Map<String,Object>> getContentList(int idx, int limit) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List<Map<String,Object>> var4;

        Map<String, Object> paraMap = new HashMap<>();

        paraMap.put("idx", idx);
        paraMap.put("limit", limit);

        try {
            var4 = ((ContentsMapper)sqlSession.getMapper(ContentsMapper.class)).getContentList(paraMap);
        } finally {
            sqlSession.close();
        }

        return var4;
    }





}
