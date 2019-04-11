using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.General
{
    public partial class ConsentLookup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DetailsView1.Visible = true;
            GridView1.Visible = true;
            
          }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.Equals(RadioButtonList1.SelectedValue, "ram_id"))
            {
                TextBox1.Visible = true;
                TextBox2.Visible = false;
                TextBox2.Text = "";
            }
            if (string.Equals(RadioButtonList1.SelectedValue, "sphereRef"))
            {
                TextBox2.Visible = true;
                TextBox1.Visible = false;
                TextBox1.Text = "";
            }
        }
    }
}