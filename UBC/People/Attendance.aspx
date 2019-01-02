<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="UBC.People.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/dirty.js")%>"></script>
    <style>
     
    </style>

    <script>

        $(document).ready(function () {

            $("#myForm").dirty();

            $("#form1").validate();

            $('#dd_attendance').change(function () {
                if ($(this).val() != 'No' && $(this).val() != 'Not Going') {
                    $('#div_questions').show();
                } else {
                    $('#div_questions').find(':input').each(function () {
                        $(this).val('');
                    });
                    $('#div_traveldetail').hide();
                    $('#div_questions').hide();
                }
            })

            $('#dd_role').change(function () {
                if ($(this).val().includes("Rower")) {
                    $('#div_events').show();
                } else {
                    $('#tb_events').val('');
                    $('#div_events').hide();
                }
            });

            $('#dd_travel').change(function () {
                if ($(this).val() != 'I need a ride') {
                    if ($(this).val() == 'In my/our vehicle') {
                        $('#lbl_traveldetail').html('Who else is going in your vehicle?<br />Do you have room in your car for others?  If so how many seats?');
                    } else if ($(this).val() == "I've got a ride") {
                        $('#lbl_traveldetail').html("Who's vehicle are you travelling in?");
                    }
                    $('#div_traveldetail').show();
                } else {
                    $('#div_traveldetail').hide();
                }
            })
        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toprighticon">
        <input type="button" id="login" class="btn btn-info" value="Log in" />
    </div>
    <h1>Union Boat Club - Event Attendance
    </h1>
    <%= header %>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_attendance">Are you attending</label>
        <div class="col-sm-8">
            <select id="dd_attendance" name="dd_attendance" class="form-control" required>
                    <option></option>
                <%= Generic.Functions.populateselect(attendance_values, attendance,"None") %>
            </select>
        </div>
    </div>

    <div id="div_questions" style="display: <%: display_questions %>">

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_role">What are you coming as?</label>
            <div class="col-sm-8">
                <select id="dd_role" name="dd_role" class="form-control" required>
                    <option></option>
                    <%= Generic.Functions.populateselect(role_values, role,"None") %>
                </select>
            </div>
        </div>



        <div class="form-group" id="div_events" style="display: <%: display_events %>"">
            <label class="control-label col-sm-4" for="tb_events">
                What events would you like to enter into?<br />
                Rank in order of preference and note other crew members if you have a preference.</label>
            <div class="col-sm-8">
                <textarea id="tb_events" name="tb_events" class="form-control" required><%: events %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_travel">How are you getting there?</label>
            <div class="col-sm-8">
                <select id="dd_travel" name="dd_travel" class="form-control" required>
                    <option></option>
                    <%= Generic.Functions.populateselect(travel_values, travel,"None") %>
                </select>
            </div>
        </div>

        <div class="form-group" id="div_traveldetail" style="display: <%: display_traveldetail %>">
            <label class="control-label col-sm-4" for="tb_traveldetail" id="lbl_traveldetail"><%= label_traveldetail %></label>
            <div class="col-sm-8">
                <textarea id="tb_traveldetail" name="tb_traveldetail" class="form-control" required><%: traveldetail %></textarea>
            </div>
        </div>
        fmost
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_returntraveldetail">How are you getting back?</label>
            <div class="col-sm-8">
                <textarea id="tb_returntraveldetail" name="tb_returntraveldetail" class="form-control" required><%: returntraveldetail %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_others">What family and friends are also attending?</label>
            <div class="col-sm-8">
                <textarea id="tb_others" name="tb_others" class="form-control" required><%: others %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_accomodation">Who needs accomodation (including yourself)?<br />(most likely in the Scout Hall)</label>
            <div class="col-sm-8">
                <textarea id="tb_accomodation" name="tb_accomodation" class="form-control" required><%: accomodation %></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_onsite">Who will be staying onsite in a tent/campervan/caravan etc?<br />(including yourself)</label>
            <div class="col-sm-8">
                <textarea id="tb_onsite" name="tb_onsite" class="form-control" required><%: onsite %></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_meals">Who will require meals?</label>
            <div class="col-sm-8">
                <textarea id="tb_meals" name="tb_meals" class="form-control" required><%: meals %></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_otherinformation">Please let us know if there is anything else we should know?</label>
            <div class="col-sm-8">
                <textarea id="tb_otherinformation" name="tb_otherinformation" class="form-control"><%: otherinformation %></textarea>
            </div>
        </div>
    </div>




    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" class="btn btn-info" Text="Submit" OnClick="btn_submit_Click" />

        </div>
    </div>



</asp:Content>
