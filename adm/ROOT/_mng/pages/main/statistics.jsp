<%@ page contentType="text/html; charset=UTF-8" %>

<div>
	<div class="row">
		<div class="col-xs-12 cus-height">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">접속통계</h3>

					<div class="box-tools">
						<div class="input-group input-group-sm">
							<div class="input-group-btn">
								<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="GoStatistics('D');">일</button>
								<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="GoStatistics('M');">월</button>
								<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="GoStatistics('Y');">년</button>
							</div>
						</div>
					</div>
					<hr />
					<div>
						<canvas id="myChart"></canvas>
					</div>
					<div style="padding:50px 127.5px 30px;">
						<canvas id="myChart2"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<script>
	$(document).ready(function() {
		var myChart = new Chart(document.getElementById('myChart'), config);
		var myChart2 = new Chart(document.getElementById('myChart2'), config2);
	});

<%
	if(statistics.equals("") || statistics.equals("D")) {
		sql =" 		SELECT a.re "
				+", CONCAT(a.re ,' (' ,SUBSTR(_UTF8'일월화수목금토', DAYOFWEEK(a.re), 1), ')') AS dt "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m-%d') = a.re) AS total "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m-%d') = a.re AND connect_os in('Windows', 'MAC', 'Etc')) AS pc "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m-%d') = a.re AND connect_os not in('Windows', 'MAC', 'Etc')) AS mobile "
				+"	FROM ( "
				+"	SELECT DATE(NOW()) re "
				+"	UNION ALL SELECT DATE_ADD(DATE(NOW()), INTERVAL -1 DAY) "
				+"	UNION ALL SELECT DATE_ADD(DATE(NOW()), INTERVAL -2 DAY) "
				+"	UNION ALL SELECT DATE_ADD(DATE(NOW()), INTERVAL -3 DAY) "
				+"	UNION ALL SELECT DATE_ADD(DATE(NOW()), INTERVAL -4 DAY) "
				+"	UNION ALL SELECT DATE_ADD(DATE(NOW()), INTERVAL -5 DAY) "
				+"	UNION ALL SELECT DATE_ADD(DATE(NOW()), INTERVAL -6 DAY) "
				+"	) a"
				+"	ORDER BY a.re ASC";
	}
	else if(statistics.equals("M")) {
		sql =" 		SELECT a.dt "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m') = a.dt) AS total"
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m') = a.dt AND connect_os in('Windows', 'MAC', 'Etc')) AS pc"
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m') = a.dt AND connect_os not in('Windows', 'MAC', 'Etc')) AS mobile"
				+"	FROM ( "
				+"	SELECT date_format(DATE(NOW()),'%Y-%m') as dt "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -1 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -2 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -3 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -4 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -5 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -6 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -7 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -8 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -9 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -10 MONTH ),'%Y-%m') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -11 MONTH ),'%Y-%m') "
				+"	) a"
				+"	ORDER BY a.dt ASC";
	}
	else if(statistics.equals("Y")) {
		sql =" 		SELECT a.dt "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y') = a.dt) AS total "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y') = a.dt AND connect_os in('Windows', 'MAC', 'Etc')) AS pc "
				+", (SELECT COUNT(*) dt_total FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y') = a.dt AND connect_os not in('Windows', 'MAC', 'Etc')) AS mobile "
				+"	FROM ( "
				+"	SELECT date_format(DATE(NOW()),'%Y') as dt "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -1 YEAR ),'%Y') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -2 YEAR ),'%Y') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -3 YEAR ),'%Y') "
				+"	UNION ALL SELECT date_format(DATE_ADD(DATE(NOW()), INTERVAL -4 YEAR ),'%Y') "
				+"	) a"
				+"	ORDER BY a.dt ASC";
	}
	pstmt = con.prepareStatement( sql );

		rs = pstmt.executeQuery();
%>
	//<![CDATA[
	var dt = new Array();
	var total = new Array();
	var pc = new Array();
	var mobile = new Array();
	<%

    for( int i=0; rs.next(); i++ ) { %>
		dt[<%=i%>] = "<%=DBStr(rs,"dt")%>";
		total[<%=i%>] = "<%=DBStr(rs,"total")%>";
		pc[<%=i%>] = "<%=DBStr(rs,"pc")%>";
		mobile[<%=i%>] = "<%=DBStr(rs,"mobile")%>";

		<% } %>
	//]]>

	var data = {
		labels: dt,
		datasets: [
			{
				label: '총 사용자',
				backgroundColor: '#3c8dbc',
				borderColor:'#3c8dbc',
				data: total,
			},
			{
				label: 'PC 사용자',
				backgroundColor: '#27AE60',
				borderColor:'#27AE60',
				data: pc,
			},
			{
				label: '모바일 사용자',
				backgroundColor: '#F1C40F',
				borderColor:'#F1C40F',
				data: mobile,
			}
		]
	};

	var config = {
		type: 'line',
		data: data,
		options: {
			plugins: {
			},
			interaction: {
				intersect: false,
			},
		}
	};

<% if(statistics.equals("") || statistics.equals("D")) {
		sql =" 		SELECT a.ds "
				+", (SELECT COUNT(*) FROM NARO_LOG_CONNECT_USER WHERE connect_browser = a.ds AND date_format(connect_date,'%Y-%m-%d') = DATE(NOW())) AS dn "
				+"	FROM ( "
				+"	SELECT connect_browser AS ds FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m-%d') = DATE(NOW()) GROUP BY connect_browser "
				+"	) a"
				+"	ORDER BY FIELD(a.ds,'Etc'),a.ds ASC";
	}
	else if(statistics.equals("M")) {
		sql =" 		SELECT a.ds "
				+", (SELECT COUNT(*) FROM NARO_LOG_CONNECT_USER WHERE connect_browser = a.ds AND date_format(connect_date,'%Y-%m') = date_format(NOW(),'%Y-%m')) AS dn "
				+"	FROM ( "
				+"	SELECT connect_browser AS ds FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y-%m') = date_format(NOW(),'%Y-%m') GROUP BY connect_browser "
				+"	) a"
				+"	ORDER BY FIELD(a.ds,'Etc'),a.ds ASC";
	}
	else if(statistics.equals("Y")) {
		sql =" 		SELECT a.ds "
				+", (SELECT COUNT(*) FROM NARO_LOG_CONNECT_USER WHERE connect_browser = a.ds AND date_format(connect_date,'%Y') = date_format(NOW(),'%Y')) AS dn "
				+"	FROM ( "
				+"	SELECT connect_browser AS ds FROM NARO_LOG_CONNECT_USER WHERE date_format(connect_date,'%Y') = date_format(NOW(),'%Y') GROUP BY connect_browser "
				+"	) a"
				+"	ORDER BY FIELD(a.ds,'Etc'),a.ds ASC";
	}
	pstmt = con.prepareStatement( sql );

	rs = pstmt.executeQuery();
%>


	//<![CDATA[
	var statistics = "<%= statistics %>";
	var str = "";


	var ds = new Array();
	var dn = new Array();
	<%

    for( int i=0; rs.next(); i++ ) { %>
	ds[<%=i%>] = "<%=DBStr(rs,"ds")%>";
	dn[<%=i%>] = "<%=DBStr(rs,"dn")%>";
	<% } %>
	//]]>

	if(dn.length > 0) {
		if(statistics == "" || statistics == "D") {
			str = "금일 방문자 브라우저 통계";
		}
		else if(statistics == "M") {
			str = "이번 달 방문자 브라우저 통계";
		}
		else if(statistics == "Y") {
			str = "이번 년도 방문자 브라우저 통계";
		}
	}

	const data2 = {
		labels: ds,
		datasets: [{
			label: '# of Votes',
			data: dn,
			borderWidth: 1,
			backgroundColor: ['#27AE60', '#3c8dbc', '#F1C40F', '#884EA0', '#CB4335'],
		}]
	};

	const config2 = {
		type: 'pie',
		data: data2,
		options: {
			// responsive: false,
			plugins: {
				title: {
					display: true,
					text: str
				},
				legend: {
					onHover: handleHover,
					onLeave: handleLeave,
					position: 'bottom'
				}
			}
		}
	};

	function handleHover(evt, item, legend) {
		legend.chart.data.datasets[0].backgroundColor.forEach((color, index, colors) => {
			colors[index] = index === item.index || color.length === 9 ? color : color + '4D';
		});
		legend.chart.update();
	};

	// Removes the alpha channel from background colors
	function handleLeave(evt, item, legend) {
		legend.chart.data.datasets[0].backgroundColor.forEach((color, index, colors) => {
			colors[index] = color.length === 9 ? color.slice(0, -2) : color;
		});
		legend.chart.update();
	};
</script>