using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace TOHW.Database
{
    public partial class Main2 : System.Web.UI.Page
    {
        public int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IDS"] == null)
            {
                Response.Redirect("Search.aspx");
            }
            id = Convert.ToInt16(Session["IDS"]);
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Entity", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    tb_surname.Text = dr["Surname"].ToString();
                    tb_firstname.Text = dr["firstname"].ToString();
                    tb_knownas.Text = dr["knownas"].ToString();
                    tb_othernames.Text = dr["othernames"].ToString();
                    dd_gender.SelectedValue = dr["gender"].ToString();


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