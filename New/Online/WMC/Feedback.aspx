<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Online.WMC.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-group {
            padding-top: 5px;
            padding-bottom: 5px;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "feedbackHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });





        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>War Memorial Centre Feedback
    </h1>




    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Feedback reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_event">What event are you feeding back on?</label>
        <div class="col-sm-8">
            <textarea id="tb_event" name="tb_event" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group" style="background-color: #f7e6e6">
        <label class="control-label col-sm-4" for="dd_feecharged">How easy was it to book at the War Memorial Centre</label>
        <div class="col-sm-8">
            <select id="dd_bookingease" name="dd_bookingease" class="form-control" required>
                <option></option>
                <option>Difficult</option>
                <option>Easy</option>



            </select>
            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_bookingease">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_bookingease" name="tb_bookingease" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_comunications">How was the communication from the War Memorial Centre leading up to your event</label>
        <div class="col-sm-8">
            <select id="dd_comunications" name="dd_comunications" class="form-control" required>
                <option></option>
                <option>Poor</option>
                <option>Could be better</option>
                <option>Good</option>
                <option>Excellent</option>
            </select>

            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_communication">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_communication" name="tb_communication" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group" style="background-color: #f7e6e6">
        <label class="control-label col-sm-4" for="dd_staffknowledge">Were the War Memorial Centre staff knowlegeable during your event?</label>
        <div class="col-sm-8">
            <select id="dd_staffknowledge" name="dd_staffknowledge" class="form-control" required>
                <option></option>
                <option>No</option>
                <option>Yes</option>

            </select>

            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_staffknowledge">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_staffknowledge" name="tb_staffknowledge" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_overallexperience">How satisfied were you overall with the War Memorial Centre?</label>
        <div class="col-sm-8">
            <select id="dd_overallexperience" name="dd_overallexperience" class="form-control" required>
                <option></option>
                <option>Very dissatisfied</option>
                <option>Dissatisfied</option>
                <option>Neither satisfied nor dissatisfied</option>
                <option>Satisfied</option>
                <option>Very satisfied</option>
            </select>
            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_overallexperience">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_overallexperience" name="tb_overallexperience" class="form-control" rows="3"></textarea>
        </div>
    </div>



    <div class="form-group" style="background-color: #f7e6e6">
        <label class="control-label col-sm-4" for="tb_othercomments">Please feel free to make any other comments you wish</label>
        <div class="col-sm-8">
            <textarea id="tb_othercomments" name="tb_othercomments" class="form-control" rows="3"></textarea>
        </div>
    </div>



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
