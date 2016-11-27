<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StockGrazing.aspx.cs" Inherits="Online.General.StockGrazing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">
          var location_maxline = 0;

          $(document).ready(function () {

              /*
              var fieldsdiv = $("<div>", { id: "fields" });
              $("body").append(fieldsdiv);
  
              var x = '';
              $('input, textarea, select').each(function (index) {
                  // x = x + '<br>' + '@pre' + this.id + '@post';
                  if (this.id.substring(0, 2) != '__') {
                      var $myLabel = $('label[for="' + this.id + '"]');
                      x = x + '<br>' + $myLabel.html() + "=" + this.id;
                  }
  
              })
              var fieldsdiv = '<div id="fields">'+ x + '</div>';
              $("body").append(fieldsdiv);
              //$('#fields').html(x);
              */

              var populatelink = '<a id="populate" href="javascript:void(0)">Populate</a>'
              $("body").prepend(populatelink);

              $("#populate").click(function () {
                  $('input, textarea, select').each(function () {
                      if (this.id.substring(0, 2) == '__' || this.id.substr(this.id.length - 1) == '_' || ($(this).attr('readonly') == 'readonly')) {
                          //alert(this.id + ', ' + this.id.substr(this.id.length - 1) + ', ' + $(this).attr('readonly'));
                      } else {
                          thetype = this.type;
                          switch (thetype) {
                              case 'email':
                                  this.value = 'greg.tichbon@whanganui.govt.nz'
                                  break;
                              case 'select-one':
                                  $(this).val($('#' + this.id + ' option:last').val());
                              case 'checkbox':
                                  $(this).prop('checked', true);
                                  break;
                              case 'file':
                                  break;
                              case 'submit':
                                  break;
                              default:
                                  if (this.id.indexOf('phone') > -1) {
                                      this.value = '027 123456'
                                  } else {
                                      //alert(this.id + ', ' + thetype);
                                      this.value = this.id;
                                  }
                          }
                      }
                  })
              })

              $("#pagehelp").colorbox({ href: "MarketFoodStallLicenceHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

              validator = $("#form1").validate({
                  ignore: []
              });

              property_ctr = 1;
              $('.addproperty').click(function () {
                  var cloned = $('#tr_property_').clone()
                  property_ctr++;
                  cloned = cloned.repeater_changer(property_ctr);
                  var place = $('#table_property tr:last');
                  cloned.insertAfter(place);
                  return false;
              });

              $('body').on('click', '.deleteproperty', function () {
                  trid = this.id;
                  trid = 'tr_property' + trid.substring(22);
                  $('#' + trid).remove();
              });

              $('body').on('click', '#a_propertyaddress', function () {
                  //not using line at this stage
                  $.colorbox({ href: "../functions/PropertySelect.aspx", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
              });

              location_maxline = $("#table_location tr").length;
              $('body').on('click', '.action_location', function () {
                  //$(".action_location").click(function () {   //The line above means dynamically created html will automatically have events attached :-)
                  var action = $(this).text();
                  var item_count = parseInt($('#hidden_location').val());
                  if (action == "Delete") {
                      line = $(this).attr("data-line");
                      $('#table_location tr[data-line="' + line + '"]').remove();
                      $('#hidden_location').val(item_count - 1);
                  } else {
                      if (action == 'Add') {
                          line = 0;
                          qs = "";
                          $('#hidden_location').val(item_count + 1);
                      } else {
                          //Edit
                          line = $(this).attr("data-line");
                          qs = "&p=" + $("input[id$='hf_locationcoords_" + line + "']").val() + "&location=" + $("input[id$='tb_location_" + line + "']").val();
                      }
                      $.colorbox({ href: "../mapping/GetLocation.aspx?line=" + line + qs, iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
                  }
                  $("#form1").validate().element("#hidden_location");
              });

              $('body').on('focus', ".date", function () {
                  $(this).datetimepicker({
                      format: 'D/MM/YYYY',
                      showClear: true,
                      viewDate: false,
                      minDate: moment().add(1, 'day'),
                      maxDate: moment().add(10, 'year'),
                      useCurrent: false,
                      useStrict: true
                  });
              });

              var addressname = 'premiseaddress';
              $('#cb_' + addressname + 'format').click(function () {
                  if ($('#span_' + addressname + 'format').text() == 'Address lookup mode (preferred)') {
                      $('#span_' + addressname + 'format').text('Free format address mode (not preferred)');
                      $('#tb_' + addressname).autocomplete("disable");
                  } else {
                      $('#span_' + addressname + 'format').text('Address lookup mode (preferred)');
                      $('#tb_' + addressname).autocomplete("enable");
                  }
              })
              $('#tb_' + addressname).autocomplete({
                  source: "../functions/data.asmx/NZPostAddressSearch",
                  minLength: 5,
                  select: function (event, ui) {
                      event.preventDefault();
                      address = ui.item;
                      $('#tb_' + addressname).val(ui.item ?
                          address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                  }
              })

          }); //document.ready

          function passproperty(line, label, value, area, legaldescription, assessment_no) {
              $("#tb_propertyaddress").val(label);
              $("#hf_propertyaddress").val(value);
              $.colorbox.close();
          }
          function passlocation(line, location, coords) {
              $.colorbox.close();
              if (line == 0) {
                  location_maxline = location_maxline + 1;
                  input = '<input readonly="readonly" type="text" id="tb_location_' + location_maxline + '" name="tb_location_' + location_maxline + '" class="form_control col-sm-8" value="' + location + '" />';
                  input = input + '<input id="hf_locationcoords_' + location_maxline + '" name="hf_locationcoords_' + location_maxline + '" type="hidden" value="' + coords + '" />';
                  input = input + ' <a class="action_location" data-line="' + location_maxline + '">Edit</a> <a class="action_location" data-line="' + location_maxline + '">Delete</a>';

                  $('#table_location tr:last').after('<tr data-line="' + location_maxline + '"><td>' + input + '</td></tr>');
              } else {
                  $("input[id$='tb_location_" + line + "']").val(location);
                  $("input[id$='hf_locationcoords_" + line + "']").val(coords);
              }
          }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
    <!--Forces form to be rendered with enctype="multipart/form-data" -->
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Stock Grazing Application
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premiselocation">Property address:</label>
        <div class="col-sm-6">
            <input type="text" id="tb_propertyaddress" name="tb_propertyaddress" readonly="readonly" class="form-control" required value="">
            <input id="hf_propertyaddress" name="hf_propertyaddress" type="hidden" value="" />
        </div>
        <div class="col-sm-2">
            <a id="a_propertyaddress">Select</a>
        </div>
    </div>


        <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">
            Properties
            <img src="../Images/questionsmall.png" title="Select Whanganui District Council properties." />
            <a href="javascript:void(0);" class="addproperty" id="addproperty">Add</a>
        </label>
        <div class="col-sm-8">
            <div class="table-responsive table-bordered">
                <table class="table" id="table_property">
                    <thead>
                        <tr>
                            <th class="col-md-2">Property</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                      </tbody>
                </table>
            </div>
        </div>
    </div>




    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">
            Specific
            Location(s)
            <img src="../Images/questionsmall.png" title="Location(s) must be specified if you are not intending to operate within the whole of the Whanganui District.  If you are intending to operate within the whole of the Whanganui District and intend to operate at specific locations please also add them here." /><br />
            <a class="action_location">Add</a>
        </label>
        <div class="col-sm-8">
            <input id="hidden_location" name="hidden_location" type="hidden" value="0" />
            <table id="table_location" style="width: 100%;">
                <tr style="display: <%: none%>">
                    <td></td>
                </tr>
            </table>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_owners">Name(s) of owner(s)</label>
        <div class="col-sm-8">
            <textarea id="tb_owners" name="tb_owners" class="form-control" rows="4" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Grazing period</label>
        <div class="col-sm-4">
            <input type="text" id="tb_grazingfrom" name="tb_grazingfrom" class="form-control date" value="" required />
        </div>
        <div class="col-sm-4">
            <input type="text" id="tb_grazingto" name="tb_grazingto" class="form-control date" value="" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_owner">Are you the owner of this property / these properties</label>
        <div class="col-sm-8">
            <select id="dd_owner" name="dd_owner" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(yesno_values, "","None") %>
            </select>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_permission">Upload permission</label>
        <div class="col-sm-8">
            <input id="fu_permission" name="fu_permission" type="file" multiple="multiple" />
            <asp:Label ID="lbl_permission" runat="server" Text=""></asp:Label>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_details">Please provide details about where the grazing will take place</label>
        <div class="col-sm-8">
            <textarea id="tb_details" name="tb_details" class="form-control" rows="4" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_details">Upload details about where the grazing will take place</label>
        <div class="col-sm-8">

            <input id="fu_details" name="fu_details" type="file" />
            <asp:Label ID="lbl_details" runat="server" Text=""></asp:Label>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>


    <p>
        Property No.
        <br />
        Property Address
        <br />
        Name of Owner(s): *
        <br />
        Commence grazing from: *
        <br />
        Are you the owner of this property? *<br />
        Yes No<br />
        (if no) Permission to graze (Please upload any supporting documents) *<br />
        (pdf, doc, txt or docx)<br />
        You must either give written details about where the grazing will take place or upload a diagram/map of the area.<br />
        Written details about where the grazing will take place
    </p>
    <p>Diagram/map of the area</p>
    5.1 Subject to holding valid and adequate public liability insurance, a person may apply to Council to obtain a licence for the temporary grazing of the Council’s road reserve.
    <br />
    5.2 Subject to clause 5.1 stock must be contained within a temporary electric fence and be electric fence trained.
    <br />
    5.3 The temporary electric fence shall be at least ONE metre from any water table; and TWO metres from the edge of the road
    <br />
    5.4 The temporary electric fence shall be erected only on the road reserve directly adjacent to the licensee’s property, unless written permission is gained from the licensee’s neighbour&#39;s to graze that neighbors road service frontage.
    <br />
    5.5 Safety reflectors visible from the left hand approach shall be fitted to both ends of the temporary fence, and at not more than 50 metre intervals along the length of the temporary electric fence.
    <br />
    5.6 Temporary electric fences are to be used during daylight time only. Stock must be removed for the duration of hours of darkness.
    <br />
    5.7 The Council may specify roads where temporary electric fences must be removed for the duration of the hours of darkness.
    <br />
    5.8 For the purpose of this Bylaw a “temporary electric fence” means an adequate, electric, stock proof fence, erected on the road verge for grazing purposes, which is constructed of: a. Multi-wire tread-in standards; or b. Pigtail standards.
    <br />
    5.9 The stock owners are responsible for the security of all stock grazing the road reserve, at all times.
    <br />
    5.10 The stock owners are liable for all stock grazing the road reserve, at all times.
    <br />
    5.11 No entire bulls to be grazed on a reserve permit.
    <br />
    5.12 Council reserves the right to remove this permit giving 24 hours notice.
    <br />
    5.13 Permit holder is responsible for the maintenance and due care of the road reserve being grazed.
    <br />
    <br />
    I apply for authority to graze stock at the property address I have given, based on the conditions above

    <!-- REPEATER SECTION-->

    <div style="display: <%:none%>">
        <table>
            <tr id="tr_property_" class="repeatupdateid">
                <td>
                    <input id="repeat_property_tb_property_" type="text" class="form-control" required /></td>
                <td><a href="javascript:void(0)" id="href_property_delete_" class="deleteproperty repeatupdateid">Delete</a></td>
            </tr>
        </table>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
