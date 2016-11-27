<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="TeOranganui.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "SearchHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Search
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_grouptype">Group type</label>
        <div class="col-sm-8">
            <select id="dd_grouptype" name="dd_grouptype" class="form-control">
                <option></option>
                <%
                    foreach (string grouptype in grouptypes)
                    {
                        Response.Write("<option>" + grouptype + "</option>");
                    }
                %>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_name">Name</label>
        <div class="col-sm-8">
            <input type="text" id="tb_name" name="tb_name" class="form-control" />
        </div>
    </div>
    <!-- Submit -->
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
