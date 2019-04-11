using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class PrintPDF1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            string strCommand;
            strCommand = "print -D:\"\\\\wdc-Print.local.wanganui.govt.nz\\REC-FX3375\" \"test.pdf\"";
            System.Diagnostics.Process.Start("CMD.exe", strCommand);
            */
            /*
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            Boolean result = WDCFunctions.Print("c:\\users\\gregt\\test.pdf", "\\\\wdc-Print.local.wanganui.govt.nz\\REC-FX3375");
            */
            string file = "E:\\inetpub\\Intranet\\_Greg\\test.pdf";
            string printer = "\\\\wdc-Print.local.wanganui.govt.nz\\REC-FX3375";
            try
            {
                Process.Start(
                   Registry.LocalMachine.OpenSubKey(
                        @"SOFTWARE\Microsoft\Windows\CurrentVersion" +
                        @"\App Paths\AcroRd32.exe").GetValue("").ToString(),
                   string.Format("/h /t \"{0}\" \"{1}\"", file, printer));
            }
            catch { }
        }
    }
}