using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Vehicles
{
    public partial class DailyReminder : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable("VehicleAlerts");
            dt.Columns.Add("emailaddress", typeof(string));
            dt.Columns.Add("type", typeof(string));
            dt.Columns.Add("Due", typeof(DateTime));
            dt.Columns.Add("registration", typeof(string));
            dt.Columns.Add("description", typeof(string));


            DateTime today = DateTime.Today;
            string todayStr = today.ToString("d MMM yy");
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            string sql1 = "SELECT vehicle_CTR, registration, description, format(wofdue,'dd MMM yy') as wofdue, format(registrationdue,'dd MMM yy') as registrationdue , format(servicedue,'dd MMM yy') as servicedue , notes, email, format(holdemailtill,'dd MMM yy') as holdemailtill , mobile, format(holdmobiletill,'dd MMM yy') as holdmobiletill  from vehicle order by description, registration";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.HasRows)
            {
                html = "No Vehicles Loaded";
            }
            else
            {
                while (dr.Read())
                {
                    string WOFDueStr = dr["WOFDue"].ToString() + "";
                    if (WOFDueStr != "")
                    {
                        DateTime WOFDue = Convert.ToDateTime(WOFDueStr);
                        int daystowof = (WOFDue - today).Days;
                        if (daystowof >= -7 || daystowof == 7 || daystowof == 14)
                        {
                            string HoldEmailTillStr = dr["HoldEmailTill"].ToString() + "";

                            if (HoldEmailTillStr == "" || today >= Convert.ToDateTime(HoldEmailTillStr))
                            {
                                string[] emailaddressarray = (dr["email"] + "").Split(';');
                                foreach (string emailaddress in emailaddressarray)
                                {
                                    dt.Rows.Add(emailaddress, "WOF", WOFDue, dr["registration"] + "", dr["description"] + "");

                                }
                            }
                        }
                    }

                    string RegistrationDueStr = dr["RegistrationDue"].ToString() + "";
                    if (RegistrationDueStr != "")
                    {
                        DateTime RegistrationDue = Convert.ToDateTime(RegistrationDueStr);
                        int daystoRegistration = (RegistrationDue - today).Days;
                        if (daystoRegistration >= -7 || daystoRegistration == 7 || daystoRegistration == 14)
                        {
                            string HoldEmailTillStr = dr["HoldEmailTill"].ToString() + "";

                            if (HoldEmailTillStr == "" || today >= Convert.ToDateTime(HoldEmailTillStr))
                            {
                                string[] emailaddressarray = (dr["email"] + "").Split(';');
                                foreach (string emailaddress in emailaddressarray)
                                {
                                    dt.Rows.Add(emailaddress, "Registration", RegistrationDue, dr["registration"] + "", dr["description"] + "");

                                }
                            }
                        }
                    }

                }
                dr.Close();
            }

            con.Close();
            con.Dispose();

            string lastemailaddress = "";
            string delim = "";
            string msg = "";

            DataTable dt1 = dt.Select("emailaddress <> ''", "emailaddress").CopyToDataTable();
            foreach (DataRow row in dt1.Rows)
            {
                string emailaddress = row["emailaddress"] + "";
                //if (emailaddress != "")
                //{
                if (emailaddress != lastemailaddress && lastemailaddress != "")
                {
                    //sendemail lastemailaddress,"Vehicle Alerts<br><br>" + msg,live
                    html += "<br><br>" + lastemailaddress + "<br><br>" + msg;
                    msg = "";
                    delim = "";
                }
                msg = msg + delim + row["type"] + " due for " + row["registration"] + " - " + row["description"] + " on " + Convert.ToDateTime(row["Due"]).ToString("dd MMM yy");
                delim = "<br><br>";
                //}
                lastemailaddress = emailaddress;
            }
            if (msg != "")
            {
                //sendemail lastemailaddress,"Vehicle Alerts<br><br>" + msg,live
                html += "<br><br>" + lastemailaddress + "<br><br>" + msg;
            }

            #region oldcode
            /*
             * if request.querystring("test") = "" then
                    live = true
                else
                    live = false
                end if

                 connection_string = "Provider=SQLOLEDB;Data Source=VM29E6AC2\MSSQLSERVER2016; Initial Catalog = DataInnovations; User Id = Online; Password=Online"
                Set db = Server.CreateObject("ADODB.Connection")
                db.Open connection_string
                db.execute "truncate table VehicleAlerts"
                Set rs = Server.CreateObject("ADODB.Recordset")
                msgsql = "Select * from vehicle"' where registration = 'J224N'"

                rs.open msgsql,db
                if rs.eof then
                    response.write "No Vehicles Loaded"
                else
                    do until rs.eof
                        if rs("WOFDue") & "" <> "" then
                            daystowof = datediff("d",cdate(rs("WOFDue")),date())
                            if daystowof >= -7 or daystowof = 7 or daystowof = 14 then
                                if now() >= rs("HoldEmailTill") or rs("HoldEmailTill") & "" = "" then
                                    if not live then
                                        response.write "<br>1. " & now() & "|" & rs("HoldEmailTill") & "<br>"
                                    end if
                                    recipientarray = split(replace(rs("email") & ""," ",""),";")
                                    for each recipient in recipientarray
                                        sql = "INSERT INTO VehicleAlerts ( Email, Type, Due, Registration, Description ) " & _
                                                "SELECT '" & recipient & "', 'WOF', Vehicle.WOFDue, Vehicle.Registration, Vehicle.Description " & _
                                                "FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
                                        db.execute sql
                                        if not live then
                                            response.write "<p>" & sql & "</p>"
                                        end if
                                    next
                                end if
                                if now() >= rs("HoldMobileTill") or rs("HoldMobileTill") & "" = "" then
                                    if not live then
                                        response.write "<br>2. " & now() & "|" & rs("HoldMobileTill") & "<br>"
                                    end if
                                    recipientarray = split(replace(rs("mobile")&""," ",""),";")
                                    for each recipient in recipientarray
                                        sql = "INSERT INTO VehicleAlerts ( Mobile, Type, Due, Registration, Description ) " & _
                                                "SELECT '" & recipient & "', 'WOF', Vehicle.WOFDue, Vehicle.Registration, Vehicle.Description " & _
                                                "FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
                                        db.execute sql
                                        if not live then
                                            response.write "<p>" & sql & "</p>"
                                        end if
                                    next
                                end if
                            end if
                        end if
                        if rs("registrationDue") & "" <> "" then
                            daystoreg = datediff("d",cdate(rs("registrationDue")),date())
                            if daystoreg >= -7 or daystoreg = 7 or daystoreg = 14 then
                                if now() >= rs("HoldEmailTill") or rs("HoldEmailTill") & "" = "" then
                                    if not live then
                                        response.write "<br>3. " & now() & "|" & rs("HoldEmailTill") & "<br>"
                                    end if						
                                    recipientarray = split(replace(rs("email") & ""," ",""),";")
                                    for each recipient in recipientarray
                                        sql = "INSERT INTO VehicleAlerts ( Email, Type, Due, Registration, Description ) " & _
                                                "SELECT '" & recipient & "', 'Registration', Vehicle.registrationDue, Vehicle.Registration, Vehicle.Description " & _
                                                "FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
                                        db.execute sql
                                        if not live then
                                            response.write "<p>" & sql & "</p>"
                                        end if
                                    next
                                end if
                                if now() >= rs("HoldEmailTill") or rs("HoldEmailTill") & "" = "" then
                                    if not live then
                                        response.write "<br>4. " & now() & "|" & rs("HoldEmailTill") & "<br>"
                                    end if
                                    recipientarray = split(replace(rs("mobile") & ""," ",""),";")
                                    recipientarray = split(replace(rs("mobile") & ""," ",""),";")
                                    for each recipient in recipientarray
                                        sql = "INSERT INTO VehicleAlerts ( mobile, Type, Due, Registration, Description ) " & _
                                                "SELECT '" & recipient & "', 'Registration', Vehicle.registrationDue, Vehicle.Registration, Vehicle.Description " & _
                                                "FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
                                        db.execute sql
                                        if not live then
                                            response.write "<p>" & sql & "</p>"
                                        end if
                                    next
                                end if
                            end if
                        end if
                        rs.movenext
                    loop
                    rs.close

                    if not live then
                        sql = "select * from VehicleAlerts order by registration"
                        rs.open sql, db
                        if not rs.eof then
                            line = "<table>"
                            do until rs.eof
                                line = line & "<tr>"
                                for each fld in rs.fields
                                    line = line & "<td>" & fld & "</td>"
                                next
                                line = line & "</tr>"
                                rs.movenext
                            loop
                            line = line & "</table>"
                        end if
                        rs.close
                        response.write line
                    end if

                    sql = "select * from VehicleAlerts where isnull(email,'') <> '' order by email, due"
                    rs.open sql, db
                    if not rs.eof then
                        lastrecipient = "" 
                        delim = ""
                        msg = "Vehicle Alerts<br><br>"
                        do until rs.eof
                            if rs("email") <> lastrecipient and lastrecipient <> "" then
                                sendemail lastrecipient,msg,live
                                msg = "Vehicle Alerts<br><br>"
                                delim = ""
                            end if
                            lastrecipient = rs("email")
                            msg = msg & delim & rs("type") & " due for " & rs("registration") & " - " & rs("description") & " on " & di.di_format(rs("due"),"d mmm yyyy")
                            delim = "<br><br>"
                            rs.movenext
                        loop
                        sendemail lastrecipient,msg,live
                        rs.close
                    end if



                end if
                set rs = nothing
                db.Close
                set db = nothing

                set di = nothing





            function sendemail (email,msg,live)
            if live or 1 = 1 then
                Set objMail = Server.CreateObject("CDONTS.NewMail")
                objMail.To = email
                objMail.From = "greg@datainn.co.nz" '"gtichbon@teorahou.org.nz"
                objMail.Subject = "Vehicle updates: " & di.di_format(date(),"d mmmm yyyy")
                objMail.Body = "<p>" & msg & "</p><p><a href=""http://datainn.co.nz/vehiclereminders"">Vehicle Reminders</a></p>"
                objMail.MailFormat = 0
                objMail.BodyFormat = 0
                objMail.Send
                Set objMail = Nothing
                response.write "<br>Email sent to: " & email & "<br>"
            else
                response.write email & "-" & msg & "<br>______________________________________________<br>"
            end if
            end function
            */
            #endregion

        }

        public Boolean testdate(string date1, string date2)
        {
            return false;
        }
    }
}
