<%!
	private String XSSFilter( String txt )
	{
		java.util.regex.Pattern p = java.util.regex.Pattern.compile("&\"<(?:.|\\s)>");
		java.util.regex.Matcher m = p.matcher(txt);	
		return m.replaceAll("");
	}

	private String REQParam( String param ) 
	{
		if( param == null) return "";

		return param;
	}

	private String REQSearch( String param ) 
	{
		if( param == null) return "";

		return XSSFilter(param);
	}
	
	private String REQString( String param ) 
	{
		if( param == null) return "";

		return XSSFilter(param);
	}

	private String REQCHKParam( String param ) 
	{
		if( "Y".equals(param) ) {
			return "Y";
		} else {
			return "N";
		}
	}

	private String INPUT_VALUE( Object param )
	{
		if( param == null )	return "";

		return (""+param).replace( "\"", "&quot;");
	}

	private String IsNull( Object param, String default_value )
	{
		if( param == null ){
			return default_value;
		} else {
			return ""+param;
		}
	}
	
	private boolean IsValid( Object val ) 
	{
		if( val == null ) return false;
		if( "".equals( ""+val ) ) return false;
		return true;
	}
	
	private String NumberFormat( int val ) 
	{		
		java.text.DecimalFormat df = new java.text.DecimalFormat("#,##0");
		return df.format(val);
	}

	private String DateFormat( String datestr, String delim ) 
	{	
		String result = "";

		java.util.StringTokenizer st = new java.util.StringTokenizer(datestr, delim);
	    for ( int i=0; st.hasMoreTokens(); i++ ) {	    	
	    	if( i>0 ) {
	    		result += ". "+Integer.parseInt(st.nextToken(),10);
	    	} else {
	    		result += Integer.parseInt(st.nextToken(),10);
	    	}
	    }

	    return result+".";
	}
	////////////////////////////////////////////////////////////////////////////////////
	/*
		JDBC ResultSet 관련함수
	*/	
	private String DBStr( java.sql.ResultSet rs, String name ) throws SQLException
	{
		if (rs.getObject(name) != null && !rs.wasNull()) {
			return rs.getString(name);
		} else {
			return "";
		}
	}
	
	private int DBInt( java.sql.ResultSet rs, String name ) throws SQLException
	{
		if (rs.getObject(name) != null && !rs.wasNull()) {
			return rs.getInt(name);
		} else {
			return 0;
		}
	}
	
	private boolean DBHash( java.sql.ResultSet rs, java.util.Hashtable result ) throws SQLException
	{	
		java.sql.ResultSetMetaData rsmd = rs.getMetaData();
		String column_name=null;
		boolean res = rs.next();
		if( res ) {			
			for( int i=1; i<=rsmd.getColumnCount(); i++ ) {
				column_name = rsmd.getColumnLabel(i);
				result.put( column_name, DBStr( rs, column_name ));
			}		
		}		

		return res;
	}
	

	////////////////////////////////////////////////////////////////////////////////////
	// 이미지 관련
	private void MakeThumbnail( int width, int height, String sourcefile, String savefile ) throws java.io.IOException
	{
		java.awt.image.BufferedImage image = javax.imageio.ImageIO.read(new java.io.File(sourcefile));
		java.awt.image.BufferedImage thumbnail = org.imgscalr.Scalr.resize(image, org.imgscalr.Scalr.Method.SPEED, org.imgscalr.Scalr.Mode.FIT_TO_WIDTH, width, height , org.imgscalr.Scalr.OP_ANTIALIAS);
		javax.imageio.ImageIO.write(thumbnail, "jpg", new java.io.File(savefile)); 
	}
%>