package kr.urimal365.dto;

public class Quiz {
    private int idx;
    private String title;
    private String subtitle;
    private String ym;
    private String contents;
    private String openYn;
    private String openStartDatetime;
    private String openEndDatetime;
    private String delYn;
    private String writeId;
    private String writeDate;
    private String updateId;
    private String updateDate;
    private String description;

    public Quiz() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
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

    public String getYm() {
        return this.ym;
    }

    public void setYm(String ym) {
        this.ym = ym;
    }

    public String getContents() {
        return this.contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getOpenYn() {
        return this.openYn;
    }

    public void setOpenYn(String openYn) {
        this.openYn = openYn;
    }

    public String getOpenStartDatetime() {
        return this.openStartDatetime;
    }

    public void setOpenStartDatetime(String openStartDatetime) {
        this.openStartDatetime = openStartDatetime;
    }

    public String getOpenEndDatetime() {
        return this.openEndDatetime;
    }

    public void setOpenEndDatetime(String openEndDatetime) {
        this.openEndDatetime = openEndDatetime;
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

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
