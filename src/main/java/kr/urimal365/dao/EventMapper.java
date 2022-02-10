package kr.urimal365.dao;

import kr.urimal365.dto.Count;
import kr.urimal365.dto.Event;

public interface EventMapper {
    int insertEvent(Event var1);

    Count recodeCount(int var1);
}