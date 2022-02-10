package kr.urimal365.dao;

import kr.urimal365.dto.Count;
import kr.urimal365.dto.QuizQuestion;
import kr.urimal365.dto.QuizView;

import java.util.HashMap;
import java.util.List;

public interface QuizViewMapper {
    QuizView getQuiz();

    QuizView previewQuiz(int var1);

    Count applyCount();

    List<QuizQuestion> quizQuestionList(int var1);

    int startQuiz(HashMap<String, Object> var1);

    int endQuiz(HashMap<String, Object> var1);

    int quizApply(HashMap<String, Object> var1);

    int getIdx();
}
