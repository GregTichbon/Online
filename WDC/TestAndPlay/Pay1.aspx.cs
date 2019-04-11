using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class Pay1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string reference = Request.QueryString["reference"];

            List<paymentdetailsClass> paymentdetails = new List<paymentdetailsClass>();


            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            //check whether they have created a groupdetails record for the current submissionperiod - read above:  WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];

            SqlCommand cmd = new SqlCommand("Get_Payment_Request", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;
            

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    paymentdetails.Add(new paymentdetailsClass
                    {
                        Amount = dr["Amount"].ToString(),
                        Description = dr["Description"].ToString()
                    });
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

            Lit_Details.Text = "You owe $" + paymentdetails[0].Amount.ToString() + " for " + paymentdetails[0].Description.ToString();

            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(paymentdetails);

            //Context.Response.Write(passresult);
        }
    }
    #region classes
    public class paymentdetailsClass
    {
        public string Amount;
        public string Description;
    }
    #endregion
}