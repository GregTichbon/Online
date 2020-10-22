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
    public partial class UniformRegister : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11110001"))
            {
                Response.Redirect("~/default.aspx");
            }


            string[] optionvalues = new string[2] { "Yes", "No" };

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_uniformregister", con);

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
                        string uniform = dr["uniform"].ToString();
                        string uniformactive = dr["uniformactive"].ToString();

                        string options = "<option>--Please Select--</option>";
                        string selected = "";
                        foreach (string optionvalue in optionvalues)
                        {
                            if (optionvalue == uniformactive)
                            {
                                selected = " selected=\"selected\"";
                            }
                            else
                            {
                                selected = "";
                            }
                            options += "<option" + selected + ">" + optionvalue + "</option>";
                        }

                        html += "<tr>";
                        html += "<td><a href=\"maint.aspx?id=" + guid + "\" target=\"_blank\">" + name + "</a></td><td><textarea class=\"form-control\" id=\"uniform_" + guid + "\">" + uniform + "</textarea></td><td><select class=\"form-control\" id=\"uniformactive_" + guid + "\">" + options + "</select></td>";
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