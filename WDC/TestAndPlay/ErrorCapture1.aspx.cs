using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class ErrorCapture1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["greg"] = "xxxx";
            //try
            {   // Open the text file using a stream reader.
                using (StreamReader sr = new StreamReader("TestFile.txt"))
                {
                    // Read the stream to a string, and write the string to the console.
                    String line = sr.ReadToEnd();
                    //Console.WriteLine(line);
                }
            }
            //catch (Exception ex)
            {
                //string error = ex.InnerException.ToString();
                //Console.WriteLine("The file could not be read:");
                //Console.WriteLine(e.Message);
            }
        }
    }
}