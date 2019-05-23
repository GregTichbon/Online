using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using QRCoder;
using System.Data.SqlClient;
using System.Data;

namespace DataInnovations.Raffles
{
    public partial class UBC2019AWinnerVoucher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string folder = Server.MapPath("~\\raffles\\images");
            string sourceImage = folder + "\\ChefsChoiceWinningTicket2019A.jpg";
            
            ImageFormat fmt = ImageFormat.Jpeg;

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            string sql = @"select R.identifier, T.purchaser, t.TicketNumber, w.guid, W.Draw, W.drawndate
                from RaffleWinner W
                inner join raffleticket T on T.RaffleTicket_ID = W.RaffleTicket_ID
                inner join Raffle R on R.Raffle_ID = T.Raffle_ID where isnull(W.status,'') = 'Winner'
                order by isnull(winnerstatus,'') desc, R.identifier, w.Draw";

            SqlCommand cmd1 = new SqlCommand(sql, con);
            //cmd1.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

            cmd1.CommandType = CommandType.Text;
            cmd1.Connection = con;

            try
            {
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string name = dr["purchaser"].ToString();
                        //mobile = dr["mobile"].ToString();
                        //email = dr["emailaddress"].ToString();
                        string ticketnumber = dr["ticketnumber"].ToString();
                        string guid = dr["guid"].ToString();
                        string identifier = dr["identifier"].ToString();
                        string draw = dr["draw"].ToString();
                        string drawndate = "";
                        if (dr["drawndate"] != DBNull.Value)
                        {
                            drawndate = Convert.ToDateTime(dr["drawndate"]).ToString("dd MMM yy");
                        }
                        //greeting = dr["greeting"].ToString();
                        //winnerstatus = dr["winnerstatus"].ToString();
                        //winnerresponse = dr["winnerresponse"].ToString();
                        //winnernote = dr["winnernote"].ToString();
                        //string text = name + Environment.NewLine + "Ticket: " + identifier + " - " + ticketnumber;

                        string text = "Ticket: " + identifier + "/" + ticketnumber + " " + name;

                        string targetImage = folder + "\\vouchers\\" + guid + ".jpg";
                        Response.Write(name + " " + identifier + " " + ticketnumber + " <a href=\"" + targetImage + "\">" + targetImage + "</a><br />");


                        QRCodeGenerator qrGenerator = new QRCodeGenerator();
                        QRCodeData qrCodeData = qrGenerator.CreateQrCode("http://office.datainn.co.nz/raffles/UBC2019Avoucher.aspx?id=" + guid, QRCodeGenerator.ECCLevel.Q);
                        QRCode qrCode = new QRCode(qrCodeData);
                        Bitmap qrCodeImage = qrCode.GetGraphic(20);

                        Bitmap resized = new Bitmap(qrCodeImage, new Size(Convert.ToInt16(qrCodeImage.Width * .85), Convert.ToInt16(qrCodeImage.Height * .85)));

                        using (System.Drawing.Image image = System.Drawing.Image.FromFile(sourceImage))

                        using (Graphics imageGraphics = Graphics.FromImage(image))
                        using (TextureBrush watermarkBrush = new TextureBrush(resized))
                        {
                            int x = 1400; // (image.Width / 2 - resized.Width / 2);
                            int y = 1350; // (image.Height / 2 - resized.Height / 2) + 200;
                            watermarkBrush.TranslateTransform(x, y);
                            imageGraphics.FillRectangle(watermarkBrush, new Rectangle(new Point(x, y), new Size(resized.Width + 1, resized.Height)));

                            using (Font Font = new Font("Arial", 26))
                            {
                                float textwidth = imageGraphics.MeasureString(text, Font, 0, StringFormat.GenericTypographic).Width;
                                x = (image.Width / 2 - Convert.ToInt16(textwidth) / 2);
                                y = 1200;
                                imageGraphics.DrawString(text, Font, Brushes.Blue, x, y);
                            }

                            using (Font Font = new Font("Arial", 26))
                            {
                                float textwidth = imageGraphics.MeasureString(text, Font, 0, StringFormat.GenericTypographic).Width;
                                x = 1300;
                                y = 50;
                                imageGraphics.DrawString("Draw " + draw + " - " + drawndate, Font, Brushes.Yellow, x, y);
                            }


                            image.Save(targetImage);
                        }
                    }
                }
                dr.Close();
            }

            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}