using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class jay1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Dictionary<string, string> myDic = new Dictionary<string, string>(2);

            using (StreamReader r = new StreamReader("c:\\temp\\crms.json"))
            {
                string json = r.ReadToEnd();
                dynamic array = JsonConvert.DeserializeObject(json);

                foreach (dynamic item in array)
                {
                    myDic.Clear();
                    foreach (var field in item.FieldList)
                    {
                        string FieldName = field["fieldName"];
                        string FieldValue = field["fieldValue"];
                        myDic.Add(FieldName, FieldValue);
                    }
                }
            }
        }
    }
}