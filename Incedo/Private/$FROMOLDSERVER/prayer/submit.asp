<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Prayer"
		secoption = "Administration"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
		administrator = secresult 
	end if
%>
<HTML><HEAD><TITLE>Prayer Page</TITLE>
<%
	ID = request.querystring("id")
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	if id = "New" then
		title = ""
		narrative = ""
		category = ""
		expireon = ""
		submittedby = memberid
	else
		sqlstring = "SELECT PrayerItem.*, IIf([knownas] Is Null,[Firstname],[knownas]) & ' ' & [lastname] & ' (' & [centre] & ')' AS Name, People.Email " & _
				    "FROM PrayerItem LEFT JOIN People ON PrayerItem.SubmittedBy = People.ID where itemid = " & ID
		rs.Open sqlstring, db
		if session("Incedo_MemberID") <> rs("submittedby") and administrator <> "OK" then
			Response.Redirect "../signon"
		end if
		submittedby = rs("name") & " <a href=""mailto:" & rs("email") & """>" & rs("email") & "</a>"
		title = rs("title")
		narrative = rs("narrative")
		category = rs("categoryid")
		closed = rs("closed")
		if closed = "True" then
			closed = " checked"
		else
			closed = ""
		end if
		sumbittedon = di.DI_format(rs("datetime"),"dd mmm yyyy")
		expireon = di.DI_format(rs("expireon"),"dd mmm yyyy")
		rs.close
		set rs = nothing
	end if	
	onload = " onload=setvalues()"
%>
<link rel="stylesheet" type="text/css" media="all" href="calendar-win2k-1.css" title="win2k-1" />
<script type="text/javascript" src="calendar.js"></script>
<script type="text/javascript" src="calendar-en.js"></script>
<script type="text/javascript" src="calendar-setup.js"></script>
<script language="JavaScript">
var oldLink = null;
// code to change the active stylesheet
function setActiveStyleSheet(link, title) {
  var i, a, main;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false; 
    }
  }
  if (oldLink) oldLink.style.fontWeight = 'normal';
  oldLink = link;
  link.style.fontWeight = 'bold';
  return false;
}

function CheckMyForm() {
	msg = ''
	delim = ''
	setfocus = ""

	if(document.prayer.category.value == '') {
		msg = msg + delim + ' - Category';
		delim = '\n';
		if(msg == '')
			setfocus = "category";
	}
	if(document.prayer.title.value == '') {
		msg = msg + delim + ' - Title';
		delim = '\n';
	}
	if(document.prayer.narrative.value == '') {
		msg = msg + delim + ' - Narrative';
		delim = '\n';
	}

	if(msg != '') {
		msg = 'You must enter:\n' + msg;
		delim = '\n';
		alert(msg);
		return(false);
	}
}

function setvalues() {
	document.prayer.category.value = "<%=category%>";
}
//-->
</script>
<BODY <%=onload%>>
<FORM name="prayer" action="submit_process.asp" method="post" OnSubmit="return CheckMyForm();">
<input name="id" type="hidden" id="id" value="<%=id%>">
<table width="780" border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
  <tr><td nowrap>Category</td>
  <td>
<select name="category">
<option value="">---Please Select---</option>
<%
		Set categoryrs = Server.CreateObject("ADODB.Recordset")
		sql = "Select * from prayercategory order by category"
		categoryrs.open sql, db
		do until categoryrs.eof
			response.write  "<option value=""" & categoryrs("categoryid") & """>" & categoryrs("category")  & "</option>"
			categoryrs.movenext
		loop
		categoryrs.close
		set categoryrs = nothing
		db.close
		set db = nothing
%>
		</select>
      </td></tr>
    <TR>
      <td nowrap>Title</td>
      <td><input name="title" type="text" id="title" value="<%=title%>" size="40" maxlength="50"></td>
    </TR>
    <TR> 
<td nowrap>Narrative</td>
      <td> 
        <textarea name="narrative" rows="10" style="width:98%"><%=narrative%></textarea>
      </td>
    </TR>
<% if administrator = "OK" then %>
    <TR> 
<td nowrap>Submitted by</td>
      <td> 
        <%=submittedby%>
      </td>
    </TR>
    <TR> 
<td nowrap>Submitted on</td>
      <td> 
        <%=sumbittedon%>
      </td>
    </TR>
<% end if %>
    <TR>
      <td nowrap>Display until </td>
      <td>
            <input name="expireon" type="text" id="expireon" value="<%=expireon%>">

	 <img src="cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="expireontrigger">
<script type="text/javascript">
Calendar.setup(
    {
      inputField  : "expireon",         // ID of the input field
      ifFormat    : "%d %b %Y",    // the date format
      button      : "expireontrigger"       // ID of the button
    }
  );
</script>
	  
	  
	  
	  </td>
    </TR>
	<% if id <> "New" then %>
    <TR>
      <td nowrap>Closed</td>
      <td><input name="closed" type="checkbox" id="closed" value="true" <%=closed%>></td>
    </TR> 
	<% end if %>
  </table>
<%
    response.write "<input type=""submit"" name=""$create"" value=""Create"">"
    if id <> "New" then
		response.write "<input type=""submit"" name=""$modify"" value=""Modify"">"
		response.write "<input type=""submit"" name=""$delete"" value=""Delete"">"
	end if
    response.write "<P><INPUT id=reset type=reset value="" Clear Form "" name=$reset>"
%>

</FORM>

</BODY></HTML>


