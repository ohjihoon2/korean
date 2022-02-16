package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Contents;
import kr.urimal365.dto.NewsCategory;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NewsCategoryDAO extends MyBatisConfig {
    private static NewsCategoryDAO _dao;

    private NewsCategoryDAO() {
    }

    public static NewsCategoryDAO getDAO() {
        if (_dao == null) {
            _dao = new NewsCategoryDAO();
        }

        return _dao;
    }

    public List<NewsCategory> getHeadCategoryList() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var3;
        try {
            var3 = ((NewsCategoryMapper)sqlSession.getMapper(NewsCategoryMapper.class)).getHeadCategoryList();
        } finally {
            sqlSession.close();
        }

        return var3;
    }

    public List<NewsCategory> getDepthCategoryList(int parentIdx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((NewsCategoryMapper)sqlSession.getMapper(NewsCategoryMapper.class)).getDepthCategoryList(parentIdx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public List<NewsCategory> newsCategoryLvl2() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var3;
        try {
            var3 = ((NewsCategoryMapper)sqlSession.getMapper(NewsCategoryMapper.class)).newsCategoryLvl2();
        } finally {
            sqlSession.close();
        }

        return var3;
    }

    public NewsCategory getCategory(int newsIdx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        NewsCategory var4;
        try {
            var4 = ((NewsCategoryMapper)sqlSession.getMapper(NewsCategoryMapper.class)).getCategory(newsIdx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public NewsCategory getCategoryTitle(int categoryIdx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        NewsCategory var4;
        try {
            var4 = ((NewsCategoryMapper)sqlSession.getMapper(NewsCategoryMapper.class)).getCategoryTitle(categoryIdx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

}
