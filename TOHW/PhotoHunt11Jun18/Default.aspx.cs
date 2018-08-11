using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.PhotoHunt11Jun18
{
    public partial class Default : System.Web.UI.Page
    {
        public string groupcode;
        protected void Page_Load(object sender, EventArgs e)
        {
            groupcode = Request.QueryString["id"];
            if(groupcode == null)
            {
                groupcode = "";
            }
            //int bm = 0;

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("PH_Get_Group_Photos", con);
            cmd.Parameters.Add("@GroupCode", SqlDbType.VarChar).Value =  groupcode; //1111; //

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    //bm++;
                    //Lit_Images.Text += "<span id=\"" + bm.ToString() + "\"></span>";

                    Lit_Images.Text += "<br /><img id=\"I_" + dr["photo_cnt"] + "\" src=\"Images\\" + dr["GUID"] + ".jpg\" title=\"Images\\" + dr["GUID"] + ".jpg\">";
                    Lit_Images.Text += "<br />Photo: " + dr["counter"] + ". &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    Lit_Images.Text += "Your current version: <span id=\"V_" + dr["photo_cnt"] + "\">" + dr["version"] + "</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    if (dr["answered"].ToString() == "Yes")
                    {
                        Lit_Images.Text += "Answered";
                    }
                    else
                    {
                        if (Convert.ToInt16(dr["version"]) > 1 && 1 == 2)
                        {
                            Lit_Images.Text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class=\"show\" id=\"B_" + dr["photo_cnt"] + "\" href=\"javascript:void(0)\">Show the previous version</a>";
                        }

                        if (dr["version"].ToString() != "4")
                        //if (dr["answered"].ToString() != "Yes" && dr["version"].ToString() != "4")
                        {
                            Lit_Images.Text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class=\"show\" id=\"P_" + dr["photo_cnt"] + "\" href=\"javascript:void(0)\">Show the next version</a>";
                        }
                        //Lit_Images.Text += " <a href=\"answer.aspx?group=" + groupcode + "&photo=" + dr["photo_cnt"] + "\" target=\"photohuntanswer\">Answer</a>";
                        Lit_Images.Text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0);\" class=\"answer\" data-groupcode=\"" + groupcode + "\" data-photo=\"" + dr["photo_cnt"] + "\">Answer</a>";
                    }
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