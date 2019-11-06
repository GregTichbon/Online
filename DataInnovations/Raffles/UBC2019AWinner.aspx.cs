using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class UBC2019AWinner : System.Web.UI.Page
    {
        public string guid;
        public string name;
        public string mobile;
        public string email;
        public string ticketnumber;
        public string greeting;
        public string winnerresponse;
        public string winnernote;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string winnerstatus = "";

                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                guid = Request.QueryString["id"] ?? "";

                SqlConnection con = new SqlConnection(strConnString);
                con.Open();

                SqlCommand cmd1 = new SqlCommand("select * from raffleticket where guid = '" + guid + "'", con);
                //cmd1.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                cmd1.CommandType = CommandType.Text;
                cmd1.Connection = con;

                try
                {

                    SqlDataReader dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        name = dr["purchaser"].ToString();
                        mobile = dr["mobile"].ToString();
                        email = dr["emailaddress"].ToString();
                        ticketnumber = dr["ticketnumber"].ToString();
                        greeting = dr["greeting"].ToString();
                        winnerstatus = dr["winnerstatus"].ToString();
                        winnerresponse = dr["winnerresponse"].ToString();
                        winnernote = dr["winnernote"].ToString();
                    }

                    dr.Close();
                }

                catch (Exception ex)
                {
                    throw ex;
                }

                switch (winnerstatus)
                {
                    case "Winner":
                        break;
                    case "Ordered":
                        break;
                    case "Closed":
                        Session["raffleMessage"] = "Sorry, we have already processed your selection of: " + winnerresponse;
                        Response.Redirect("UBC2019AMessage.aspx");
                        break;
                    case "Collected":
                        Session["raffleMessage"] = "Sorry, we have already processed your selection and delivered it.";
                        Response.Redirect("UBC2019AMessage.aspx");
                        break;
                    default:
                        Session["raffleMessage"] = "Sorry, something has gone wrong.";
                        Response.Redirect("UBC2019AMessage.aspx");
                        break;
                }

            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

           
            cmd.CommandText = "Update_Raffle_Winner";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = Request.Form["hf_guid"].ToString();

            cmd.Parameters.Add("@purchaser", SqlDbType.VarChar).Value = Request.Form["tb_name"].ToString().Trim();
            cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = Request.Form["tb_mobile"].ToString().Trim();
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = Request.Form["tb_emailaddress"].ToString().Trim();
            cmd.Parameters.Add("@winnerresponse", SqlDbType.VarChar).Value = Request.Form["selection"].ToString().Trim();
            cmd.Parameters.Add("@winnernote", SqlDbType.VarChar).Value = Request.Form["tb_comments"].ToString().Trim();


            cmd.Connection = con;
            //try
            //{
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

            
            //finally
            //{

            con.Dispose();
            //}

            Generic.Functions gFunctions = new Generic.Functions();
            string messageresponse = gFunctions.SendRemoteMessage("0272495088", Request.Form["tb_name"].ToString().Trim() + " has submitted her selection", "Raffle Winner Response");


            Session["raffleMessage"] = "Thanks for that, we'll be in contact shortly to arrange delivery.";
            Response.Redirect("UBC2019AMessage.aspx");


        }
    }
}