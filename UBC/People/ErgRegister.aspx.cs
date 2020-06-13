using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class ErgRegister : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["UBC_person_id"] == null)
            {
                Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                Response.Redirect("~/default.aspx");
            }
            */
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_ergregister", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    while (dr.Read())
                    {
                        string person_id = dr["person_id"].ToString();
                        string guid = dr["guid"].ToString();
                        string name = dr["name"].ToString();
                        string ergnumber = dr["ergnumber"].ToString();
                        //string keyissued = dr["keyissued"].ToString();
                        //if (keyissued != "")
                        //{
                        //    keyissued = Convert.ToDateTime(keyissued).ToString("ddd dd MMM yyyy");
                        //}
                        string status = dr["status"].ToString();
                        string note = dr["note"].ToString();
                        html += "<tr id=\"key_" + guid + "\">";
                        html += "<td><a href=\"maint.aspx?id=" + guid + "\" target=\"_blank\">" + name + "</a></td><td><input field=\"ergnumber\" type=\"text\" value=\"" + ergnumber + "\" /></td><td><select field=\"status\" myvalue=\"" + status + "\"></select></td><td><input field=\"note\" type=\"text\" value=\"" + note + "\" /></td>";
                        html += "</tr>";
                    }
                }

                dr.Close();
            }

            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}