using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace SMSChecker
{
    public partial class greg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IPAddress = "";
            String strConnString = "Data Source=192.168.10.6;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_PARAMETER", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@parameter", SqlDbType.VarChar).Value = "IPAddress";

            cmd.Connection = con;
            try
            {
                con.Open();
                //SqlDataReader dr = cmd.ExecuteReader();
                IPAddress = cmd.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                //Console.WriteLine(ex.Message);
                //Console.WriteLine(ex.InnerException);
                throw ex;
            }
            finally
            {
                con.Close();
            }
            Lit_IP.Text = "IP Address: " + IPAddress;

        }

        protected async void btn_send_Click(object sender, EventArgs e)
        {
            //Added:  Async="true"  to the page.aspx !!!
            Functions myFunctions = new Functions();
            string response = "";
            foreach (ListItem listItem in cbl_recipients.Items)
            {
                if (listItem.Selected)
                {
                    string status = await myFunctions.SendMessage(listItem.Value, tb_message.Text);
                    response += "<br />" + listItem.Value + status;
                }
                else
                {
                    //do something else 
                }
            }

            lbl_response.Text = response;
        }
    }
}