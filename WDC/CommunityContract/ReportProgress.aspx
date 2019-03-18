<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportProgress.aspx.cs" Inherits="Online.CommunityContract.ReportProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .inject {
            color: red;
            font-size:large;
        }
    </style>
    <script type="text/javascript">
        var location_maxline = 0;

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "ReportProgressHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
            <% if (viewmode == "readonly")
        { %>

            $(':input').attr('readonly', 'readonly');
            $('select').attr("disabled", true);
            $('.readonlyinvisible').hide();

           <%}
        else
        {%>


            $("#form1").validate({
                ignore: []
            });

            $(".inject").bstooltip();

            var inject_id;

            $(".inject").click(function () {
                inject_id = $(this).attr("id");
                $("#dialog-text").html($(this).data("shortprompt"));
                $("#inject_response").val($(this).data('value'));
                $("#dialog-inject").dialog("open");
            });
            $("#dialog-inject").dialog({
                autoOpen: false,
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "Update": function () {
                        if ($('#item_' + inject_id).val() != $('#inject_response').val()) {
                            $('#' + inject_id).text($('#inject_response').val())
                            $('#item_' + inject_id).val($('#inject_response').val());
                            $('#text_' + inject_id).text($('#inject_response').val());
                            var inject_id_parts = inject_id.split('_');
                            key = inject_id_parts[1];
                            $('#line_response_' + key).val($('#response_' + key).text());
                            $('#form1').addClass('mydirty');
                        }
                        $(this).dialog("close");
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });
            <%}%>

            var verifysubmit = true;
            $('.btn_submit').click(function (event) {
                saveData('Submit');
                if (verifysubmit) {
                    event.preventDefault()
                    //alert($("#form1").valid());
                    //$('form').submit(function (e) {
                    if ($("#form1").valid() == true) {
                        if ($("#dd_finalised").val() == "No") {
                            msg = "You have chosen not to finalise this report.  You can continue to update it until the closing date, but it must be finalised by this date to be accepted by the Council.";
                        } else {
                            msg = "You have chosen to finalise this report.  This means that you will no longer be able to continue to update it.";
                        }
                        $("#dialog-message").html(msg);
                        $("#dialog-message").dialog({
                            resizable: true,
                            height: 300,
                            modal: true,
                            buttons: {
                                "Continue": function () {
                                    $(this).dialog("close");
                                    verifysubmit = false;
                                    $('.btn_submit').click();
                                },
                                Cancel: function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    }
                }
            });

            $('#btn_save').on('click', function (e) {
                $("#dd_finalised").val('No');
                saveData('Save');
            });

            var myIsDirty = function ($node, index) {
                if ($node.is('form')) {
                    // Return true if the form is currently dirty.
                    return $node.hasClass('mydirty');
                }
            }

            $('form').dirtyForms({
                helpers: [
                    {
                        isDirty: myIsDirty
                    }
                ]
            });




        }); //document.ready




<% if (viewmode != "readonly")
        { %>
        function saveData(mode) {
            var dofiles = false;
            if (mode == "Save") {
                $("#div_processing").show();
            }

            var deletefile = [];
            $("[id^='cb_deletefile_']").each(function (index) {
                //alert($(this).val() + '=' + this.checked);
                if (this.checked) {
                    //alert(1);
                    deletefile.push($(this).val());
                }
            });
            $("#hf_deletefile").val(deletefile);
            //alert(deletefile);

            var files = $("#fu_files").get(0).files;

            if (files.length > 0) {
                dofiles = true;
                //alert('SAVE FILES');
                savefiles(files);
            }

            //alert($('#form1').dirtyForms('isDirty'));
            //if ($('form:dirty').dirtyForms('isDirty') == true) {
            if ($('#form1').dirtyForms('isDirty') == true) {
                //alert('SAVE FIELDS');
                savefields();
            }

            //alert(mode);
            if (mode == "Save") {
                //alert(dofiles);
                //alert($("#hf_deletefile").val());
                if (dofiles = true || $("#hf_deletefile").val() != '') {
                    //alert("Processing files.");
                    //alert('REFRESH FILES TABLE');
                    //alert(1);
                    refreshfilestable();
                }
            }

            if (mode == "Save") {
                $("#div_processing").hide();
                $("#dialog-message").html('<span align="center">Saved</span>');
                $("#dialog-message").dialog({
                    autoOpen: true,
                    resizable: false,
                    height: "auto",
                    width: 400,
                    modal: true,
                    closeText: ""
                });
            }

            //$(document).ajaxComplete(function (event, xhr, settings) {
            //    alert(settings.url);
            //});
        }

        //SAVE FIELDS

        function savefields() {
            var arForm = $("#form1")
                .find("input,textarea,select,hidden")
                .not("[id^='__']")
                .not("[id^='cb_deletefile']")
                .serializeArray();


            var formData = JSON.stringify({ formVars: arForm });
            //alert(formData);

            $.ajax({
                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                async: false,
                contentType: "application/json; charset=utf-8",
                url: 'posts.asmx/reportsave', // the url where we want to POST
                data: formData,
                dataType: 'json', // what type of data do we expect back from the server
                success: function (result) {
                    //alert(result);
                    $('#form1').dirtyForms('setClean');
                    $('#form1').removeClass('mydirty');
                    $('.form_result').html('Saved');
                    details = $.parseJSON(result.d);
                    $('#hf_cc_report_ctr').val(details.ctr);
                    //alert(details.status);
                },
                error: function (xhr, status) {
                    alert("An error occurred: " + status);
                }

            })
        }

        //SAVE FILES
        function savefiles(files) {
            //alert(files.length);
            var filedata = new FormData();


            for (i = 0; i < files.length; i++) {
                //alert(files[i].size);
                filedata.append("UploadedFile", files[i]);
            }
            filedata.append("tb_reference", $('#tb_reference').val());
            filedata.append("tb_applicationreference", $('#tb_applicationreference').val());
            $.ajax({
                type: "POST",
                async: false,
                url: "posts.asmx/reportupload",
                contentType: false,
                processData: false,
                data: filedata,
                dataType: 'text', // what type of data do we expect back from the server
                success: function (result) {
                    //alert(result);
                    var xml = result,
                        xmlDoc = $.parseXML(result),
                        $xml = $(xmlDoc),
                        $message = $xml.find("message");
                    //alert($message.text());
                    //$("#ContentPlaceHolder1_lbl_files").html($message.text());
                    $("#fu_files").val("");
                },
                error: function (xhr, status) {
                    alert("An error occurred: " + status);
                }
            });
        }

        //REFRESH FILES TABLE

        function refreshfilestable() {
            //alert('refreshfilestable');
            //alert(files.length);
            //alert($("#hf_deletefile").val());
            $.ajax({
                dataType: 'html', // what type of data do we expect back from the server
                   url: "data.aspx?mode=buildfilestable&reference=" + $("#tb_applicationreference").val() + "/reports/" + $("#tb_reference").val(), success: function (result) {
                    //alert('Result=' + result);
                    //filestable = $.parseJSON(result.message)
                    //alert(filestable);
                    $("#ContentPlaceHolder1_lbl_files").html(result);
                }
            });

        }
        /*
        function submitform() {
            var arForm = $("#form1")
                .find("input,textarea,select,hidden")
                .not("[id^='__']")
                .not("[id^='cb_deletefile_']")
                .serializeArray();

            var formData = JSON.stringify({ formVars: arForm });

            $.ajax({
                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                contentType: "application/json; charset=utf-8",
                url: 'posts.asmx/reportsubmit', // the url where we want to POST
                data: formData,
                dataType: 'json', // what type of data do we expect back from the server
                success: function (result) {
                    window.location.href = 'default.aspx';
                },
                error: function (xhr, status) {
                    alert("An error occurred: " + status);
                }
            })
        }

        */


        <% } %>

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
    <!--Forces form to be rendered with enctype="multipart/form-data" -->

<nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Community Contracts</a><span class="navbar-brand"> <%:Session["communitycontractsgroup_legalname"]%></span>
            </div>
            <!--
    <ul class="nav navbar-nav">dir
      <li class="active"><a href="#">Home</a></li>
      <li><a href="#">Page 1</a></li>

    </ul>
                  -->
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.aspx"><span class="glyphicon glyphicon-user"></span> Log out</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> Reset Password</a></li>
                <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>
    <h1>Community Contracts Progress Report
    </h1>
    <input name="hf_cc_report_ctr" type="hidden" value="<%:hf_cc_report_ctr %>" />
    <input name="hf_CC_ReportRequirements_CTR" type="hidden" value="<%:hf_CC_ReportRequirements_CTR %>" />
    <input name="hf_applicantemail" type="hidden" value="<%:hf_applicantemail %>" />
    <input name="hf_deletefile" id="hf_deletefile" type="hidden" value="" />

    <div id="dialog-message" title="Processing Message"></div>

    <div id="div_processing" style="display: none">Saving</div>

    <div id="dialog-inject" title="Please enter your response">
        <p>
            <span id="dialog-text"></span>
            <br />
            <input type="text" id="inject_response" name="inject_response" />
        </p>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Report reference number:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_reference" name="tb_reference" value="<%:tb_reference %>" readonly="readonly" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_applicationreference">Application reference number:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_applicationreference" name="tb_applicationreference" value="<%:tb_applicationreference %>" readonly="readonly" />

        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_projectname">Project name:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_projectname" name="tb_projectname" value="<%:tb_projectname %>" style="width: 100%" readonly="readonly" />
        </div>
    </div>



    <%=html %>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_highlights">Highlights</label><div class="col-sm-8">
            <textarea id="tb_highlights" name="tb_highlights" class="form-control" required><%:tb_highlights %></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_issues">Issues</label><div class="col-sm-8">
            <textarea id="tb_issues" name="tb_issues" class="form-control" required><%:tb_issues %></textarea>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_files">Please upload any supporting documentation if you wish.</label><div class="col-sm-8">
            <% if (viewmode != "readonly")
                { %>
            <!--<asp:FileUpload ID="fu_files" runat="server" AllowMultiple="True" />-->
            <input id="fu_files" name="fu_files" type="file" multiple="multiple" />
            <% } %>
            <asp:Label ID="lbl_files" runat="server" Text=""></asp:Label>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_finalised">Finalise this report:</label>
        <div class="col-sm-8">
            <select id="dd_finalised" name="dd_finalised" class="form-control" required>
                <option></option>
                <%
                    foreach (string dd_value in yesno_values)
                    {
                        if (dd_value == dd_finalised)
                        {
                            selected = " selected";
                        }
                        else
                        {
                            selected = "";
                        }
                        Response.Write("<option" + selected + ">" + dd_value + "</option>");
                    }
                %>
            </select>
        </div>
    </div>




    <% if (viewmode != "readonly")
        { %>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input type="button" id="btn_save" class="btn btn-info submit" value="Save" />&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btn_submit" runat="server" class="btn btn-info btn_submit" Text="Submit" OnClick="btn_submit_Click" />

        </div>
    </div>


    <% } %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
