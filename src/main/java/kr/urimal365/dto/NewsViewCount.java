package kr.urimal365.dto;

public class NewsViewCount {
    private String dt;
    private int newsIdx;
    private int viewCount;
    private String writeDate;
    private String updateDate;

    public NewsViewCount() {
    }

    public String getDt() {
        return this.dt;
    }

    public void setDt(String dt) {
        this.dt = dt;
    }

    public int getNewsIdx() {
        return this.newsIdx;
    }

    public void setNewsIdx(int newsIdx) {
        this.newsIdx = newsIdx;
    }

    public int getViewCount() {
        return this.viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public String getWriteDate() {
        return this.writeDate;
    }

    public void setWriteDate(String writeDate) {
        this.writeDate = writeDate;
    }

    public String getUpdateDate() {
        return this.updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }
}
