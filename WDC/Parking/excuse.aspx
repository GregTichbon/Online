<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="excuse.aspx.cs" Inherits="Online.Parking.excuse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "ExcuseHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('#cb_driveraddressformat').click(function () {
                if ($('#span_driveraddressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_driveraddressformat').text('Free format address mode (not preferred)');
                    $("#tb_driveraddress").autocomplete("disable");
                } else {
                    $('#span_driveraddressformat').text('Address lookup mode (preferred)');
                    $("#tb_driveraddress").autocomplete("enable");
                }
            })

            $("#tb_driveraddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_driveraddress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            $('#cb_owneraddressformat').click(function () {
                if ($('#span_owneraddressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_owneraddressformat').text('Free format address mode (not preferred)');
                    $("#tb_owneraddress").autocomplete("disable");
                } else {
                    $('#span_owneraddressformat').text('Address lookup mode (preferred)');
                    $("#tb_owneraddress").autocomplete("enable");
                }
            })

            $("#tb_owneraddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_owneraddress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            $("#form1").validate({
                groups: {
                    driverphone_numbers: "tb_drivermobilephone tb_driverhomephone tb_driverworkphone"
                },
                rules: {
                    tb_driveremailconfirm: {
                        equalTo: '#tb_driveremailaddress'
                    },
                    tb_drivermobilephone: {
                        require_from_group: [1, ".driverphone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_driverhomephone: {
                        require_from_group: [1, ".driverphone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_driverworkphone: {
                        require_from_group: [1, ".driverphone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_owneremailconfirm: {
                        equalTo: '#tb_owneremailaddress'
                    },
                    tb_ownermobilephone: {
                        require_from_group: [1, ".ownerphone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_ownerhomephone: {
                        require_from_group: [1, ".ownerphone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_ownerworkphone: {
                        require_from_group: [1, ".ownerphone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    }
                },
                messages: {
                    tb_driveremailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_drivermobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_driverhomephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_driverworkphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_owneremailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_ownermobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_ownerhomephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_ownerworkphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                }
             })



            $(".phone-group").mask('009 0000000999');

        }); //document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Parking Excuse
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_infringement">Infringement number</label>
        <div class="col-sm-8">
            <input id="tb_infringement" name="tb_infringement" type="text" class="form-control" required />
        </div>
    </div>

    
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_registration">Registration number</label>
        <div class="col-sm-8">
            <input id="tb_registration" name="tb_registration" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_date">Date of infringement</label>
        <div class="col-sm-8">
            <input id="tb_date" name="tb_date" type="text" class="form-control" required />
        </div>
    </div>



    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
