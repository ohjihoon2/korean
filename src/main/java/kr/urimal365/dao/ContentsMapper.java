package kr.urimal365.dao;

import kr.urimal365.dto.Contents;
import kr.urimal365.dto.NewsCategory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ContentsMapper {
    List<Contents> getBanner(Map<String, Object> paraMap);

    Map<String, Object> getCategoryInfo(int idx);

    List<Map<String,Object>> getCategoryNewList();

    List<Map<String,Object>> getContentList(Map<String, Object> paraMap);

    Contents getFooter(String var1);

}
