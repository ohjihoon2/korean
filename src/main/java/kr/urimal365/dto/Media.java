package kr.urimal365.dto;

public class Media {
    private int idx;
    private String url;
    private String path;
    private String filename;
    private String delYn;
    private String writeId;
    private String writeDate;
    private String updateId;
    private String updateDate;

    public Media() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getUrl() {
        return this.url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getPath() {
        return this.path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getFilename() {
        return this.filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
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
