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
    public partial class ShowAll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            int c1 = 0;
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("PH_Get_All_Photos", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@game_ctr", SqlDbType.VarChar).Value = id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    c1++;
                    if(c1 == 1)
                    {
                        Lit_Images.Text += "Photo: " + dr["Counter"] + "<br />";
                    } else if(c1 == 5)
                    {
                        c1 = 1;
                        Lit_Images.Text += "<br />Photo: " + dr["Counter"] + "<br />"; ;
                    }
                    Lit_Images.Text += "<img id=\"I_" + dr["photo_ctr"] + "\" src=\"Images\\" + dr["GUID"] + ".jpg\" title=\"Images\\" + dr["GUID"] + ".jpg\">";
                    //Lit_Images.Text += "<br />" + dr["GUID"];
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