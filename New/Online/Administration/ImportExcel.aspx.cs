using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using Excel = Microsoft.Office.Interop.Excel;

namespace Online.Administration
{
    public partial class ImportExcel : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_import_Click(object sender, System.EventArgs e)
        {
            string[] headers = new string[9] { "FieldName", "Type", "Title", "DBType", "MaxLength", "Mandatory", "Choices", "ReadOnly", "Notes" };

            /*
             type: text, textarea, dropdown, checkbox, file, radio
             dbtype: varchar, bigint
             choices: dropdown, checkbox, radio options
             */

            Excel.Application xlApp;
            Excel.Workbook xlWorkBook;
            Excel.Worksheet xlWorkSheet;
            Excel.Range range;

            string str;
            int rCnt = 0;
            int cCnt = 0;

            string path = Server.MapPath(".");

            xlApp = new Excel.Application();
            xlWorkBook = xlApp.Workbooks.Open(path + "\\fields.xlsx", 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
            xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);

            range = xlWorkSheet.UsedRange;

            for (cCnt = 1; cCnt <= range.Columns.Count; cCnt++)
            {
                str = (string)(range.Cells[1, cCnt] as Excel.Range).Value2;
                if (str != headers[cCnt - 1])
                {
                    //error - column cCnt is str but should be headers[cCnt - 1]
                }
            }

            for (rCnt = 2; rCnt <= range.Rows.Count; rCnt++)
            {
                for (cCnt = 1; cCnt <= range.Columns.Count; cCnt++)
                {
                    str = (string)(range.Cells[rCnt, cCnt] as Excel.Range).Value2;
                    //MessageBox.Show(str);
                }
            }

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
