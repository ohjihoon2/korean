package kr.urimal365.dto;

import java.util.Date;

public class Visit {
    private String connectAgent;
    private String connectOs;
    private String connectBrowser;
    private String connectIp;
    private String connectRoute;
    private Date connectDate;

    public String getConnectAgent() {
        return connectAgent;
    }

    public void setConnectAgent(String connectAgent) {
        this.connectAgent = connectAgent;
    }

    public String getConnectOs() {
        return connectOs;
    }

    public void setConnectOs(String connectOs) {
        this.connectOs = connectOs;
    }

    public String getConnectBrowser() {
        return connectBrowser;
    }

    public void setConnectBrowser(String connectBrowser) {
        this.connectBrowser = connectBrowser;
    }

    public String getConnectIp() {
        return connectIp;
    }

    public void setConnectIp(String connectIp) {
        this.connectIp = connectIp;
    }

    public String getConnectRoute() {
        return connectRoute;
    }

    public void setConnectRoute(String connectRoute) {
        this.connectRoute = connectRoute;
    }

    public Date getConnectDate() {
        return connectDate;
    }

    public void setConnectDate(Date connectDate) {
        this.connectDate = connectDate;
    }

    public Visit() {
    }
}

