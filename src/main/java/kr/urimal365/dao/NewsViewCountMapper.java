package kr.urimal365.dao;

import kr.urimal365.dto.Count;

import java.util.HashMap;

public interface NewsViewCountMapper {
    Count getCount(HashMap<String, Object> var1);

    int updateCount(HashMap<String, Object> var1);

    int insertCount(HashMap<String, Object> var1);
}
