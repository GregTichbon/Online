using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Excel = Microsoft.Office.Interop.Excel;

namespace Online.Administration
{
    public partial class BankBranchImport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Excel.Application xlApp;
            Excel.Workbook xlWorkBook;

            string path = Server.MapPath(".");

            xlApp = new Excel.Application();
            xlWorkBook = xlApp.Workbooks.Open(path + "\\Bank_Branch_Register.xls", 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);


            foreach (Excel.Worksheet worksheet in xlApp.Worksheets)
            {

                //dd_name.Items.Add(worksheet.Name);
                string xx = worksheet.Name;
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            Excel.Application xlApp;
            Excel.Workbook xlWorkBook;
            Excel.Worksheet xlWorkSheet;
            Excel.Range range;

            string path = Server.MapPath(".");

            xlApp = new Excel.Application();
            xlWorkBook = xlApp.Workbooks.Open(path + "\\Bank_Branch_Register.xls", 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);

            string tablename = "Q___All_Bank_Branch_Data";
            xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(tablename);

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            int x = 0;
            con = new SqlConnection(strConnString);
            /*


            SqlCommand cmd = new SqlCommand("Clear_Bank_Branch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();
            x = cmd.ExecuteNonQuery();

            */

            SqlCommand cmd2 = new SqlCommand("Add_Bank_Branch", con);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Connection = con;
            con.Open();

            range = xlWorkSheet.UsedRange;
            int rCnt = 0;
            for (rCnt = 2; rCnt <= range.Rows.Count; rCnt++)
            {
                string Bank_Code = (range.Cells[rCnt, 1] as Excel.Range).Value2;
                string Bank_Name = (range.Cells[rCnt, 5] as Excel.Range).Value2;
                string Branch_Code = (range.Cells[rCnt, 2] as Excel.Range).Value2;
                string Branch_Name = (range.Cells[rCnt, 6] as Excel.Range).Value2;

                cmd2.Parameters.Clear();
                cmd2.Parameters.Add("@Bank_Code", SqlDbType.VarChar).Value = Bank_Code;
                cmd2.Parameters.Add("@Bank_Name", SqlDbType.VarChar).Value = Bank_Name;
                cmd2.Parameters.Add("@Branch_Code", SqlDbType.VarChar).Value = Branch_Code;
                cmd2.Parameters.Add("@Branch_Name", SqlDbType.VarChar).Value = Branch_Name;

                cmd2.Connection = con;
                //con.Open();
                x = cmd2.ExecuteNonQuery();

            }

            con.Close();
            con.Dispose();



            xlWorkBook.Close(true, null, null);
            xlApp.Quit();

            releaseObject(xlWorkSheet);
            releaseObject(xlWorkBook);
            releaseObject(xlApp);
        }
        private void releaseObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
                obj = null;
            }
            catch (Exception ex)
            {
                obj = null;
                //MessageBox.Show("Unable to release the Object " + ex.ToString());
            }
            finally
            {
                GC.Collect();
            }
        }
    }
}
 