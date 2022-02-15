package kr.urimal365.dao;

import kr.urimal365.dto.NewsCategory;

import java.util.List;
import java.util.Map;

public interface NewsCategoryMapper {
    List<NewsCategory> getHeadCategoryList();

    List<NewsCategory> getDepthCategoryList(int var1);

    List<NewsCategory> newsCategoryLvl2();

    NewsCategory getCategory(int var1);

    NewsCategory getCategoryTitle(int var1);

    List<NewsCategory> getCategoryNewList();

    List<NewsCategory> getContentList(Map<String, Object> paraMap);
}
