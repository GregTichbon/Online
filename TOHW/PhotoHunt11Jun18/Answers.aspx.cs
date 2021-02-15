using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace TOHW.PhotoHunt11Jun18
{
    public partial class Answers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("PH_Show_Answers", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@game_ctr", SqlDbType.VarChar).Value = id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()) 
                {
                    Lit_Answers.Text += "<tr>";
                    Lit_Answers.Text += "<td>" + dr["name"] + " (" + dr["code"] + ")</td>";
                    Lit_Answers.Text += "<td>" + dr["Counter"] + "</td>";
                    Lit_Answers.Text += "<td>" + dr["Description"] + "</td>";
                    Lit_Answers.Text += "<td>" + dr["Version"] + "</td>";
                    Lit_Answers.Text += "<td>" + dr["Answered"] + "</td>";
                    if(dr["Answered"].ToString() == "Yes")
                    {
                        Lit_Answers.Text += "<td><a class=\"showphotos\" data-groupcode=\"" + dr["code"] + "\" data-photo=\"" + dr["photo_ctr"] + "\" href=\"javascript:void(0)\">Photos</a></td>";
                    } else
                    {
                        Lit_Answers.Text += "<td>&nbsp;</td>";
                    }
                    Lit_Answers.Text += "</tr>";
                    //dr["guid"].ToString() + ".jpg";

                }
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