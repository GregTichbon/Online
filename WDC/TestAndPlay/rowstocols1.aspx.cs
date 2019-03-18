using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class rowstocols1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string input = "";
            List<string> Lines = new List<string>();
            string header = "";
            string detail = "";

            int f1;
            int f2;
            int f3;

            string lDate;
            string lAddress1;
            string lAddress2;
            string lAddress3;
            string lAddress4;
            string lAddress5;
            string lAddress6;
            string lClientno;
            string lDogno;
            string lDogname;

            using (StreamReader sr = new StreamReader(@"C:\_GregDevelopment\OnlineServices\Online\Online\TestAndPlay\rowtocols1Input.txt"))
            {
                while ((input = sr.ReadLine()) != null)
                {
                    if (input == "\f")
                    {
                        header = Lines[0];

                        for (f1 = 1; f1 < Lines.Count; f1++)
                        {
                            if (Lines[f1].All(char.IsDigit) && Lines[f1 + 1].All(char.IsDigit))
                            {
                                break;
                            }
                        }

                        for (f3 = 1; f3 < f1; f3++)
                        {
                            header += "|" + Lines[f3];
                        }

                        int pad = 8 - f1;
                        for (f3 = 1; f3 < pad; f3++)
                        {
                            header += "|";
                        }

                        header += "|" + Lines[f1]; //Client number

                        int numdogs = (Lines.Count - f1 - 1 - 1) / 9;
                        for (f2 = 1; f2 <= numdogs; f2++)
                        {
                            detail = Lines[f1];  //Client number
                            int startofdetail = (f2 - 1) * 9 + 6;
                            for (f3 = startofdetail; f3 < startofdetail + 9; f3++)
                            {
                                detail += "|" + Lines[f3];
                            }
                            string x = detail;
                        }
                        header += "|" + Lines[Lines.Count-1];

                        Lines.Clear();

                    }
                    else
                    {

                        Lines.Add(input);
                    }

                }
            }

        }
    }
}