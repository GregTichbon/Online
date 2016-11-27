<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="validation2.aspx.cs" Inherits="Online.TestAndPlay.validation2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <script type="text/javascript">
        $(document).ready(function () {

            //alert('Ready');

            $("#form1").validate({

                rules: {
                    tb_contact1emailaddressconfirm: {
                        equalTo: '#tb_contact1emailaddress',
                        required: {
                            depends: function () {
                                return $("#tb_contact1emailaddress").val() != ""
                            }
                        }
                    },
                    tb_contact2surname: {
                        required: "#cb_secondcontact:checked"
                    }
                },
                messages: {
                    tb_contact1emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    }
                }
            });

            $('#cb_secondcontact').change(function () {
                if (this.checked) {
                    $('#div_secondcontact').show();

                    $('#div_secondcontact .optionalgrouprequired').addClass('dependantrequired');

                    
/*
                    input.removeAttr( "title" )
                } else {
                    input.attr( "title", inputTitle );
*/

                    //$('#tb_contact2surname').addClass('dependant-required')
                    // All elements with a class of 'maybe-required' with in the given dev should add the 
                } else {
                    $('#div_secondcontact').hide();
                    $('#div_secondcontact .optionalgrouprequired').addClass('dependantrequired');

                }
            });

            $('#tb_contact1emailaddress').keyup(function () {
                if (this.value == '') {
                    $('#tb_contact1emailaddressconfirm').removeClass('dependantrequired')
                    //  Doesn't work $('#tb_contact1emailaddressconfirm').removeAttr('required')
                } else {
                    $('#tb_contact1emailaddressconfirm').addClass('dependantrequired')
                    //  Doesn't work $('#tb_contact1emailaddressconfirm').attr('required','')


                }

            });



        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <%
        string selected;
        string none = "none";
    %>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contact1emailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_contact1emailaddress" name="tb_contact1emailaddress" type="email" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contact1emailaddressconfirm">Please re-type the email address</label>
        <div class="col-sm-8">
            <input id="tb_contact1emailaddressconfirm" name="tb_contact1emailaddressconfirm" type="email" class="form-control" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_secondcontact">There is a second contact</label>
        <div class="col-sm-8">
            <input id="cb_secondcontact" name="cb_secondcontact" type="checkbox" />
        </div>
    </div>
    <div id="div_secondcontact" style="display: <%: none%>">

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_contact2surname">Surname</label>
            <div class="col-sm-8">
                <input id="tb_contact2surname" name="tb_contact2surname" type="text" class="form-control optionalgrouprequired" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_contact2firstname">First name</label>
            <div class="col-sm-8">
                <input id="tb_contact2firstname" name="tb_contact2firstname" type="text" class="form-control" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
