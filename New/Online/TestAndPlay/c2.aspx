<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="c2.aspx.cs" Inherits="Online.TestAndPlay.c2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "search.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('#dd_stillborn').change(function () {
                if (this.value == 'Yes') {
                    $('#div_age').hide();
                } else {
                    $('#div_age').show();

               
                }

            })

            $(".prioruse_autocomplete").autocomplete({
                source: function (request, response) {
                    $.getJSON('/functions/data.asmx/PriorUse', {
                        fieldname: $('#' + this.element[0].id).data('prioruse'), 
                        'term': request.term
                    }, response);
                },
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    myitem = ui.item;
                    $("#" + this.id).val(ui.item ?
                        myitem.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Cemetery Estate
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_EstateID">Estate ID</label>
        <div class="col-sm-8">
            <input id="tb_EstateID" name="tb_EstateID" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_Warrant_No">Warrant Number</label>
        <div class="col-sm-8">
            <input id="tb_Warrant_No" name="tb_Warrant_No" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_Register_No">Register Number</label>
        <div class="col-sm-8">
            <input id="tb_Register_No" name="tb_Register_No" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_surname">Surname</label>
        <div class="col-sm-8">
            <input id="tb_surname" name="tb_surname" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_givenName1">Given Name 1</label>
        <div class="col-sm-8">
            <input id="tb_givenName1" name="tb_givenName1" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_givenName2">Given Name 2</label>
        <div class="col-sm-8">
            <input id="tb_givenName2" name="tb_givenName2" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_givenName3">Given Name 3</label>
        <div class="col-sm-8">
            <input id="tb_givenName3" name="tb_givenName3" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_lastPermanentAddress">Last Permanent Address</label>
        <div class="col-sm-8">
            <input id="tb_lastPermanentAddress" name="tb_lastPermanentAddress" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_city">City</label>
        <div class="col-sm-8">
            <input id="tb_city" name="tb_city" type="text" class="form-control prioruse_autocomplete" data-prioruse="cemeteries|estate|city" required />

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_placeOfDeath">Place Of Death</label>
        <div class="col-sm-8">
                        <input id="tb_placeOfDeath" name="tb_placeOfDeath" type="text" class="form-control prioruse_autocomplete" data-prioruse="cemeteries|estate|placeofdeath" required />

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateOfBirth">Date Of Birth</label>
        <div class="col-sm-8">
            <input id="tb_dateOfBirth" name="tb_dateOfBirth" type="text" class="form-control" required />
        </div>
    </div>
        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_stillBorn">Still Born</label>
        <div class="col-sm-8">
            <select id="dd_stillborn" name="dd_stillborn" class="form-control" >
                <option></option>
                <option>No</option>
                <option>Yes</option>
            </select>

        </div>
    </div>
 
    <div class="form-group" id="div_age">
        <label class="control-label col-sm-4" for="tb_age">Age</label>
        <div class="col-sm-4">
            <input id="tb_age" name="tb_age" type="text" class="form-control" required />
        </div>
        <div class="col-sm-4">
                                    <select id="dd_age_Period" name="dd_age_Period" class="form-control" required>
                <option></option>
                <option>Years</option>
                <option>Months</option>
                <option>Weeks</option>
                <option>Days</option>

            </select>
            
        </div>
        </div>

   

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
        <div class="col-sm-8">
                        <select id="dd_gender" name="dd_gender" class="form-control" required>
                <option></option>
                <option>Female</option>
                <option>Male</option>
                <option>Gender diverse</option>
                <option>Unknown</option>

            </select>


        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_denomination">Religion / Denomination</label>
        <div class="col-sm-8">
                                    <select id="dd_denomination" name="dd_denomination" class="form-control" required>
                <option></option>
                <option>Anglican</option>
                <option>Bretheren</option>
                <option>Baptist</option>
                <option>Roman Catholic</option>

            </select>

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_minister">Minister</label>
        <div class="col-sm-8">
            <input id="tb_minister" name="tb_minister" type="text" class="form-control prioruse_autocomplete" data-prioruse="cemeteries|estate|minister" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateOfDeath">Date Of Death</label>
        <div class="col-sm-8">
            <input id="tb_dateOfDeath" name="tb_dateOfDeath" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateOfMedCert">Date Of Medical Certificate</label>
        <div class="col-sm-8">
            <input id="tb_dateOfMedCert" name="tb_dateOfMedCert" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_rankOrOccupation">Rank Or Occupation</label>
        <div class="col-sm-8">
            <input id="tb_rankOrOccupation" name="tb_rankOrOccupation" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_maritalStatus">Marital Status</label>
        <div class="col-sm-8">

            <select id="dd_maritalStatus" name="dd_maritalStatus" class="form-control" >
                <option></option>
                <option>Married</option>
                <option>Not Married</option>
                <option>Widowed</option>
                <option>Child</option>

            </select>

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_funeralCoOrdinator">Funeral CoOrdinator</label>
        <div class="col-sm-8">
                        <input id="tb_funeralCoOrdinator" name="tb_funeralCoOrdinator" type="text" class="form-control prioruse_autocomplete" data-prioruse="cemeteries|estate|funeralCoOrdinator" required />

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_remarks">Remarks</label>
        <div class="col-sm-8">
            <input id="tb_remarks" name="tb_remarks" type="text" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_created_by">Created by</label>
        <div class="col-sm-8">
            <input id="tb_created_by" name="tb_created_by" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_date_created">Date created</label>
        <div class="col-sm-8">
            <input id="tb_date_created" name="tb_date_created" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_modified_by">Modified by</label>
        <div class="col-sm-8">
            <input id="tb_modified_by" name="tb_modified_by" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_date_modified">Date modified</label>
        <div class="col-sm-8">
            <input id="tb_date_modified" name="tb_date_modified" type="text" class="form-control" required />
        </div>
    </div>

    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_submit" type="button" value="Submit" class="btn btn-info submit" />
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
