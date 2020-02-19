<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="SurveySep2018.aspx.cs" Inherits="UBC.SurveySep2018" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container" style="background-color: #FCF7EA">
        <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />
        <h1>Union Boat Club - Learn to Row Survey
        </h1>
        <p>
            Thanks for taking part in this short survey.
        </p>
        <p>
            The Union Boat Club wants to give the best possible opportunities to school rowers.&nbsp; Your feedback is important to us.
        </p>
        <p>
            &nbsp;
        </p>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_firstname">First name</label>
            <div class="col-sm-8">
                <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" maxlength="20" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_knownas">Known as</label>
            <div class="col-sm-8">
                <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" maxlength="20" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
            <div class="col-sm-8">
                <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" maxlength="20" required />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_gender">Gender</label>
            <div class="col-sm-8">
                <select id="dd_gender" name="dd_gender" class="form-control" required>
                    <%= Generic.Functions.populateselect(gender, "","None") %>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_school">School</label>
            <div class="col-sm-8">
                <select id="dd_school" name="dd_school" class="form-control" required>
                    <%= Generic.Functions.populateselect(school, "","") %>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_schoolyear">School year</label>
            <div class="col-sm-8">
                <input id="tb_schoolyear" name="tb_schoolyear" type="text" class="form-control numeric" required maxlength="2" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_notes">Notes</label>
            <div class="col-sm-8">
                <textarea id="tb_notes" name="tb_notes" class="form-control"></textarea>
            </div>
        </div>
    </div>

</asp:Content>
