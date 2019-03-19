using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class Transaction : System.Web.UI.Page
    {
        public string hf_person_transaction_id;
        public string dd_person_id;
        public string tb_date;
        public string tb_amount;
        public string tb_note;
        public string dd_system;
        public string tb_detail;
        public string dd_code;
        public string tb_banked;
        public string dd_event_id;


        protected void Page_Load(object sender, EventArgs e)
        {
            hf_person_transaction_id = Request.QueryString["id"] ?? "new";

            if (hf_person_transaction_id != "new")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                string sql1 = "select * from person_transaction where person_transaction_id = " + hf_person_transaction_id;

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand(sql1, con);

                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = con;

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    tb_date = Convert.ToDateTime( dr["date"]).ToString("dd/MM/yyyy");
                    tb_amount = dr["amount"].ToString();
                    tb_detail = dr["detail"].ToString();
                    tb_banked = Convert.ToDateTime(dr["banked"]).ToString("dd/MM/yyyy");
                    /*
        tb_amount;
        tb_note;
        dd_system;
        tb_detail;
        dd_code;
        tb_banked;
    */
                    dr.Close();
                    con.Close();
                    con.Dispose();
                }

            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            hf_person_transaction_id = Request.Form["hf_person_transaction_id"].Trim();
            dd_person_id = Request.Form["dd_person_id"].Trim();
            tb_date = Request.Form["tb_date"].Trim();
            tb_amount = Request.Form["tb_amount"].Trim();
            tb_note = Request.Form["tb_note"].Trim();
            dd_system = Request.Form["dd_system"].Trim();
            tb_detail = Request.Form["tb_detail"].Trim();
            dd_code = Request.Form["dd_code"].Trim();
            tb_banked = Request.Form["tb_banked"].Trim();
            dd_event_id = Request.Form["dd_event_id"].Trim();

            cmd.CommandText = "Update_Person_Transaction";

            cmd.Parameters.Add("@person_transaction_id", SqlDbType.VarChar).Value = hf_person_transaction_id;
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = dd_person_id;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = tb_date;
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = tb_amount;
            cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = tb_note;
            cmd.Parameters.Add("@system", SqlDbType.VarChar).Value = dd_system;
            cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = tb_detail;
            cmd.Parameters.Add("@code", SqlDbType.VarChar).Value = dd_code;
            cmd.Parameters.Add("@banked", SqlDbType.VarChar).Value = tb_banked; //Date
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = dd_event_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                string result = cmd.ExecuteScalar().ToString();
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