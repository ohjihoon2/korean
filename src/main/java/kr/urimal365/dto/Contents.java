package kr.urimal365.dto;

public class Contents {
    @Override
    public String toString() {
        return "Contents{" +
                "idx=" + idx +
                ", gbn='" + gbn + '\'' +
                ", contents='" + contents + '\'' +
                ", openYn='" + openYn + '\'' +
                ", openStartDatetime='" + openStartDatetime + '\'' +
                ", openEndDateTime='" + openEndDateTime + '\'' +
                ", writeId='" + writeId + '\'' +
                ", writeDate='" + writeDate + '\'' +
                ", updateId='" + updateId + '\'' +
                ", updateDate='" + updateDate + '\'' +
                '}';
    }

    private int idx;
    private String gbn;
    private String contents;
    private String openYn;
    private String openStartDatetime;
    private String openEndDateTime;
    private String writeId;
    private String writeDate;
    private String updateId;
    private String updateDate;

    public Contents() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getGbn() {
        return this.gbn;
    }

    public void setGbn(String gbn) {
        this.gbn = gbn;
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

    public String getOpenEndDateTime() {
        return this.openEndDateTime;
    }

    public void setOpenEndDateTime(String openEndDateTime) {
        this.openEndDateTime = openEndDateTime;
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
