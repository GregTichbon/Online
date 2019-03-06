<%
sConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$generic\incedo\incedo.mdb"
set conn = Server.CreateObject("ADODB.Connection")
set cmd = Server.CreateObject("ADODB.Command")
set rs = Server.CreateObject("ADODB.Recordset")
conn.open sConnString
set cmd.activeconnection = conn
%>
