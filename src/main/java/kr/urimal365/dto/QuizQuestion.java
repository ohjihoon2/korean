package kr.urimal365.dto;

public class QuizQuestion {
    private int idx;
    private int quizIdx;
    private int num;
    private String title;
    private String subtitle;
    private String rightAnswer;
    private String contents;
    private String delYn;
    private String writeId;
    private String writeDate;
    private String updateId;
    private String updateDate;

    public QuizQuestion() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getQuizIdx() {
        return this.quizIdx;
    }

    public void setQuizIdx(int quizIdx) {
        this.quizIdx = quizIdx;
    }

    public int getNum() {
        return this.num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return this.subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getRightAnswer() {
        return this.rightAnswer;
    }

    public void setRightAnswer(String rightAnswer) {
        this.rightAnswer = rightAnswer;
    }

    public String getContents() {
        return this.contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getDelYn() {
        return this.delYn;
    }

    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }

    public String getWriteId() {
        return this.writeId;
    }

    public void setWriteId(String writeId) {
        this.writeId = writeId;
    }

    public String getWriteDate() {
        return this.writeDate;
    }

    public void setWriteDate(String writeDate) {
        this.writeDate = writeDate;
    }

    public String getUpdateId() {
        return this.updateId;
    }

    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }

    public String getUpdateDate() {
        return this.updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }
}

