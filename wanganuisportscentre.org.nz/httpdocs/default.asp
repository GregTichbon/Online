<%
	if request.form("form") <> "" then
		
	
	else

		page = request.querystring("page")
		if page = "" then page = "home"
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\wanganuisportscentre.org.nz\WanganuiSportsCentre.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.RecordSet")
		sql = "select * from [pages] where reference = '" & page & "'"
		rs.Open sql, db
		if not rs.eof then
			content = rs("content")
			if instr(content,"||Form||") then
				set fs = server.CreateObject("Scripting.FileSystemObject")
				set ts = fs.OpenTextFile(Server.MapPath(page & "_form.htm"),1)
				frmpage = ts.readall
				set di = server.createobject("DI.IIS")
				securitycode = di.di_generatepassword(5,8)
				set di = nothing
				frmpage = replace(frmpage,"||securitycode||",securitycode)
				ts.Close
				set ts = nothing
				set fs = nothing
				content = replace(content,"||Form||",frmpage)
			end if
		end if
		rs.close
		set rs = nothing
		db.close
		set db = nothing
	end if
%>
<HTML>
<HEAD>
<TITLE>Wanganui Community Sports Centre</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<LINK href="css_wcsc.css" type=text/css rel=stylesheet>
<script language="JavaScript">
function showsubmenu(menu) {
	for (i = 1; i <= 4; i++ ) {
		loopspan = 'sm' + i;
		if(loopspan == menu) {
			document.getElementById(loopspan).style.display = "";
		} 
		else {
			document.getElementById(loopspan).style.display = "none";
		}
	}
}
function MM_openBrWindow(theURL,winName,features) { 
  window.open(theURL,winName,features);
}
</script>
</HEAD>
<BODY>
<TABLE cellSpacing=0 cellPadding=0 width=735 align=center bgColor=#b8b8b8 border=0>
  <TBODY>
    <TR vAlign=top>
      <TD width=271><IMG src="Images/topbar1a.jpg" width="271" height="148"></TD>
      <TD width=469><img src="Images/topbar1b.gif" width="464" height="148" border="0" usemap="#Map"></TD>
    </TR>
    <TR vAlign=top>
      <TD background=Images/for_bg_navi.gif><TABLE cellSpacing=0 cellPadding=0 width=271 border=0>
          <TBODY>
            <TR>
              <TD vAlign=top><IMG height=40 src="Images/navi_side1.gif" width=271></TD>
            </TR>
            <TR>
              <TD vAlign=top><A href="default.asp?page=tabletennis"><IMG height=27 src="Images/navi_tt.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=volleyball"><IMG height=26 src="Images/navi_volley.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=indoorbowls"><IMG height=26 src="Images/navi_indoor.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=inlinehockey"><IMG height=26 src="Images/navi_inline.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=speedskating"><IMG height=26 src="Images/navi_speedskate.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=ROLLERDERBY"><IMG height=26 src="Images/navi_rollerderby.gif" width=271 border=0></A></TD>
            </TR>
              <TR>
              <TD vAlign=top><a href="default.asp?page=FUTSAL"><IMG height=26 src="Images/navi_futsal.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=basketball"><IMG height=25 src="Images/navi_basket.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=netball"><IMG height=26 src="Images/navi_net.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=netballmixedindoor"><IMG height=26 src="Images/navi-mixednetball.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=badminton"><IMG height=26 src="Images/navi_badminton.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=rugby"><IMG height=26 src="Images/navi_rugby.gif" width=271 border=0></A></TD>
            </TR><!--
            <TR>
              <TD vAlign=top><a href="default.asp?page=mastersgames"><IMG height=25 src="Images/navi_masters.gif" width=271 border=0></A></TD>
            </TR>-->
            <TR>
              <TD vAlign=top><a href="default.asp?page=ymca"><IMG height=25 src="Images/navi_ymca.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=gymnastics"><IMG height=25 src="Images/navi_gym.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top><a href="default.asp?page=outdoor"><IMG height=25 src="Images/navi_outdoor.gif" width=271 border=0></A></TD>
            </TR>
            <TR>
              <TD vAlign=top>&nbsp;</TD>
            </TR>
            <TR>
              <TD class=contact vAlign=top><DIV align=center><IMG height=63 src="Images/navi_side3a.gif" width=200><BR>
                <SPAN class=contact>information/bookings <FONT color=#ffffff>ph. 345 2102</FONT></SPAN></DIV></TD>
            </TR>
            <TR>
              <TD vAlign=top>&nbsp;</TD>
            </TR>
          </TBODY>
        </TABLE>
        <P class=contact>&nbsp;</P></TD>
      <TD background="Images/for_bg_black.gif" bgColor="#000000"><TABLE cellSpacing=0 cellPadding=0 width=464 border=0>
          <TBODY>
            <TR>
              <TD height="10" colSpan=3 align="center">&nbsp;
			  <span id="sm1" style="display:none;"><a href="default.asp?page=sportsevents">Sports Events</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=otherevents">Other Events</a></span>
			  <span id="sm2" style="display:none"><a href="default.asp?page=facilities">Facilities</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=location">Location</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=history">History</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=conditions">Conditions</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=sponsors">Sponsors</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=meetinginfo">Meetings</a></span>
			  <span id="sm3" style="display:none"><a href="default.asp?page=sportsatwcsc">Sports at WCSC</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=links">Links</a></span>
			  <span id="sm4" style="display:none"><a href="default.asp?page=pricing">Pricing</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=conditions">Conditions</a> <font color="#FFFFFF">&#8226;</font> <a href="default.asp?page=onlinebooking">Online Booking</a></span>
			  </TD>
            </TR>
            <TR>
              <TD width=25>&nbsp;</TD>
              <TD vAlign=top width=429><%=content%></TD>
              <TD width=10>&nbsp;</TD>
            </TR>
            <TR>
              <TD colSpan=3>&nbsp;</TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
    <TR vAlign=top>
      <TD background="Images/for_bg.gif"><IMG height=75 
      src="Images/filler.gif" width=10></TD>
      <TD class=bottom vAlign="center" align="middle"><p></p>
          <p>| <a href="default.asp?page=contact">Contact Us</A> | <a href="default.asp?page=facilities">About WCSC</A> | <a href="default.asp?page=sitemap">Sitemap</A> | <a href="default.asp?page=disclaimer">Disclaimer</A> |
        </p>
</p>
      <p align="right">&copy; 2006</p></TD>
    </TR>
  </TBODY>
</TABLE>
<map name="Map">
  <area shape="rect" coords="60,126,96,142" href="default.asp">
  <area shape="rect" coords="109,126,150,142" onMouseOver="javascript:showsubmenu('sm1')">
  <area shape="rect" coords="164,126,236,142" onMouseOver="javascript:showsubmenu('sm2')">
  <area shape="rect" coords="246,125,329,143" onMouseOver="javascript:showsubmenu('sm3')">
  <area shape="rect" coords="337,125,386,143" onMouseOver="javascript:showsubmenu('sm4')">
  <area shape="rect" coords="406,126,452,142" href="default.asp?page=contact">
</map>
</BODY>
</HTML>
