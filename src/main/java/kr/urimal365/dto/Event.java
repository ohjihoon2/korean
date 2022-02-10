package kr.urimal365.dto;

public class Event {
    private int idx;
    private int eventGroupIdx;
    private String userName;
    private String userHp;
    private String userEmail;
    private String agreeYn;
    private String contents;
    private String writeDate;
    private String imgDir;

    public Event() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getEventGroupIdx() {
        return this.eventGroupIdx;
    }

    public void setEventGroupIdx(int eventGroupIdx) {
        this.eventGroupIdx = eventGroupIdx;
    }

    public String getUserName() {
        return this.userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserHp() {
        return this.userHp;
    }

    public void setUserHp(String userHp) {
        this.userHp = userHp;
    }

    public String getUserEmail() {
        return this.userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getAgreeYn() {
        return this.agreeYn;
    }

    public void setAgreeYn(String agreeYn) {
        this.agreeYn = agreeYn;
    }

    public String getContents() {
        return this.contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getWriteDate() {
        return this.writeDate;
    }

    public void setWriteDate(String writeDate) {
        this.writeDate = writeDate;
    }

    public String getImgDir() {
        return this.imgDir;
    }

    public void setImgDir(String imgDir) {
        this.imgDir = imgDir;
    }
}

