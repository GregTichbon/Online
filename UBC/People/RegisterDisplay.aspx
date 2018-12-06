<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="RegisterDisplay.aspx.cs" Inherits="UBC.People.RegisterDisplay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });
        })
    </script>
    <style type="text/css">
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container" style="background-color:#B1C9E6" >
        <p></p>
        <table style="width:100%">
            <tr>
                <td style="width:350px">
                    <img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head.png" style="width:100%" /></td>
                <td style="text-align:center">
                    <h1>Registration
                    </h1>
                </td>
            </tr>
        </table>
        <p></p>
        <hr />
        <p></p>

        <div class="panel panel-danger">
            <div class="panel-heading">Rower</div>
            <div class="panel-body">

                <!------------------------------------------------------>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_firstname">First name</label>
                    <div class="col-sm-8">
                        <%:tb_firstname%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
                    <div class="col-sm-8">
                        <%:tb_lastname%>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_gender">Gender</label>
                    <div class="col-sm-8">
                          <%:dd_gender%>
                    </div>
                </div>

                <div class="form-group">
                    <label for="tb_birthdate" class="control-label col-sm-4">
                        Date of birth
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group date" id="div_birthdate">
                           <%: tb_birthdate %>

                            <span id="span_age" class="input-group-addon"></span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4">School (if applicable)</label>
                    <div class="col-sm-8">
                                                    <%= dd_school %>
                                     </div>
                </div>
                <div id="div_schoolyear" class="form-group" style="display: none">
                    <label class="control-label col-sm-4" for="dd_schoolyear">School year</label>
                    <div class="col-sm-8">
                        
                            <%= dd_schoolyear%>
                 
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_medical">Medical needs</label>
                    <div class="col-sm-8">
                        <%: tb_medical %>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_dietry">Special Dietry requirements</label>
                    <div class="col-sm-8">
                        <%: tb_dietry %>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
                    <div class="col-sm-8">
                       <%:tb_emailaddress%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_homephone">Home phone</label>
                    <div class="col-sm-8">
                       <%:tb_homephone%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_mobilephone">Mobile phone</label>
                    <div class="col-sm-8">
                        <%:tb_mobilephone%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_residentialaddress">Home address</label>
                    <div class="col-sm-8">
                        <%: tb_residentialaddress %>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_school">Swimming ability</label>
                    <div class="col-sm-8">
                            <%= dd_swimmer  %>
                                         </div>
                </div>
                <!------------------------------------------------------>

            </div>
        </div>


        <div class="panel panel-danger" id="div_parent">
            <div class="panel-heading">Parent/Caregivers</div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1">Name (1)</label>
                    <div class="col-sm-8">
                        <%:tb_parentcaregiver1%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1mobilephone">Mobile phone (1)</label>
                    <div class="col-sm-8">
                        <%:tb_parentcaregiver1mobilephone%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1emailaddress">Email address (1)</label>
                    <div class="col-sm-8">
                       <%:tb_parentcaregiver1emailaddress%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver">Name (2)</label>
                    <div class="col-sm-8">
                       <%:tb_parentcaregiver2%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver2mobilephone">Mobile phone (2)</label>
                    <div class="col-sm-8">
                        <%:tb_parentcaregiver2mobilephone%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver2emailaddress">Email address (2)</label>
                    <div class="col-sm-8">
                        <%:tb_parentcaregiver2emailaddress%>
                    </div>
                </div>
            </div>

        </div>


        <!------------------------------------------------------------------------------------------------------>

        <div class="panel panel-danger">
            <div class="panel-heading">Declaration</div>
            <div class="panel-body">
                <ul>
                    <li>I hereby apply for membership of the Union Boat Club. - I agree to be bound by the rules of the Club and to pay the annual subscription fees as set at the Annual General Meeting.</li>
                    <li>I also agree to pay such additional fees and levies which may be set from time to time to cover such items as: plant replacement, regatta entries and travel expenses.</li>
                    <li>I understand that there may be risk of personal injury involved in participating in the sport of rowing and hereby indemnify the Union Boat Club, its Executive, fellow members and coaches from any liability.</li>
                </ul>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_agreement">I agree with the above statements</label>
                    <div class="col-sm-8">
                      <%=dd_agreement %>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4">I also agree, for my email address to added to the Union Boat Club database to receive email newsletters and updates.</label>
                    <div class="col-sm-8">
                       <%= dd_correspondence %>
                    </div>
                </div>
            </div>
        </div>

        
    </div>


</asp:Content>
