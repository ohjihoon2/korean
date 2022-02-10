package kr.urimal365.dto;

public class CssDB {
    private int idx;
    private String contents;
    private String title;
    private String gbn;
    private String open_yn;
    private String write_date;
    private String write_id;

    public CssDB() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getContents() {
        return this.contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGbn() {
        return this.gbn;
    }

    public void setGbn(String gbn) {
        this.gbn = gbn;
    }

    public String getOpen_yn() {
        return this.open_yn;
    }

    public void setOpen_yn(String open_yn) {
        this.open_yn = open_yn;
    }

    public String getWrite_date() {
        return this.write_date;
    }

    public void setWrite_date(String write_date) {
        this.write_date = write_date;
    }

    public String getWrite_id() {
        return this.write_id;
    }

    public void setWrite_id(String write_id) {
        this.write_id = write_id;
    }
}
