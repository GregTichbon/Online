<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="Online.FoodStallLicence.Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            Location(s)
            <br>
            <a class="action_location">Add</a>
        </label>
        <div class="col-sm-8">
            <input id="clientsideonly_hf_location" name="clientsideonly_hf_location" value="1" aria-invalid="false" class="valid" type="hidden">
            <table id="table_location" style="width: 100%;">
                <tbody>
                    <tr style="display: none">
                        <td></td>
                    </tr>
                    <tr data-line="2">
                        <td>
                            <input readonly="readonly" style="width:80%" id="repeat_locations_tb_location_2" name="repeat_locations_tb_location_2" class="form_control col-sm-8 valid" value="fdsfsd" aria-invalid="false" type="text">
                            <input id="repeat_locations_hf_locationcoords_2" name="repeat_locations_hf_locationcoords_2" value="-39.9330677,175.04865760000007,15,-39.931373503781806,175.0483500404696,-39.93308470245229,175.05371445849937,-39.92775351947411,175.05337113574546" type="hidden">
                            <a class="action_location" data-line="2">Edit</a>
                            <a class="action_location" data-line="2">Delete</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
