package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Count;
import kr.urimal365.dto.QuizQuestion;
import kr.urimal365.dto.QuizView;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class QuizViewDAO extends MyBatisConfig {
    private static QuizViewDAO _dao;

    private QuizViewDAO() {
    }

    public static QuizViewDAO getDAO() {
        if (_dao == null) {
            _dao = new QuizViewDAO();
        }

        return _dao;
    }

    public QuizView getQuiz() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        QuizView var3;
        try {
            var3 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).getQuiz();
        } finally {
            sqlSession.close();
        }

        return var3;
    }

    public QuizView previewQuiz(int idx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        QuizView var4;
        try {
            var4 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).previewQuiz(idx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public Count applyCount() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        Count var3;
        try {
            var3 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).applyCount();
        } finally {
            sqlSession.close();
        }

        return var3;
    }

    public List<QuizQuestion> quizQuestionList(int idx) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        List var4;
        try {
            var4 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).quizQuestionList(idx);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public int startQuiz(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).startQuiz(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public int endQuiz(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).endQuiz(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public int quizApply(HashMap<String, Object> param) {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var4;
        try {
            var4 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).quizApply(param);
        } finally {
            sqlSession.close();
        }

        return var4;
    }

    public int getIdx() {
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int var3;
        try {
            var3 = ((QuizViewMapper)sqlSession.getMapper(QuizViewMapper.class)).getIdx();
        } finally {
            sqlSession.close();
        }

        return var3;
    }
}
