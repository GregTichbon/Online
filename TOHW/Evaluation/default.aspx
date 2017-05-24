<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TOHW.Evaluation._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_groupname">Group name</label><div class="col-sm-8">
            <input id="tb_groupname" name="tb_groupname" type="text" class="form-control" required />
        </div>
    </div>
</asp:Content>
