package kr.urimal365.dto;

public class NewsCategory {
    private int idx;
    private int parentIdx;
    private int lvl;
    private String name;
    private String link;
    private String defaultThumbnailFile;
    private String defaultBannerFile;
    private String sortOrder;
    private String delYn;
    private String writeId;
    private String writeDate;
    private String updateId;
    private String updateDate;
    private String isOpen;

    public NewsCategory() {
    }

    public int getIdx() {
        return this.idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getParentIdx() {
        return this.parentIdx;
    }

    public void setParentIdx(int parentIdx) {
        this.parentIdx = parentIdx;
    }

    public int getLvl() {
        return this.lvl;
    }

    public void setLvl(int lvl) {
        this.lvl = lvl;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLink() {
        return this.link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getDefaultThumbnailFile() {
        return this.defaultThumbnailFile;
    }

    public void setDefaultThumbnailFile(String defaultThumbnailFile) {
        this.defaultThumbnailFile = defaultThumbnailFile;
    }

    public String getDefaultBannerFile() {
        return this.defaultBannerFile;
    }

    public void setDefaultBannerFile(String defaultBannerFile) {
        this.defaultBannerFile = defaultBannerFile;
    }

    public String getSortOrder() {
        return this.sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
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

    public String getIsOpen() {
        return this.isOpen;
    }

    public void setIsOpen(String isOpen) {
        this.isOpen = isOpen;
    }
}
