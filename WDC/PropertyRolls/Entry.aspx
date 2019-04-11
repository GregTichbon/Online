<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="Online.PropertyRolls.Entry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {




            $("#pagehelp").colorbox({ href: "EntryHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $(".numericL").keydown(function (event) {
                //alert(event.keyCode);
                if (event.shiftKey == true) {
                    event.preventDefault();
                }

                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46
                    || event.keyCode == 191
                    ) {
                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
                //if a decimal has been added, disable the "."-button
            });


            $("#form1").validate();





        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>
    <input type="hidden" id="hf_propertyroll_id" name="hf_propertyroll_id" value="<%:hf_propertyroll_id%>" />
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Property Rolls
    </h1>

    <!--
    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxxxx">xxxxxxxx</label>
        <div class="col-sm-8">
            <input id="xxxxxxxx" name="xxxxxxxx" type="text" class="form-control" value="<%:xxxxxxxx%>" />
            <textarea id="xxxxxxxx" name="xxxxxxxx" class="form-control" rows="4"><%:xxxxxxxx%></textarea>
        </div>
    </div>
    -->

    <!--Occupier -->
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3>Occupier</h3>
            </div>
            <div class="panel-body">


                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupiersurname">Surname</label>
                    <div class="col-sm-8">
                        <input id="tb_occupiersurname" name="tb_occupiersurname" type="text" class="form-control" value="<%:tb_occupiersurname%>" maxlength="60" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupierfirstname">First name(s)</label>
                    <div class="col-sm-8">
                        <input id="tb_occupierfirstname" name="tb_occupierfirstname" type="text" class="form-control" value="<%:tb_occupierfirstname%>" maxlength="60" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupierinitials">Initials</label>
                    <div class="col-sm-8">
                        <input id="tb_occupierinitials" name="tb_occupierinitials" type="text" class="form-control" value="<%:tb_occupierinitials%>" maxlength="15" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupiertitle">Title</label>
                    <div class="col-sm-8">
                        <input id="tb_occupiertitle" name="tb_occupiertitle" type="text" class="form-control" value="<%:tb_occupiertitle%>" maxlength="5" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_occupiergender">Gender</label>
                    <div class="col-sm-8">
                        <select id="dd_occupiergender" name="dd_occupiergender" class="form-control">
                            <option></option>
                            <%=Online.WDCFunctions.WDCFunctions.populateselect(genders, dd_occupiergender, "None")%>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_occupieroccupation">Occupation</label>
                    <div class="col-sm-8">
                        <input id="tb_occupieroccupation" name="tb_occupieroccupation" type="text" class="form-control" value="<%:tb_occupieroccupation%>" maxlength="100" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Owner-->
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3>Owner</h3>
            </div>
            <div class="panel-body">

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_ownersurname">Surname</label>
                    <div class="col-sm-8">
                        <input id="tb_ownersurname" name="tb_ownersurname" type="text" class="form-control" value="<%:tb_ownersurname%>" maxlength="60" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_ownerfirstname">First name(s)</label>
                    <div class="col-sm-8">
                        <input id="tb_ownerfirstname" name="tb_ownerfirstname" type="text" class="form-control" value="<%:tb_ownerfirstname%>" maxlength="60" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_ownerinitials">Initials</label>
                    <div class="col-sm-8">
                        <input id="tb_ownerinitials" name="tb_ownerinitials" type="text" class="form-control" value="<%:tb_ownerinitials%>" maxlength="15" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_ownertitle">Title</label>
                    <div class="col-sm-8">
                        <input id="tb_ownertitle" name="tb_ownertitle" type="text" class="form-control" value="<%:tb_ownertitle%>" maxlength="5" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_ownergender">Gender</label>
                    <div class="col-sm-8">
                        <select id="dd_ownergender" name="dd_ownergender" class="form-control">
                            <option></option>
                            <%=Online.WDCFunctions.WDCFunctions.populateselect(genders, dd_ownergender, "None")%>
                        </select>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_owneroccupation">Occupation</label>
                    <div class="col-sm-8">
                        <input id="tb_owneroccupation" name="tb_owneroccupation" type="text" class="form-control" value="<%:tb_owneroccupation%>" maxlength="100" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_owneraddress">Address</label>
                    <div class="col-sm-8">
                        <textarea id="tb_owneraddress" name="tb_owneraddress" class="form-control" rows="4"><%:tb_owneraddress%></textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Property-->
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3>Property</h3>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_valuationnumber">Valuation number</label>
                    <div class="col-sm-8">
                        <input id="tb_valuationnumber" name="tb_valuationnumber" type="text" class="form-control numericL" value="<%:tb_valuationnumber%>" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_propertyaddress">Address</label>
                    <div class="col-sm-8">
                        <textarea id="tb_propertyaddress" name="tb_propertyaddress" class="form-control" rows="4"><%:tb_propertyaddress%></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_ward">Ward</label>
                    <div class="col-sm-8">
                        <select id="dd_ward" name="dd_ward" class="form-control">
                            <option></option>
                            <%=wards%>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_council">Council</label>
                    <div class="col-sm-8">
                        <select id="dd_council" name="dd_council" class="form-control">
                            <option></option>
                            <%=councils%>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_rates">Rates</label>
                    <div class="col-sm-8">
                        <input id="tb_rates" name="tb_rates" type="text" class="form-control" value="<%:tb_rates%>" maxlength="10" />
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_year">Year</label>
                    <div class="col-sm-8">
                        <select id="dd_year" name="dd_year" class="form-control">
                            <option></option>
                            <%=years%>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_reference">Reference</label>
                    <div class="col-sm-3">
                        <select id="dd_reference" name="dd_reference" class="form-control">
                            <option></option>
                            <%=references%>
                        </select>

                    </div>
                    <div class="col-sm-2">
                        <label class="control-label col-sm-4" for="tb_page">Page</label>
                    </div>
                    <div class="col-sm-3">
                        <input id="tb_page" name="tb_page" type="text" class="form-control" value="<%:tb_page%>" maxlength="10" />
                    </div>


                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_notes">Notes</label>
                    <div class="col-sm-8">
                        <textarea id="tb_notes" name="tb_notes" class="form-control" maxlength="200"><%:tb_notes%></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_propertydescription">Description</label>
                    <div class="col-sm-8">
                        <input id="tb_propertydescription" name="tb_propertydescription" type="text" class="form-control" value="<%:tb_propertydescription%>" maxlength="100" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_tenancy">Tenancy</label>
                    <div class="col-sm-8">
                        <select id="dd_tenancy" name="dd_tenancy" class="form-control">
                            <option></option>
                            <%=tenancies%>
                        </select>
                    </div>
                </div>







            </div>
        </div>
    </div>


    <!--Office Use only-->

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3>For office use only</h3>
            </div>
            <div class="panel-body">

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_status">Status</label>
                    <div class="col-sm-8">
                        <select id="dd_status" name="dd_status" class="form-control">
                            <option></option>
                            <%=Online.WDCFunctions.WDCFunctions.populateselect(statuses, dd_status, "None")%>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_internalnotes">Notes</label>
                    <div class="col-sm-8">
                        <textarea id="tb_internalnotes" name="tb_internalnotes" class="form-control" maxlength="200"><%:tb_internalnotes%></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_created">Created</label>
                    <div class="col-sm-8">
                        <input id="tb_created" name="tb_created" type="text" class="form-control" value="<%:tb_created%>" readonly="readonly" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_modified">Modified</label>
                    <div class="col-sm-8">
                        <input id="tb_modified" name="tb_modified" type="text" class="form-control" value="<%:tb_modified%>" readonly="readonly" />
                    </div>
                </div>

            </div>
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
