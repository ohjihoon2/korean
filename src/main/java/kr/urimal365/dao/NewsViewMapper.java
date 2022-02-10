package kr.urimal365.dao;

import kr.urimal365.dto.NewsView;
import kr.urimal365.dto.Rownum;

import java.util.HashMap;
import java.util.List;

public interface NewsViewMapper {
    List<NewsView> bestNewsList();

    List<NewsView> recentNewsList(int var1);

    List<NewsView> recentBestNewsList(int var1);

    List<NewsView> getCateIdx(int var1);

    List<NewsView> mainBannerList();

    List<NewsView> postList(HashMap<String, Object> var1);

    NewsView getCateNews(int var1);

    NewsView getNews(int var1);

    NewsView getAdminNews(int var1);

    Rownum getRowNum(HashMap<String, Object> var1);

    NewsView getIdx(HashMap<String, Object> var1);

    List<NewsView> getXmlList(HashMap<String, Object> var1);
}
