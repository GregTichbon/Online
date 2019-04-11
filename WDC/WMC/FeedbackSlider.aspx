<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeedbackSlider.aspx.cs" Inherits="Online.WMC.FeedbackSlider" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .ui-slider {
            height: 3em;
            width: 90%;
            margin: 0 auto;
        }

            .ui-slider .ui-slider-handle {
                height: 3.6em;
                width: 9em;
                margin-left: -4.5em; /* half of width*/
                border-color: red;
                text-align: center;
                padding-top: .7em;
            }

            .form-group {
    padding-top: 5px;
    padding-bottom: 5px;
}
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "bookingenquiryHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            var handle1 = $("#sliderhandle1");
            var optiontext1 = ["Difficult", "Easy"]
            $("#slider1").slider({
                value: 2,
                min: 1,
                max: 2,
                step: 1,
                create: function () {
                    handle1.html(optiontext1[$(this).slider("value") - 1]);
                },
                slide: function (event, ui) {
                    handle1.html(optiontext1[ui.value - 1]);
                }
            });

            var handle2 = $("#sliderhandle2");
            var optiontext2 = ["Poor", "Could be better", "Good", "Excellent"]
            $("#slider2").slider({
                value: 3,
                min: 1,
                max: 4,
                step: 1,
                create: function () {
                    handle2.html(optiontext2[$(this).slider("value") - 1]);
                },
                slide: function (event, ui) {
                    handle2.html(optiontext2[ui.value - 1]);
                }
            });

            var handle3 = $("#sliderhandle3");
            var optiontext3 = ["No", "Yes"]
            $("#slider3").slider({
                value: 2,
                min: 1,
                max: 2,
                step: 1,
                create: function () {
                    handle3.html(optiontext3[$(this).slider("value") - 1]);
                },
                slide: function (event, ui) {
                    handle3.html(optiontext3[ui.value - 1]);
                }
            });

            var handle4 = $("#sliderhandle4");
            var optiontext4 = ["Very dissatisfied", "Dissatisfied", "Neither satisfied nor dissatisfied", "Satisfied", "Very satisfied"]
            $("#slider4").slider({
                value: 3,
                min: 1,
                max: 5,
                step: 1,
                create: function () {
                    handle4.html(optiontext4[$(this).slider("value") - 1]);
                },
                slide: function (event, ui) {
                    handle4.html(optiontext4[ui.value - 1]);
                }
            });



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

    <div class="form-group" style="background-color:#f7e6e6"">
        <label class="control-label col-sm-4">How easy was it to book at the War Memorial Centre</label>
        <div class="col-sm-8">
            <div id="slider1">
                <div id="sliderhandle1" class="ui-slider-handle"></div>
            </div>
            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_bookingease">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_bookingease" name="tb_bookingease" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4">How was the communication from the War Memorial Centre leading up to your event</label>
        <div class="col-sm-8">
            <div id="slider2">
                <div id="sliderhandle2" class="ui-slider-handle"></div>
            </div>
            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_communication">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_communication" name="tb_communication" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group" style="background-color: #f7e6e6">
        <label class="control-label col-sm-4">Were the War Memorial Centre staff knowlegeable during your event?</label>
        <div class="col-sm-8">
            <div id="slider3">
                <div id="sliderhandle3" class="ui-slider-handle"></div>
            </div>
            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_staffknowledge">Comments</label>
        <div class="col-sm-8">
            <textarea id="tb_staffknowledge" name="tb_staffknowledge" class="form-control" rows="3"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4">How satisfied were you overall with the War Memorial Centre?</label>
        <div class="col-sm-8">
            <div id="slider4">
                <div id="sliderhandle4" class="ui-slider-handle"></div>
            </div>
            <br />
        </div>

        <label class="control-label col-sm-4" for="tb_bookingease">Comments</label>
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
