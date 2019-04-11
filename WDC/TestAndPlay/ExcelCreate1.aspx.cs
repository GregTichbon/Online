using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Excel = Microsoft.Office.Interop.Excel;

namespace Online.TestAndPlay
{
    public partial class ExcelCreate1 : System.Web.UI.Page
    {
        //Could also look at:  https://www.codebyamir.com/blog/create-excel-files-in-c-sharp 
        protected void Page_Load(object sender, EventArgs e)
        {
           
            Excel.Application xlApp = new Microsoft.Office.Interop.Excel.Application();
            if (xlApp == null)
            {
                string error = ("Excel is not properly installed!!");
            }
            Excel.Workbook xlWorkBook = xlApp.Workbooks.Add(Type.Missing);
            Excel.Worksheet xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);
            xlWorkSheet.Name = "Greg";
            xlWorkSheet.Cells[1, 1] = "ID";
            xlWorkSheet.Cells[1, 2] = "Name";
            xlWorkSheet.Cells[2, 1] = "1";
            xlWorkSheet.Cells[2, 2] = "One";
            xlWorkSheet.Cells[3, 1] = "2";
            xlWorkSheet.Cells[3, 2] = "Two";

            int r1 = 3;
            int c1 = 0;
            XmlDocument doc = new XmlDocument();
            doc.LoadXml("<table><tr><th colspan=\"A1\"><div>H1</div></th><th>H2</th></tr><tr><td colspan=\"1\"><div>1</div></td><td>2</td></tr><tr><td>3</td><td>4</td></tr></table>");

            foreach (XmlNode trnode in doc.DocumentElement.ChildNodes) //TR
            {
                r1++;
                c1 = 0;
                foreach (XmlNode tdnode in trnode.ChildNodes)  //TD
                {
                    c1++;
                    string text = tdnode.InnerText; 
                    if(tdnode.Name == "th")
                    {
                        string x = tdnode.Name;
                        xlWorkSheet.Cells[r1, c1].Font.Bold = true;
                    }
                    xlWorkSheet.Cells[r1, c1] = text;

                    string attr = tdnode.Attributes["colspan"]?.InnerText;
                }
            }




            //xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(2);
            //xlWorkSheet.Cells[1, 1] = "Sheet 2 content";

            xlWorkBook.SaveAs("exceltest1.xlsx");
            xlWorkBook.Close();
            xlApp.Quit();
           



            


        }

    }
}