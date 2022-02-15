package kr.urimal365.dao;

import kr.urimal365.dto.Contents;

import java.util.List;
import java.util.Map;

public interface ContentsMapper {
    List<Contents> getBanner(Map<String, Object> paraMap);

    Contents getFooter(String var1);

}
