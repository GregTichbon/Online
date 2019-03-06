<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "FeaturedLinks"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult = "Failed" then 		
			response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
			response.end
		end if
	end if

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	id = request.querystring("id")
	if id <> "new" then
		set di = server.createobject("DI.IIS")
		sql = "SELECT * from featuredlinks where id = " & id  
		rs.Open sql, db
		if not rs.eof then
			link = rs("link")
			description = rs("description")
			internalfeaturefrom = di.di_format(rs("internalfeaturefrom"),"dd/mm/yyyy")
			internalfeatureto = di.di_format(rs("internalfeatureto"),"dd/mm/yyyy")
			externalfeaturefrom = di.di_format(rs("externalfeaturefrom"),"dd/mm/yyyy")
			externalfeatureto = di.di_format(rs("externalfeatureto"),"dd/mm/yyyy")
		end if
		rs.close
		set di = nothing
	end if
%>
<html>
<head>
<title>Incedo News</title>
<link rel="stylesheet" type="text/css" media="all" href="../../calendar-win2k-1.css" title="win2k-1" />
<script type="text/javascript" src="../../calendar_stripped.js"></script>
<script type="text/javascript" src="../../calendar-en.js"></script>
<script type="text/javascript" src="../../calendar-setup_stripped.js"></script>
<script type="text/javascript" src="../../Javascript/validateDate.js"></script>
<script language="JavaScript">
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;
	if(frm.link.value == '') {
		msg = msg + delim + ' - Link';
		delim = '\n';
	}
	if(frm.description.value == '') {
		msg = msg + delim + ' - Description';
		delim = '\n';
	}
	if(frm.externalfeaturefrom.value != '') {
		if(IsDate(frm.externalfeaturefrom.value) != 'OK') {
			msg = msg + delim + ' - Valid External Featured from Date';
			delim = '\n';
		} else {
			if(frm.externalfeatureto.value == '') {
				msg = msg + delim + ' - External Featured to Date';
				delim = '\n';
			} else {
				if(IsDate(frm.externalfeatureto.value) != 'OK') {
					msg = msg + delim + ' - Valid External Featured to Date';
					delim = '\n';
				} else {
					if(frm.externalfeatureto.value <= frm.externalfeaturefrom.value) {
						msg = msg + delim + ' - An External Featured to Date after the External Featured from Date';
						delim = '\n';
					}
				}
			}
		}
	} else {
		if(frm.externalfeatureto.value != '') {
			msg = msg + delim + ' - An External Featured from Date';
			delim = '\n';
		}
	}
	if(frm.internalfeaturefrom.value != '') {
		if(IsDate(frm.internalfeaturefrom.value) != 'OK') {
			msg = msg + delim + ' - Valid internal Featured from Date';
			delim = '\n';
		} else {
			if(frm.internalfeatureto.value == '') {
				msg = msg + delim + ' - internal Featured to Date';
				delim = '\n';
			} else {
				if(IsDate(frm.internalfeatureto.value) != 'OK') {
					msg = msg + delim + ' - Valid internal Featured to Date';
					delim = '\n';
				} else {
					if(frm.internalfeatureto.value <= frm.internalfeaturefrom.value) {
						msg = msg + delim + ' - An internal Featured to Date after the internal Featured from Date';
						delim = '\n';
					}
				}
			}
		}
	} else {
		if(frm.internalfeatureto.value != '') {
			msg = msg + delim + ' - An internal Featured from Date';
			delim = '\n';
		}
	}



	if(!(frm.$rssupdate[0].checked) && !(frm.$rssupdate[1].checked)) {
		msg = msg + delim + ' - An RSS option';
		delim = '\n';
	}
	if(msg != '') {
		alert('You must enter:\n' + msg);
		return(false);
	}
}
</script>
</head>
<body>
    <h1>FEATURED LINKS MAINTENANCE</h1>
    <form name="maint" method="post" action="featuredlinks_process.asp" OnSubmit="return checkform();">
	<input name="id" type="hidden" id="id" value="<%=id%>">
      <table border="1" cellspacing="0" cellpadding="1">
        <tr>
          <td><div align="right">Link</div></td>
          <td><input name="link" type="text" id="link" value="<%=link%>" style="width:100%"></td>
        </tr>
		<tr>
		  <td><div align="right">Description</div></td>
		  <td><textarea name="description" cols="60" rows="5"><%=description%></textarea></td>
		</tr>
		<tr>
		  <td><div align="right">External Feature From </div></td>
		  <td>    <input name="externalfeaturefrom" type="text" id="externalfeaturefrom" value="<%=externalfeaturefrom%>">
<img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger1">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "externalfeaturefrom",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger1",      // ID of the button	
	  showsTime   : false
    }
  );
</script>	  	  
</td>
	    </tr>
		<tr>
		  <td><div align="right">External Feature To </div></td>
		  <td><input name="externalfeatureto" type="text" id="externalfeatureto" value="<%=externalfeatureto%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger2">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "externalfeatureto",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger2",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Internal Feature From</div></td>
		  <td><input name="internalfeaturefrom" type="text" id="internalfeaturefrom" value="<%=internalfeaturefrom%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger3">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "internalfeaturefrom",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger3",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Internal Feature To </div></td>
		  <td><input name="internalfeatureto" type="text" id="internalfeatureto" value="<%=internalfeatureto%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger4"> </td>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "internalfeatureto",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger4",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
	    </tr>
		<tr>
		  <td><div align="right">RSS Update </div></td>
		  <td>Yes
		    <input name="$rssupdate" type="radio" value="-1">	      
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No
	        <input name="$rssupdate" type="radio" value="0">
          </td>
		</tr>
      </table>
      <p>
        <input name="$reset" type="reset" id="$reset" value="Reset">
        <input name="$submit" type="submit" id="$submit" value="Submit">
<%
if id <> "new" then
%>		
        <input name="$delete" type="submit" id="$delete" value="Delete">
<%
end if
%>
</p>
    </form>
</body>
</html>
<%
		set rs = nothing
		db.close
		set db = nothing
%>




