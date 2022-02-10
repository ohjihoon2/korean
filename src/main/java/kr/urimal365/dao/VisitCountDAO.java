package kr.urimal365.dao;

import kr.urimal365.config.MyBatisConfig;
import kr.urimal365.dto.Visit;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.http.HttpServletRequest;

public class VisitCountDAO extends MyBatisConfig {
    private static VisitCountDAO instance;

    // 싱글톤 패턴
    private VisitCountDAO(){}
    public static VisitCountDAO getInstance(){
        if(instance==null)
            instance=new VisitCountDAO();
        return instance;
    }

    /**
     * 총방문자수를 증가시킨다.
     */
    public void setTotalCount(HttpServletRequest request){
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        String  browserDetails  =   request.getHeader("User-Agent");
        String  userAgent       =   browserDetails;
        String  user            =   userAgent.toLowerCase();

        String os = "";
        String browser = "";

        //=================OS=======================
        if (userAgent.toLowerCase().indexOf("windows") >= 0 )
        {
            os = "Windows";
        } else if(userAgent.toLowerCase().indexOf("mac") >= 0)
        {
            os = "Mac";
        } else if(userAgent.toLowerCase().indexOf("x11") >= 0)
        {
            os = "Unix";
        } else if(userAgent.toLowerCase().indexOf("android") >= 0)
        {
            os = "Android";
        } else if(userAgent.toLowerCase().indexOf("iphone") >= 0)
        {
            os = "IPhone";
        }else{
            os = "Etc";
        }
        //===============Browser===========================
        if (user.contains("edg"))
        {
            browser="Edge";
        } else if (user.contains("safari") && user.contains("version"))
        {
            browser="Safari";
        } else if ( user.contains("opr") || user.contains("opera"))
        {
            if(user.contains("opera"))
                browser="Opera";
            else if(user.contains("opr"))
                browser="Opera";
        }
        else if(user.contains("samsung"))
        {
            browser="SAMSUNG";
        }
        else if (user.contains("chrome"))
        {
            browser="Chrome";
        } else if (user.contains("firefox"))
        {
            browser="Firefox";
        } else if(user.contains("rv"))
        {
            browser="IE";
        }
        else
        {
            browser ="Etc";
        }

        Visit visit = new Visit();
        visit.setConnectAgent(request.getHeader("user-agent"));
        visit.setConnectIp(request.getRemoteAddr());
        visit.setConnectBrowser(browser);
        visit.setConnectOs(os);
        visit.setConnectRoute(request.getHeader("Referer"));


        try {
            sqlSession.getMapper(VisitMapper.class).setTotalCount(visit);
        } finally {
            sqlSession.close();
        }
    } // end setTotalCount()

    /**
     * 총 방문자수를 가져온다.
     * @return totalCount : 총 방문자 수
     */
    /*public int getTotalCount(){
        SqlSession sqlSession = getSqlSessionFactory().openSession(true);

        int totalCount = 0;
        try {
            totalCount = sqlSession.getMapper(VisitMapper.class).getTotalCount();
        } finally {
            sqlSession.close();
        }

        return totalCount;
    } // end getTotalCount()*/
/*
    *//**
     * 오늘 방문자 수를 가져온다.
     * @return todayCount : 오늘 방문자
     *//*
    public int getTodayCount()
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int todayCount = 0;

        try {

            StringBuffer sql = new StringBuffer();
            sql.append("SELECT COUNT(*) AS TodayCnt FROM VISIT");
            sql.append(" WHERE TO_DATE(V_DATE, 'YYYY-MM-DD') = TO_DATE(sysdate, 'YYYY-MM-DD')");

            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();

            // 방문자 수를 변수에 담는다.
            if (rs.next())
                todayCount = rs.getInt("TodayCnt");

            return todayCount;

        } catch (Exception sqle) {
            throw new RuntimeException(sqle.getMessage());
        } finally {
            // Connection, PreparedStatement를 닫는다.
            try{
                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
                if ( conn != null ){ conn.close(); conn=null;    }
            }catch(Exception e){
                throw new RuntimeException(e.getMessage());
            }
        }
    }// end getTodayCount()*/
}
