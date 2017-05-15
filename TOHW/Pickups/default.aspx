<%@ Page Title="Te Ora Hou" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TOHW.Pickups._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" />
    <style>
        .Casual {
            color: red;
        }
        .Additional {
            color: green;
        }

        #dd_assignedto, #search, #dd_status {
            background-color: #EFEFEF;
            border-radius: 4px;
            border: 1px solid #D0D0D0;
            overflow: auto;
            height: 25px;
        }

        option {
            background-color: #82caff;
        }

        .toggle {
            margin: 4px;
            background-color: #EFEFEF;
            border-radius: 4px;
            border: 1px solid #D0D0D0;
            overflow: auto;
            float: left;
        }

        .toggle label {
            float: left;
            width: 5.0em;
        }

        .toggle label span {
            text-align: center;
            display: block;
            cursor: pointer;
        }

        .toggle label input {
            display: none;
        }

        .toggle .input-checked /*, .bounds input:checked + span works for firefox and ie9 but breaks js for ie8(ONLY) */ {
           background-color: lightgreen;
        }


      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 600px;
        width: 100%;
        display: none;
      }
     

    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Scripts/addclear.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/moment/moment.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/jquery.ui.autocomplete.scroll.min.js")%>"></script>

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4EiyE4AE79M4SpyzGYG7KAB6trfGUdsI"></script>

    <script type="text/javascript">
        //&callback=initMap

        var map;
        var markers = [];
        //var bounds;  
        //BOUNDS ARE GOOD FOR SETTING THE MAP TO HAVE BOUNDARIES ENCOMPASSING ALL THE MARKERS
        //HOWEVER BECAUSE I CLEAR THE MARKERS WHEN REFRESHING THE MAP AND THERE IS NO WAY OF REMOVING THE MARKERS FROM THE BOUND
        //I'M NOT DOING IT FOR NOW

        var updatetimer;

        var id = "";
        var version_ctr = 0;
        var otherperson = "";
        var otherpersondelim = "";
        var updating = false;

        var status_values = '<%:status_values%>';
        var status_array = status_values.split(',');
        var assignedto_array = '<%:assignedto_values%>'.split(',');
        var missingicons = '<%:missingicons%>'.split(',');

        var jsondata = htmlDecode("<%:passresult %>");
        mydata = $.parseJSON(jsondata);

        $(document).ready(function () {

            $.each(mydata, function (index, value) {
                myid = value.enrollmentId;
                tr = '<tr id="tr_' + myid + '" class="' + value.enrolementStatus + '" data-version="' + value.version_ctr + '" data-gender="' + value.gender + '" data-status="' + value.enrolementStatus + '" data-name="' + value.name + '">';
                //tr += '<td id="name_' + myid + '">' + value.name + myid + 'v<span id="span_' + myid + '">' + value.version_ctr + '</span></td>';
                tr += '<td id="name_' + myid + '">' + value.name + '</td>';
                //console.log(value.name);
                var addresses = "";
                var addresses_cnt = 0;
                $.each(value.address, function (subindex, subvalue) {
                    addresses += '<option>' + subvalue.address + '</option>';
                    addresses_cnt += 1;
                    otherperson += otherpersondelim + value.name + "~" + subvalue.address;
                    otherpersondelim = "|";
                });
                tr += '<td><select class="address" id="address_' + myid + '" data-value="' + value.pickupRunAddress + '" data-count="' + addresses_cnt + '">' + addresses + '</select></td>';
                tr += '<td><select class="status" id="status_' + myid + '" data-value="' + value.status + '"><option></option></select></td>';
                tr += '<td><select class="assignedto" id="assignedto_' + myid + '" data-value="' + value.assignedTo + '"><option></option></select></td>';
                tr += '</tr>';
                $('#tbl_data').append(tr);
            });

            var name_addresses_array = otherperson.split('|');

            $("#search").addClear();
            
            var status_options = "";
            for (var i = 0; i < status_array.length; i++) {
                status_options += "<option>" + status_array[i] + "</option>";
            }
            $(".status").append(status_options);
            
            var assignedto_options = "";
            for (var i = 0; i < assignedto_array.length; i++) {
                assignedto_options += "<option>" + assignedto_array[i] + "</option>";
            }
            $(".assignedto").append(assignedto_options);

            $("#dd_assignedto").append(assignedto_options);
            
            $('#tbl_data > tbody  > tr').each(function () {
                myid = $(this).attr("id").substring(3);
                $("#status_" + myid).val($("#status_" + myid).data("value"));
                $("#assignedto_" + myid).val($("#assignedto_" + myid).data("value"));
                addressvalue = $("#address_" + myid).data("value");
                if ($("#address_" + myid + " option:contains('" + addressvalue + "')").length == 0) {
                    $("#address_" + myid).append("<option>" + addressvalue + "</option>");
                }
                $("#address_" + myid).val(addressvalue);
            });

            showhideclasses();

            $('label').click(function () {
                if ($(this).find('input').is(":checked")) {
                    $(this).children('span').addClass('input-checked');
                } else {
                    $(this).children('span').removeClass('input-checked');
                }
                showhideclasses();
            });
            $("#dd_assignedto").change(function () {
                showhideclasses()
            });
            $("#dd_status").change(function () {
                showhideclasses()
            });

            $("#btn_add").click(function () {
                $("#dialogadd").dialog("open");
            });
            $("#btn_addsubmit").click(function () {
                $("#addname").val('');
                $("#dialogadd").dialog("close");
            });

            $("#btn_map").click(function () {
                if ($('#map').is(":visible")) {
                    hideMap();
                } else {
                    showMap();
                }

            });

            $("#search").change(function () {
                showhideclasses();
            });

            //$("#btn_test").click(function () {
            //    checkforupdates();
            //});

            function checkforupdates() {

                //$("#span_status").html("Updated:" + moment().format('hh:mm:ss'));
                while (updating == true) {

                }
                if (updating == true) {
                    alert('Tell Greg: How can I be here if updating is true');
                }
                //$("#debug").text(Date);
                versions = "";
                versionsdelim = "";
                $('#tbl_data > tbody  > tr').each(function () {
                    myid = $(this).attr("id").substring(3);
                    $("#name_" + myid).css("background-color", "");
                    myversion = $(this).data("version");
                    versions += versionsdelim + myid + '|' + myversion;
                    versionsdelim = "|";
                });
                //console.log(versions);
                param = "data.asmx/pickup_checkforupdates?data=" + versions;
                $.getJSON(param, function (result) {

                    //$(document.body).keydown(false);
                    updatesdone = false;
                    $.each(result, function (i, field) {
                        //$("#debug").text("");
                        myid = field.enrolementid;
                        debugtxt = "update: " + field.enrolementid + " address=" + field.address + " status=" + field.status + " assignedto=" + field.assignedto + " version_ctr=" + field.version_ctr;
                        //$("#debug").append();
                        console.log(debugtxt);
                        $("#tr_" + myid).data("version", field.version_ctr);
                        $("#name_" + myid).css('background-color', 'red');
                        //address_cnt = $("#address_" + myid).data("count");
                        //address_length = $("#address_" + myid).length;
                        //alert(address_cnt + ", " + address_length);
                        //if (address_length > address_cnt) {
                        //    alert("delete last address line");
                        //}
                        //$("#span_" + myid).text(field.version_ctr);
                        if ($("#address_" + myid + " option:contains('" + field.address + "')").length == 0) {
                            $("#address_" + myid).append("<option>" + field.address + "</option>");
                        }
                        $("#address_" + myid).val(field.address);
                        $("#status_" + myid).val(field.status);
                        $("#assignedto_" + myid).val(field.assignedto);
                        updatesdone = true;
                    });
                    if (updatesdone == true) {
                        showhideclasses();
                    }
                });

                //$("#span_status").text("xxx");

                //$(document.body).keydown(true);
                updatetimer = setTimeout(checkforupdates, 10000)
            }

            $(".address").prepend("<option></option>");
            $(".address").append("<option>Other Address</option><option>Other Person</option>");

            $("#dialogaddress").dialog({
                autoOpen: false,
                buttons: {
                    OK: function () {
                        //var addresses_cnt = $("#address_" + id).data("count") + 2;
                        //$("#address_" + id + " option").eq(addresses_cnt).remove(); 
                        if ($("#otheraddress").val() == "") {
                            $("#address_" + id + " option").eq(0).prop('selected', true);
                            if ($("#status_" + id).val() == "Picked up from another address") {
                                $("#status_" + id + " option").eq(0).prop('selected', true);
                            }
                        } else {
                            if ($("#address_" + id + " option:contains('" + $("#otheraddress").val() + "')").length == 0) {
                                $("#address_" + id).append($('<option>', {
                                    text: $("#otheraddress").val(),
                                    selected: "selected"
                                }));
                            } else {
                                $("#address_" + id).val($("#otheraddress").val());
                            }
                            update();
                        }
                        $(this).dialog("close");
                    }
                },
                close: function (event, ui) {
                    $("#otheraddress").val('');
                },
                create: function () {
                    $(this).closest('div.ui-dialog')
                           .find('.ui-dialog-titlebar-close')
                           .click(function (e) {
                               $("#address_" + id + " option").eq(0).prop('selected', true);
                               if ($("#status_" + id).val() == "Picked up from another address") {
                                   $("#status_" + id + " option").eq(0).prop('selected', true);
                               }
                               e.preventDefault();
                           });
                }
            });

            $("#dialogperson").dialog({
                autoOpen: false,
                width: 400,
                height: 350
            });
            $("#dialogadd").dialog({
                autoOpen: false,
            });

            $(".address").change(function () {
                id = $(this).parents('tr').attr("id").substring(3);
                version_ctr = $(this).parents('tr').data("version");
                if ($(this).val() == 'Other Address') {
                    $("#dialogaddress").dialog("open");
                } else if ($(this).val() == 'Other Person') {
                    $("#address_" + id + " option").eq(0).prop('selected', true);
                    $("#dialogperson").dialog("open");
                } else {
                    update();
                }
            });

            $(".status").change(function () {
                //alert('Status Change');
                id = $(this).parents('tr').attr("id").substring(3);
                version_ctr = $(this).parents('tr').data("version");
                if ($(this).val() == 'Picked up from another address') {
                    $("#dialogaddress").dialog("open");
                } else {
                    update();
                    //if ($('#cb_todo').is(":checked")) {
                    //    showhideclasses();
                    //}
                    if ($('#dd_status').val() != "All") {
                        showhideclasses();
                    }
                }
            });

            $(".assignedto").change(function () {
                id = $(this).parents('tr').attr("id").substring(3);
                version_ctr = $(this).parents('tr').data("version");
                update();
                if ($("#dd_assignedto").val() != "All") {
                    showhideclasses();
                } else {
                    if ($('#map').is(":visible")) {
                        removemarkers();
                        showMap();
                    }
                }
            });

            $("#otherperson").autocomplete({
                maxShowItems: 5,
                source: name_addresses_array,
                select: function (event, ui) {
                    myaddresses = ui.item.label.split('~');

                    if ($("#address_" + id + " option:contains('" + myaddresses[1] + "')").length == 0) {
                        $("#address_" + id).append($('<option>', {
                            text: myaddresses[1],
                            selected: "selected"
                        }));
                    } else {
                        $("#address_" + id).val(myaddresses[1]);
                    }
                    $("#dialogperson").dialog("close");
                    update();
                }
            })
            .autocomplete("instance")._renderItem = function (ul, item) {
                nameaddress = item.label.split('~');
                return $("<li>")
                  .append("<div>" + nameaddress[0] + "<br>" + nameaddress[1] + "</div>")
                  .appendTo(ul);
            };

            function update() {
                updating = true;
                address = $("#address_" + id).val();
                status = $("#status_" + id).val();
                assignedto = $("#assignedto_" + id).val();
                //debugtxt = 'do update for id: ' + id + ' version: ' + version_ctr + ', ' + address + ', ' + status + ', ' + assignedto;
                //$("#debug").text(debugtxt);
                //console.log(debugtxt)
                param = "data.asmx/pickups_update?id=" + id + "&version=" + version_ctr + "&address=" + address + "&status=" + status + "&assignedto=" + assignedto + "&date=";
                $.getJSON(param, function (result) {
                    $.each(result, function (i, field) {
                        //alert(id + ", " + field.version_ctr);
                        if (field.message != 'Updated') {
                            alert(field.message);
                        }
                        $("#tr_" + id).data("version", field.version_ctr);
                        //$("#span_" + id).text(field.version_ctr);
                    });
                });
                updating = false;
            }

            function showhideclasses() {
                searchname = $("#search").val().toLowerCase();
                enrolementstatus = "|Current|Casual / Coming|Additional";
                if ($('#cb_casual').is(":checked")) {
                    enrolementstatus += "|Casual";
                }
                enrolementstatus += "|";

                //if ($('#cb_todo').is(":checked")) {
                //    todo = "|Coming|No Response|Call in|Will make their own way|";
                //} else {
                //    todo = "";
                //}
                if ($('#dd_status').val() == "To do") {
                    todo = "|Coming|No Response|Call in|Will make their own way|";
                } else if ($('#dd_status').val() == "Came") {
                    todo = "|Picked up|Picked up from another address|Made own way|";
                } else if ($('#dd_status').val() == "Attendance") {
                    todo = "|Coming|Picked up|Picked up from another address|Will make their own way|Made own way|";
                } else if ($('#dd_status').val() == "Unknown") {
                    todo = "||No Response|Call in|";



                } else {
                    todo = "";
                }



                gender = "|Unspecified";
                if ($('#cb_female').is(":checked")) {
                    gender += "|Female"
                }
                if ($('#cb_male').is(":checked")) {
                    gender += "|Male"
                }
                gender += "|";
                assigned = $("#dd_assignedto").val();
                /*
                console.log('searchname=' + searchname);
                console.log('enrolementstatus=' + enrolementstatus);
                console.log('todo=' + todo);
                console.log('gender=' + gender);
                console.log('assigned=' + assigned);
                */

                var c1 = 0;

                $('#tbl_data > tbody  > tr').each(function () {
                    myname = $(this).data("name").toLowerCase();
                    mygender = $(this).data("gender");
                    myenrolementstatus = $(this).data("status");
                    myassigned = $(this).find(".assignedto").val();
                    mystatus = $(this).find(".status").val();
                    myaddress = $(this).find(".address").val() + '';
                    if (myaddress == 'null') { myaddress = '' };
                    //alert(myenrolementstatus + '-' + enrolementstatus);
                    //alert(mystatus + '|' + myassigned + '|' + myaddress);

                    if ((gender.indexOf('|' + mygender + '|') != -1) && (enrolementstatus.indexOf('|' + myenrolementstatus + '|') != -1 || ( mystatus != '' || myassigned != '' || myaddress != ''   ) ) && (myassigned == assigned || assigned == 'All') && (searchname == "" || myname.indexOf(searchname) != -1) && (todo.indexOf('|' + mystatus + '|') != -1 || todo == '')) {
                        $(this).show();
                        c1 = c1 + 1;
                    } else {
                        $(this).hide();
                        /*
                        console.log(myname);
                        console.log(mygender);
                        console.log(myenrolementstatus);
                        console.log(myassigned);
                        console.log(mystatus);
                        console.log(myaddress);
       */

                    }
                });
                $("#span_status").html(c1);

                if ($('#map').is(":visible")) {
                    removemarkers();
                    showMap();
                }

            }
            checkforupdates();

            function UrlExists(url) {
                alert(url);
                var result;
                $.ajax({
                    url: url,
                    success: function (data) {
                        alert(1);
                        result = true;
                    },
                    error: function (data) {
                        result = false;
                        alert(2);
                    },
                })
                //alert(result);
                return result;
            }

 

        })

        function htmlDecode(input) {
            var e = document.createElement('div');
            e.innerHTML = input;
            return e.childNodes[0].nodeValue;
        }

        function initMap() {

            map = new google.maps.Map(document.getElementById('map'));
            geocoder = new google.maps.Geocoder();
            // SEE COMMENTS ABOUT BOUNDS ABOVE   bounds = new google.maps.LatLngBounds();
        }

        function showMap() {
            if (typeof map == 'undefined') {
                initMap();
            }

            addMarker({ lat: -39.936008, lng: 175.016227 }, "TE ORA HOU", "TOH");

            $('#tbl_data > tbody  > tr:visible').each(function () {
                myaddress = $(this).find(".address").val();
                assignedto = $(this).find(".assignedto").val();
                title = $(this).data("name");
                if (myaddress != null && myaddress != "") {
                    geocodeAddress(geocoder, map, myaddress, title, assignedto);
                }
            });
            // SEE COMMENTS ABOUT BOUNDS ABOVE   map.fitBounds(bounds);

            if ($('#map').is(":hidden")) {
                map.setCenter({ lat: -39.936008, lng: 175.016227 });
                map.setZoom(13);
            }


            $('#map').show();
        }

        function removemarkers() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        function hideMap() {
            removemarkers();
            $('#map').hide();
        }

        function geocodeAddress(geocoder, resultsMap, address, title, assignedto) {
            myaddress = address + ',Whanganui'

            $.getJSON('http://maps.googleapis.com/maps/api/geocode/json?address=' + myaddress + '&sensor=false', null, function (data) {
                var p = data.results[0].geometry.location
                var latlng = new google.maps.LatLng(p.lat, p.lng);
                addMarker(latlng, title + ' - ' + address, assignedto);
            });
        }

        function addMarker(location, title, icon) {
            if ($.inArray(icon, missingicons) != -1) {
                title = title + " (" + icon + ")";
                icon = 'unknown';
            }

            icon = 'icons/' + icon + '.png';


            var marker = new google.maps.Marker({
                position: location,
                title: title,
                icon: icon,
                map: map
            });
            // SEE COMMENTS ABOUT BOUNDS ABOVE   bounds.extend(marker.position);
            markers.push(marker);
            

        }

        

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:HiddenField ID="hf_data" runat="server" />
    <!--<div id="debug">xxxx</div>-->

    <div id="map"></div>


    <div class="toggle">
        <label>
            <input id="cb_male" type="checkbox" checked="checked" /><span class="input-checked">Male</span></label>
    </div>
    <div class="toggle">
        <label>
            <input id="cb_female" type="checkbox" checked="checked" /><span class="input-checked">Female</span></label>
    </div>
    <!--
    <div class="toggle">
        <label>
            <input id="cb_todo" type="checkbox" /><span>To Do</span></label>
    </div>
    -->

    <select id="dd_status">
        <option>All</option>
        <option>To do</option>
        <option>Attendance</option>
        <option>Unknown</option>
        <option>Came</option>
    </select>

    <div class="toggle">
        <label>
            <input id="cb_casual" type="checkbox" /><span>Casual</span></label>
    </div>

    <select id="dd_assignedto">
        <option>All</option>
        <option></option>
    </select>

    <!--<input id="btn_test" type="button" value="Test" />-->
    <input id="search" type="text" style="width:50px" />
    <input id="btn_add" type="button" value="Add" style="display:none"/>
    <span id="span_status" style="color: red"></span>

    <input id="btn_map" type="button" value="Map" />

    <table id="tbl_data" class="table table-striped">
        <tbody></tbody>
    </table>

    <div id="dialogaddress" title="Other Address">
        <input id="otheraddress" type="text" style="width: 95%" /></div>
    <div id="dialogperson" title="Other Person">
        <input id="otherperson" type="text" style="width: 95%" /></div>
    <div id="dialogadd" title="Add Person">
        <input id="addname" type="text" style="width: 95%" />
        <input id="btn_addsubmit" type="button" value="Submit" />
    </div>
</asp:Content>