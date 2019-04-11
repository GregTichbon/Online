<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VenueFeedback.aspx.cs" Inherits="Online.Facilities.VenueFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .score {
            text-align: center;
        }

            .score:hover {
                /*background-color: #ede9e9;*/
                color: red;
                font-weight:bolder;
            }

        .selected {
            background-color: red;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "VenuefeedbackHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: []
            });

            $(".score").click(function () {
                $(this).parent().find('td').each(function () {
                    $(this).removeClass('selected');
                });
                $(this).addClass('selected');
                id = $(this).prop('id').substring(2);
                $('#hf' + id).val($(this).text());
                $('#hf' + id).valid();
            });

                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Venue Feedback</h1>

    <p>
        Thank you for choosing Whanganui Venues & Events to host your recent event. We’re passionate about events and aim to deliver an unforgettable experience to all our guests; we’d really value your feedback on how we’re doing.
    </p>
    <p>We’ve a short survey to help us understand what you expect from Whanganui Venues & Events, and how satisfied you are with the service you experienced. We encourage you to answer this short survey honestly to help us improve. </p>
    <p>
        The survey is broken into two sections; both sections cover the same factors, however in section A we are concerned with your level of satisfaction, and in Section B, the importance of each factor to you. 
    </p>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Feedback reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <label class="control-label col-sm-4" for="dd_venue">Which venue did you use?</label>
    <div class="col-sm-8">
        <select id="dd_venue" name="dd_venue" class="form-control" required>
            <option></option>
            <option>Cooks Gardens Events Centre</option>
            <option>Royal Wanganui Opera House </option>
            <option>War Memorial Centre</option>
        </select>
        <br />
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_event">The name of your event:</label>
        <div class="col-sm-8">
            <textarea id="tb_event" name="tb_event" class="form-control" rows="3" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_highlight">Before we get into the main survey, what was the highlight of your experience?</label>
        <div class="col-sm-8">
            <textarea id="tb_highlight" name="tb_highlight" class="form-control" rows="3"></textarea>
        </div>
    </div>
            <asp:Literal ID="lit_recommend" runat="server"></asp:Literal>
    <hr />

    <h3>Section A: Satisfaction</h3>

                <asp:Literal ID="lit_satisfaction" runat="server"></asp:Literal>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_additionalcomments_1">Additional comments</label>
        <div class="col-sm-8">
            <textarea id="tb_additionalcomments_1" name="tb_additionalcomments_1" class="form-control" rows="3"></textarea>
        </div>
    </div>
    <hr />
    <h3>Section B: Importance</h3>
                <asp:Literal ID="lit_importance" runat="server"></asp:Literal>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_additionalcomments_2">Additional comments</label>
        <div class="col-sm-8">
            <textarea id="tb_additionalcomments_2" name="tb_additionalcomments_2" class="form-control" rows="3"></textarea>
        </div>
    </div>
        <hr />
    <h3>Section C: Your information</h3>
    <p>Whanganui Venues & Events will use the information provided to administer the survey and to analyse aggregate trends and survey results Personal information provided may be used by Whanganui Venues & Events to communicate with you about the survey if you have provided these details. Personal information will not be shared outside of Whanganui Venues & Events. All information will be held by Whanganui Venues & Events, part of Whanganui District Council, 101 Guyton Street, and submitters have the right to access and correct personal information. </p>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_name">Your Name</label>
        <div class="col-sm-8">
            <input type="text" name="tb_name" id="tb_name" class="form-control" required />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address (if you are happy to be contacted regarding your feedback)</label>
        <div class="col-sm-8">
            <input type="email" name="tb_emailaddress" id="tb_emailaddress" class="form-control" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_phonedetails">Phone number(s) (Please enter your preferred phone number(s) if you are happy to be contacted regarding your feedback)</label>
        <div class="col-sm-8">
            <textarea id="tb_phonedetails" name="tb_phonedetails" class="form-control" rows="3"></textarea>
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
