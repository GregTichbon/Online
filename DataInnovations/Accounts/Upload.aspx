<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="DataInnovations.Accounts.Upload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
   <div class="container" style="background-color: #FCF7EA">

        <h1>Upload
        </h1>

        <div class="form-group">
            <div class="col-sm-4">
                Please upload the bank file
            </div>
            <div class="col-sm-8">
                <asp:FileUpload ID="fu_bankfile" runat="server" AllowMultiple="True" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
                What format is it
            </div>
            <div class="col-sm-8">
                <asp:DropDownList ID="dd_format" runat="server">
                    <asp:ListItem Selected="True">ANZ - TSV</asp:ListItem>
                </asp:DropDownList>

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>

    </div>
    </form>
</body>
</html>
