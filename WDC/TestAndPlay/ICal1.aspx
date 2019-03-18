<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ICal1.aspx.cs" Inherits="Online.TestAndPlay.ICal1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

     

        $(document).ready(function () {

            <%= Online.WDCFunctions.WDCFunctions.testaccess() %>



        });

   

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Email Address:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_email" name="tb_email" runat="server" Width="485px">greg.tichbon@whanganui.govt.nz</asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Create/Amend Sequence:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_sequence" name="tb_sequence" runat="server">0</asp:TextBox>
        </div>
    </div>
  

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:button id="btn_submit" runat="server" onclick="btn_submit_Click" class="btn btn-info" text="Submit" />
        </div>
                
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:button id="btn_remove" runat="server" onclick="btn_remove_Click" class="btn btn-info" text="Remove" />
        </div>
                
    </div>





</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
