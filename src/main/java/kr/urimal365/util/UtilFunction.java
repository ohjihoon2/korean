package kr.urimal365.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UtilFunction {
    public UtilFunction() {
    }

    public static String removeTag(String html) {
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }

    public static String xssFilter(String txt) {
        Pattern p = Pattern.compile("&\"<(?:.|\\s)>");
        Matcher m = p.matcher(txt);
        return m.replaceAll("");
    }

    public static String titleCut(String title, int length) {
        ArrayList<String> strList = new ArrayList();
        String txt = removeTag(title);
        String checkStr = "";
        StringTokenizer strToken1 = new StringTokenizer(txt, " ");

        String kkk;
        while(strToken1.hasMoreTokens()) {
            kkk = strToken1.nextToken();
            if ((checkStr + kkk).length() <= length) {
                checkStr = checkStr + kkk + " ";
            } else {
                strList.add(checkStr);
                checkStr = "";
                checkStr = checkStr + kkk + " ";
            }
        }

        strList.add(checkStr);
        kkk = "";

        String str;
        for(Iterator var8 = strList.iterator(); var8.hasNext(); kkk = kkk + str + "<br/>") {
            str = (String)var8.next();
        }

        return kkk;
    }

    public static String reqString(String param) {
        return param == null ? "" : xssFilter(param);
    }
}
