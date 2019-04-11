<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="excusedetails.aspx.cs" Inherits="Online.Parking.excusedetails" %>

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
            <input id="tb_infringement" name="tb_infringement" type="text" class="form-control" readonly="readonly" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_registration">Registration number</label>
        <div class="col-sm-8">
            <input id="tb_registration" name="tb_registration" type="text" class="form-control" readonly="readonly" />
        </div>
    </div>

        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_date">Date of infringement</label>
        <div class="col-sm-8">
            <input id="tb_date" name="tb_date" type="text" class="form-control" readonly="readonly" />
        </div>
    </div>

        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_vehicle">Vehicle make / model</label>
        <div class="col-sm-8">
            <input id="tb_vehicle" name="tb_vehicle" type="text" class="form-control" readonly="readonly" />
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_drivername">Full name</label>
        <div class="col-sm-8">
            <input id="tb_drivername" name="tb_drivername" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_driveraddressformat">
            Address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_driveraddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_driveraddressformat">Change</a>
            <textarea id="tb_driveraddress" name="tb_driveraddress" class="form-control" rows="4" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_driverdateofbirth">Date of birth</label>
        <div class="col-sm-8">
            <input id="tb_driverdateofbirth" name="tb_driverdateofbirth" type="text" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_driveremailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_driveremailaddress" name="tb_driveremailaddress" type="email" class="form-control inhibitcutcopypaste" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_driveremailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_driveremailconfirm" name="tb_driveremailconfirm" type="email" class="form-control inhibitcutcopypaste" required autocomplete="off" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_drivermobilephone">Mobile phone</label>
        <div class="col-sm-8">
            <input id="tb_drivermobilephone" placeholder="eg: 027 123456..." name="tb_drivermobilephone" type="text" class="form-control driverphone-group" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_driverhomephone">Home phone</label>
        <div class="col-sm-8">
            <input id="tb_driverhomephone" name="tb_driverhomephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control driverphone-group" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_driverworkphone">Work phone</label>
        <div class="col-sm-8">
            <input id="tb_driverworkphone" name="tb_driverworkphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control driverphone-group" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ownername">Full name</label>
        <div class="col-sm-8">
            <input id="tb_ownername" name="tb_ownername" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_owneraddressformat">
            Address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_owneraddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_owneraddressformat">Change</a>
            <textarea id="tb_owneraddress" name="tb_owneraddress" class="form-control" rows="4" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ownerdateofbirth">Date of birth</label>
        <div class="col-sm-8">
            <input id="tb_ownerdateofbirth" name="tb_ownerdateofbirth" type="text" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_owneremailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_owneremailaddress" name="tb_owneremailaddress" type="email" class="form-control inhibitcutcopypaste" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_owneremailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_owneremailconfirm" name="tb_owneremailconfirm" type="email" class="form-control inhibitcutcopypaste" required autocomplete="off" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ownermobilephone">Mobile phone</label>
        <div class="col-sm-8">
            <input id="tb_ownermobilephone" placeholder="eg: 027 123456..." name="tb_ownermobilephone" type="text" class="form-control ownerphone-group" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ownerhomephone">Home phone</label>
        <div class="col-sm-8">
            <input id="tb_ownerhomephone" name="tb_ownerhomephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control ownerphone-group" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ownerworkphone">Work phone</label>
        <div class="col-sm-8">
            <input id="tb_ownerworkphone" name="tb_ownerworkphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control ownerphone-group" />
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
