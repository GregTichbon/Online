<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnquiryFeedback.aspx.cs" Inherits="Online.Facilities.EnquiryFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .score {
            text-align: center;
        }

            .score:hover {
                /*background-color: #ede9e9;*/
                color: red;
                font-weight: bolder;
            }

        .selected {
            background-color: red;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "EnquiryfeedbackHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

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
    <h1>Enquiry Feedback</h1>

    <p>
        Thank you for your recent enquiry with Whanganui Venues & Events.
    </p>
    <p>We're sorry we weren't able to have the pleasure of hosting your event, and hope it was a complete success for you. </p>
    <p>
        We're passionate about events and aim to deliver an unforgettable experience to all our guests; we'd really value your feedback to learn why we weren't successful on this occasion, so that we can improve our services for future customers. 
    </p>
    <p>We encourage you to answer this short survey honestly to help us improve.</p>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Feedback reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_venue">Which venue did you enquire about?</label>
        <div class="col-sm-8">
            <input type="checkbox" id="cb_cg" name="cb_venue" value="Cooks Gardens Events Centre" />
            Cooks Gardens Events Centre<br />
            <input type="checkbox" id="cb_oh" name="cb_venue" value="Royal Wanganui Opera House" />
            Royal Wanganui Opera House<br />
            <input type="checkbox" id="cb_wmc" name="cb_venue" value="War Memorial Centre" />
            War Memorial Centre
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_highlight">Before we get into the main questions, what was the highlight of your experience?</label>
        <div class="col-sm-8">
            <textarea id="tb_highlight" name="tb_highlight" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_number1factor">What was the number 1 factor you based your decision on?</label>
        <div class="col-sm-8">
            <textarea id="tb_number1factor" name="tb_number1factor" class="form-control" rows="3"></textarea>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_tailoring">How well did we do in tailoring our service to your needs?</label>
        <div class="col-sm-8">
            <textarea id="tb_tailoring" name="tb_tailoring" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_references">If you talked to any references about our service, what did they have to say? </label>
        <div class="col-sm-8">
            <textarea id="tb_references" name="tb_references" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_team">What was your experience with our team?</label>
        <div class="col-sm-8">
            <textarea id="tb_team" name="tb_team" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_venue">Which venue hosted your event?</label>
        <div class="col-sm-8">
            <textarea id="tb_venue" name="tb_venue" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_services">What services or solutions did the successful venue offer that were better alternatives to ours?</label>
        <div class="col-sm-8">
            <textarea id="tb_services" name="tb_services" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_advise">What's the one thing you would advise us to change for next time? </label>
        <div class="col-sm-8">
            <textarea id="tb_advise" name="tb_advise" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_additional">Additional Comments:</label>
        <div class="col-sm-8">
            <textarea id="tb_additional" name="tb_additional" class="form-control" rows="3"></textarea>
        </div>
    </div>
    <asp:Literal ID="lit_recommend" runat="server"></asp:Literal>
    <hr />




    <h3>Your information</h3>
    <p>If you would like to be contacted regarding your feedback please let us know your details below</p>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_name">Your Name</label>
        <div class="col-sm-8">
            <input type="text" name="tb_name" id="tb_name" class="form-control" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
        <div class="col-sm-8">
            <input type="email" name="tb_emailaddress" id="tb_emailaddress" class="form-control" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_phonedetails">Phone number(s) (Please enter your preferred phone number(s))</label>
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
