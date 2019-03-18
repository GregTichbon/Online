using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Script.Serialization;


namespace Online.TestAndPlay
{
    public partial class nestedclass1 : System.Web.UI.Page
    {
        public string json;
        protected void Page_Load(object sender, EventArgs e)
        {
            var Personlist = new List<PersonClass>();

            for (int j = 0; j < 2; j++)
            {
                var Addresslist = new List<AddressClass>();

                for (int i = 0; i < 2; i++)
                {
                    Addresslist.Add(new AddressClass()
                    {
                        Address = "Address_" + j.ToString() + "_" + i.ToString()
                    });
                }

                Personlist.Add(new PersonClass()
                {
                    Name = "Name_" + j.ToString(),
                    Age = j,
                    Address = Addresslist
                });
            }

            json = new JavaScriptSerializer().Serialize(Personlist);
            Literal1.Text = json;

            //Response.Write(json);
        }
    }
    public class PersonClass
    {
        public string Name;
        public int Age;
        public List<AddressClass> Address;
    }
    public class AddressClass
    {
        public string Address;
    }
}

