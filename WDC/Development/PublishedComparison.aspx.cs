using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Development
{
    public partial class PublishedComparison : System.Web.UI.Page
    {
        public string root = "C:\\Users\\gregt\\Source\\Workspaces\\OnlineServices\\Online\\Online";
        public int rootlength = 61;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request["__EVENTARGUMENT"] != null && Request["__EVENTARGUMENT"] == "move")
            {
                //int idx = lb_output.SelectedIndex;
                ListItem item = lb_output.SelectedItem;

                string filename = item.ToString();

                //
                if(filename.StartsWith("DIFFERENT: "))
                {
                    filename = filename.Substring(11);

                    //string localfile = System.IO.File.ReadAllText(root + filename);

                    //tb_output_left.Text = localfile;
                    System.IO.File.Copy(root + filename, "c:\\temp\\winmerge_local_left.txt", true);

                    string url = "";
                    if (dd_options.SelectedValue == "Online")
                    {
                        filename = "F:\\InetPub\\whanganui\\online" + filename;
                        //url = "http://wdc.whanganui.govt.nz/online/Functions/Data.asmx/GetFile?filename=" + filename;
                        url = "http://wdc.whanganui.govt.nz/online/Functions/Data.asmx/GetFile?filename=" + filename;
                    }
                    else if (dd_options.SelectedValue == "OnlineTest")
                    {
                        filename = "F:\\InetPub\\whanganui\\onlineTEST" + filename;
                        //url = "http://wdc.whanganui.govt.nz/onlinetest/Functions/Data.asmx/GetFile?filename=" + filename;
                        url = "http://wdc.whanganui.govt.nz/onlinetest/Functions/Data.asmx/GetFile?filename=" + filename;
                    }
                    else
                    { //LocalHost - Testing
                        //url = "http://localhost:39106/Functions/Data.asmx/GetFile?filename=" + filename;
                        url = "http://localhost:39106/Functions/Data.asmx/GetFile?filename=" + filename;
                    }



                    //string url = "http://wdc.whanganui.govt.nz/onlinetest/Functions/Data.asmx/GetFile?filename=" + "F:\\InetPub\\whanganui\\onlineTEST\\" + filename.Substring(1);
                    string serverfile = GetFile(url);

                    //tb_output_right.Text = serverfile;
                    using (StreamWriter writer = new StreamWriter("c:\\temp\\winmerge_sever_right.txt", false))
                    {
                        writer.Write(serverfile);
                    }


                    Process p = new Process();
                    // Redirect the output stream of the child process.
                    p.StartInfo.UseShellExecute = false;
                    p.StartInfo.RedirectStandardOutput = true;
                    p.StartInfo.FileName = "\"C:\\Program Files (x86)\\WinMerge\\WinMergeU.exe\" /s \"c:\\temp\\winmerge_local_left.txt\" \"c:\\temp\\winmerge_sever_right.txt\"";
                    p.Start();

                }


            }
            lb_output.Attributes.Add("ondblclick", ClientScript.GetPostBackEventReference(lb_output, "move"));
        }

        protected void btn_compare_Click(object sender, EventArgs e)
        {
            tb_output.Text = "";
            TraverseTree(root);
        }

        public  void TraverseTree(string root)
        {
            // Data structure to hold names of subfolders to be
            // examined for files.
            Stack<string> dirs = new Stack<string>(20);

            if (!System.IO.Directory.Exists(root))
            {
                throw new ArgumentException();
            }
            dirs.Push(root);

            while (dirs.Count > 0)
            {
                string currentDir = dirs.Pop();
                string[] subDirs;
                try
                {
                    subDirs = System.IO.Directory.GetDirectories(currentDir);
                }
                // An UnauthorizedAccessException exception will be thrown if we do not have
                // discovery permission on a folder or file. It may or may not be acceptable 
                // to ignore the exception and continue enumerating the remaining files and 
                // folders. It is also possible (but unlikely) that a DirectoryNotFound exception 
                // will be raised. This will happen if currentDir has been deleted by
                // another application or thread after our call to Directory.Exists. The 
                // choice of which exceptions to catch depends entirely on the specific task 
                // you are intending to perform and also on how much you know with certainty 
                // about the systems on which this code will run.
                catch (UnauthorizedAccessException e)
                {
                    tb_output.Text += e.Message;
                    continue;
                }
                catch (System.IO.DirectoryNotFoundException e)
                {
                    tb_output.Text += e.Message;
                    continue;
                }

                string[] files = null;
                try
                {
                    files = System.IO.Directory.GetFiles(currentDir);
                }

                catch (UnauthorizedAccessException e)
                {

                    tb_output.Text += e.Message;
                    continue;
                }

                catch (System.IO.DirectoryNotFoundException e)
                {
                    tb_output.Text += e.Message;
                    continue;
                }
                // Perform the required action on each file here.
                // Modify this block to perform your required task.

                string cd = currentDir + "                                                                      ";
                string cdp = cd.Substring(rootlength, 12);
                if (cd.Substring(rootlength, 12) != "\\TestAndPlay" && cd.Substring(rootlength, 4) != "\\SQL")
                {

                    foreach (string file in files)
                    {
                        try
                        {
                            // Perform whatever action is required in your scenario.
                            System.IO.FileInfo fi = new System.IO.FileInfo(file);
                            if(fi.Name.EndsWith(".cs"))
                            {

                            } else {
                                //tb_output.Text += "\n" + fi.FullName.Substring(61); // + ": " + fi.Length + ", " + fi.CreationTime;
                                //string localfile = System.IO.File.ReadAllText(fi.FullName);
                                string localfile = "";
                                //byte[] local = null;
                                using (var md5 = MD5.Create())
                                {
                                    using (var stream = File.OpenRead(fi.FullName))
                                    {
                                        localfile = Convert.ToBase64String(md5.ComputeHash(stream));
                                        //localfile = System.Text.Encoding.Default.GetString(md5.ComputeHash(stream));
                                    }
                                }
                 

                                string url = "";
                                string filename = "";

                                if (dd_options.SelectedValue == "Online")
                                {
                                    filename = "F:\\InetPub\\whanganui\\online" + fi.FullName.Substring(61);
                                    //url = "http://wdc.whanganui.govt.nz/online/Functions/Data.asmx/GetFile?filename=" + filename;
                                    url = "http://wdc.whanganui.govt.nz/online/Functions/Data.asmx/GetFileCheckSum?filename=" + filename;
                                }
                                else if (dd_options.SelectedValue == "OnlineTest")
                                {
                                    filename = "F:\\InetPub\\whanganui\\onlineTEST" + fi.FullName.Substring(61);
                                    //url = "http://wdc.whanganui.govt.nz/onlinetest/Functions/Data.asmx/GetFile?filename=" + filename;
                                    url = "http://wdc.whanganui.govt.nz/onlinetest/Functions/Data.asmx/GetFileCheckSum?filename=" + filename;
                                }
                                else
                                { //LocalHost - Testing
                                    filename = fi.FullName;
                                    //url = "http://localhost:39106/Functions/Data.asmx/GetFile?filename=" + filename;
                                    url = "http://localhost:39106/Functions/Data.asmx/GetFileCheckSum?filename=" + filename;
                                }

                                //string serverfile = GetFile(url);
                                string serverfile = GetFileCheckSum(url);
                                //Byte[] serverfile = GetFileCheckSum(url);
                                /*
                                if (fi.FullName.EndsWith("PublishedComparison.aspx")) {
                                    string stop = "Yes";
                                }
                                */

                                if (serverfile == "Does not exist")
                                {
                                    if (cbl_options.Items[0].Selected)
                                    {
                                        //tb_output.Text += "\n" + "NOT FOUND: " + fi.FullName.Substring(61);
                                        lb_output.Items.Add("NOT FOUND: " + fi.FullName.Substring(61));
                                    }
                                }
                                else if (localfile != serverfile)
                                {
                                    if (cbl_options.Items[1].Selected)
                                    {
                                        //tb_output.Text += "\n" + "DIFFERENT: " + fi.FullName.Substring(61);
                                        lb_output.Items.Add("DIFFERENT: " + fi.FullName.Substring(61));
                                    }
                                }
                                else if (localfile == serverfile)
                                {
                                    if (cbl_options.Items[2].Selected)
                                    {
                                        //tb_output.Text += "\n" + "OK: " + fi.FullName.Substring(61);
                                        lb_output.Items.Add("OK: " + fi.FullName.Substring(61));
                                    }
                                }


                            }

                        }
                        catch (System.IO.FileNotFoundException e)
                        {
                            // If file was deleted by a separate application
                            //  or thread since the call to TraverseTree()
                            // then just continue.
                            tb_output.Text += e.Message;
                            continue;
                        }
                    }
                }

                // Push the subdirectories onto the stack for traversal.
                // This could also be done before handing the files.
                foreach (string str in subDirs)
                    dirs.Push(str);
            }
        }

        public string GetFile(string url)
        {
            string responseText = "";
            try
            {

                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                WebHeaderCollection header = response.Headers;

                var encoding = System.Text.ASCIIEncoding.ASCII;
                using (var reader = new System.IO.StreamReader(response.GetResponseStream(), encoding))
                {
                    responseText = reader.ReadToEnd();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return responseText;

        }

        public string GetFileCheckSum(string url)
        {
            string responseText = "";
            //Byte[] responseText = { };
            try
            {


                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                WebHeaderCollection header = response.Headers;


                var encoding = System.Text.ASCIIEncoding.ASCII;
                using (var reader = new System.IO.StreamReader(response.GetResponseStream(), encoding))
                {
                    responseText = reader.ReadToEnd();
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return responseText;

        }

        protected void lb_output_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}