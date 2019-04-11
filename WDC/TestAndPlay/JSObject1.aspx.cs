using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class JSObject1 : System.Web.UI.Page
    {
        public string json;
        protected void Page_Load(object sender, EventArgs e)
        {
         
            json = "{ 'X1': { 'colour':'1', 'value': 'A', 'xtra': 'a'}" +
                    ", 'X2': {'colour':'2', 'value': 'B', 'xtra': 'b'}   }";

            /*
            var jss = new JavaScriptSerializer();


            Dictionary<string, Dictionary<string, string>> table = jss.Deserialize<Dictionary<string, Dictionary<string, string>>>(json);

            foreach (string key in table.Keys)
            {
                
                foreach (KeyValuePair<string, string> kvp in table[key])
                {
                   Response.Write(kvp.Key + "=" + kvp.Value + "<br />");
                }
            }


            Response.Write(table["X1"]["colour"]);
            */
            
            WDCFunctions.WDCFunctions wdcFunctions = new WDCFunctions.WDCFunctions();

            Dictionary<string, string> options = new Dictionary<string, string>();

            options.Clear();
            options["mode"] = "jsobject";
            options["jsobject"] = json;
            options["firstoption"] = "None";
            options["selectedoption"] = "";
            options["labelindex"] = "colour";

            string html = wdcFunctions.buildselect(options);







        }
    }
}