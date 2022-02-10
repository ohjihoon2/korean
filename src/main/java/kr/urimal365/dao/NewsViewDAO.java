package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.NewsView;
import kr.urimal365.dto.Rownum;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class NewsViewDAO extends MyBatisConfig {
    private static NewsViewDAO _dao;

    private NewsViewDAO() {
    }

    public static NewsViewDAO getDAO() {
        if (_dao == null) {
            _dao = new NewsViewDAO();
        }

        return _dao;
    }

    public List<NewsView> bestNewsList() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var3;
        try {
            var3 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).bestNewsList();
        } finally {
            sqlSession.close();
        }

        return var3;
    }

    public List<NewsView> recentNewsList(int cate1) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).recentNewsList(cate1);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public List<NewsView> recentBestNewsList(int cate1) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).recentBestNewsList(cate1);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public List<NewsView> getCateIdx(int cate1) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getCateIdx(cate1);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public List<NewsView> mainBannerList() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var3;
        try {
            var3 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).mainBannerList();
        } finally {
            sqlSession.close();
        }

        return var3;
    }

    public List<NewsView> postList(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).postList(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public NewsView getCateNews(int categoryIdx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        NewsView var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getCateNews(categoryIdx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public NewsView getNews(int idx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        NewsView var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getNews(idx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public NewsView getAdminNews(int idx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        NewsView var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getAdminNews(idx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public Rownum getRowNum(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Rownum var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getRowNum(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public NewsView getIdx(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        NewsView var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getIdx(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public List<NewsView> getXmlList(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((NewsViewMapper)sqlSession.getMapper(NewsViewMapper.class)).getXmlList(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }
}
