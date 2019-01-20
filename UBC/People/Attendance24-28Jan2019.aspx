<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Attendance24-28Jan2019.aspx.cs" Inherits="UBC.People.Attendance24_28Jan2019" %>

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



            $('#dd_travel').change(function () {
                switch ($(this).val()) {
                    case 'I need a ride':
                        $('#div_traveldetail').hide();
                        $('#div_seats').hide();
                        break;
                    case 'In my/our vehicle':
                        $('#lbl_traveldetail').html('When are you travelling and who else is going in your vehicle?');
                        $('#div_traveldetail').show();
                        $('#div_seats').show();
                        break;
                    case "I've got a ride":
                        $('#lbl_traveldetail').html("When and how are you travelling?");
                        $('#div_traveldetail').show();
                        $('#div_seats').hide();
                        break;
                    case "":
                        $('#div_traveldetail').hide();
                        $('#div_seats').hide();
                        break;
                }
            })
         
            $('#dd_returntravel').change(function () {
                switch ($(this).val()) {
                    case 'I need a ride':
                        $('#div_returntraveldetail').hide();
                        $('#div_returnseats').hide();
                        break;
                    case 'In my/our vehicle':
                        $('#lbl_returntraveldetail').html('When are you travelling and who else is going in your vehicle?');
                        $('#div_returntraveldetail').show();
                        $('#div_returnseats').show();
                        break;
                    case "I've got a ride":
                        $('#lbl_returntraveldetail').html("When and how are you travelling?");
                        $('#div_returntraveldetail').show();
                        $('#div_returnseats').hide();
                        break;
                    case "":
                        $('#div_traveldetail').hide();
                        $('#div_seats').hide();
                        break;
                    default:
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
            <label class="control-label col-sm-4" for="dd_travel">How are you getting there?</label>
            <div class="col-sm-8">
                <select id="dd_travel" name="dd_travel" class="form-control" required>
                    <option></option>
                    <%= Generic.Functions.populateselect(travel_values, travel,"None") %>
                </select>
            </div>
        </div>

        <div class="form-group div_question" id="div_traveldetail" style="display: <%: display_traveldetail %>">
            <label class="control-label col-sm-4" for="tb_traveldetail" id="lbl_traveldetail"><%= label_traveldetail %></label>
            <div class="col-sm-8">
                <textarea id="tb_traveldetail" name="tb_traveldetail" class="form-control" required><%: traveldetail %></textarea>
            </div>
        </div>

        <div class="form-group div_question" id="div_seats" style="display: <%: display_seats %>">
            <label class="control-label col-sm-4" for="tb_seats">Are there spare seats available in the vehicle you are tavelling in?  If so how many?</label>
            <div class="col-sm-8">
                <textarea id="tb_seats" name="tb_seats" class="form-control" required><%: seats %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_returntravel">How are you getting back?</label>
            <div class="col-sm-8">
                <select id="dd_returntravel" name="dd_returntravel" class="form-control" required>
                    <option></option>
                    <%= Generic.Functions.populateselect(travel_values, returntravel,"None") %>
                </select>
            </div>
        </div>

        <div class="form-group div_question" id="div_returntraveldetail" style="display: <%: display_returntraveldetail %>">
            <label class="control-label col-sm-4" for="tb_returntraveldetail" id="lbl_returntraveldetail"><%= label_returntraveldetail %></label>
            <div class="col-sm-8">
                <textarea id="tb_returntraveldetail" name="tb_returntraveldetail" class="form-control" required><%: returntraveldetail %></textarea>
            </div>
        </div>

        <div class="form-group div_question" id="div_returnseats" style="display: <%: display_returnseats %>">
            <label class="control-label col-sm-4" for="tb_returnseats" id="lbl_returnseats">Are there spare seats available in the vehicle you are tavelling in?  If so how many?</label>
            <div class="col-sm-8">
                <textarea id="tb_returnseats" name="tb_returnseats" class="form-control" required><%: returnseats %></textarea>
            </div>
        </div>

        <div class="form-group div_question">
            <label class="control-label col-sm-4" for="tb_others">What family and friends are also attending that may stay with us?</label>
            <div class="col-sm-8">
                <textarea id="tb_others" name="tb_others" class="form-control" required><%: others %></textarea>
            </div>
        </div>

        <div class="form-group div_question">
            <label class="control-label col-sm-4" for="tb_otherinformation">Please let us know if there is anything else we should know?</label>
            <div class="col-sm-8">
                <textarea id="tb_otherinformation" name="tb_otherinformation" class="form-control"><%: otherinformation %></textarea>
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
