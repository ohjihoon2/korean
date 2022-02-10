package kr.urimal365.util;

import kr.urimal365.dao.VisitCountDAO;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionFilter implements Filter{

    public void destroy(){
    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException
    {

        System.out.println("SessionFilter.doFilter");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        System.out.println("session = " + session);

        if(session.isNew()){
            System.out.println("new session이다 !!!!!!");
            execute(request);
        }
        
        if(session == null){
            System.out.println("null check");
        }

        chain.doFilter(req, res);
    }

    private void execute(HttpServletRequest request){
        System.out.println("SessionFilter.execute");
        VisitCountDAO dao = VisitCountDAO.getInstance();

        try {
            // 전체 방문자 수 증가
            dao.setTotalCount(request);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void init(FilterConfig config) throws ServletException {}
}
