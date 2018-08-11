<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <title>Vehicle Reminders</title>

    <link rel="stylesheet" type="text/css" href="datatables/DataTables-1.10.15/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" type="text/css" href="datatables/FixedColumns-3.2.2/css/fixedColumns.dataTables.min.css" />

    <script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>

    <script type="text/javascript" src="datatables/DataTables-1.10.15/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="datatables/FixedColumns-3.2.2/js/dataTables.fixedColumns.min.js"></script>
    <script type="text/javascript" charset="utf-8">

/* Create an array with the values of all the input boxes in a column */
$.fn.dataTable.ext.order['dom-text'] = function  ( settings, col )
{
    return this.api().column( col, {order:'index'} ).nodes().map( function ( td, i ) {
        return $('input', td).val();
    });
}

/* Create an array with the values of all the input boxes in a column */
$.fn.dataTable.ext.order['dom-date'] = function  ( settings, col )
{
    return this.api().column( col, {order:'index'} ).nodes().map( function ( td, i ) {
        return daysdiff($('input', td).val(),'1900,1,1');
    });
}
 
/* Create an array with the values of all the input boxes in a column, parsed as numbers */
$.fn.dataTable.ext.order['dom-text-numeric'] = function  ( settings, col )
{
    return this.api().column(col, { order: 'index' }).nodes().map(function (td, i) {
        return $('input', td).val() * 1;
    });
}
 
/* Create an array with the values of all the select options in a column */
$.fn.dataTable.ext.order['dom-select'] = function  ( settings, col )
{
    return this.api().column( col, {order:'index'} ).nodes().map( function ( td, i ) {
        return $('select', td).val();
    });
}
 
/* Create an array with the values of all the checkboxes in a column */
$.fn.dataTable.ext.order['dom-checkbox'] = function  ( settings, col )
{
    return this.api().column( col, {order:'index'} ).nodes().map( function ( td, i ) {
        return $('input', td).prop('checked') ? '1' : '0';
    });
}

function daysdiff(sdate, edate) {
    if(sdate == '') {
        days = 0;
    } else {
        var parts = sdate.match(/(\d+)/g);
        var start = new Date(parts[2], parts[1]-1, parts[0]);
        var end   = new Date(edate)
        var diff  = new Date(end - start)
        var days = diff / 1000 / 60 / 60 / 24;
        //alert(start + ', '+ end + ', ' + days)
    }
    return days
}
        /*
                    <th>Registration</th>
                    <th>Description</th>
                    <th>WOF Due</th>
                    <th>Registration Due</th>
                    <th>Service Due</th>
                    <th>Notes</th>
                    <th>Email</th>
                    <th>Hold Email Till</th>
                    <th>Mobile</th>
                    <th>Hold Mobile Till</th>
                    <th>Odo</th>
                    <th>Del</th>
        */

            $(document).ready(function () {
                var oTable = $('#vehicles').dataTable({
                    "paging": false,
                    "info": false,
                    "order": [[0, "desc"]],
                    "searching": false,
                    "columns": [
                       { "orderDataType": "dom-text", type: 'string' },
                       { "orderDataType": "dom-text", type: 'string' },
                       { "orderDataType": "dom-date" },
                       { "orderDataType": "dom-date" },
                       { "orderDataType": "dom-date" },
                       { "orderDataType": "dom-text", type: 'string' },
                       { "orderDataType": "dom-text", type: 'string' },
                       { "orderDataType": "dom-date" },
                       { "orderDataType": "dom-text", type: 'string' },
                       { "orderDataType": "dom-date" },
                       null,
                       null
                    ],
                    "columnDefs": [
                        {
                            "targets": [ 10, 11 ],
                            "orderable": false
                        }
                    ]
                });
/*
				var oTable = $('#vehicles').dataTable( {
					"sScrollX": "100%",
					"bScrollCollapse": true,
					"bAutoWidth": false,
					"bFilter": false,
					"bPaginate": false,
					"bInfo": false,
					"aoColumnDefs": [
 					  	{ "sWidth": "250px", "aTargets": [ 1 ] },
 					  	{ "sWidth": "70px", "aTargets": [ 0, 2, 3, 4, 7, 9 ] },
 					  	{ "sWidth": "400px", "aTargets": [ 5, 6 ] },
 					  	{ "sWidth": "200px", "aTargets": [ 8 ] },
 					  	{ "sWidth": "40px", "aTargets": [ 10, 11 ] }
					]					
				} );
				new FixedColumns( oTable, {
					"iLeftColumns": 1
				} );
                */

            });

function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.vehicles;
/*	
	for(i=0; i<frm.elements.length; i++) {
		if(frm.elements[i].name.substring(0,5) == 'Email') {
			i = 1;
		} else {
			if(frm.elements[i].name.substring(0,6) == 'WOFDue') {
				if(frm.elements[i].value != '') {
					if(IsDate(frm.elements[i].value) != 'OK') {
						msg = msg + delim + ' - A valid WOF due date for Vehicle ' + frm.elements[i].name.substring(6);
						delim = '\n';
					}
				}
			} else {
				if(frm.elements[i].name.substring(0,15) == 'RegistrationDue') {
					i = 1;
				} else {
					if(frm.elements[i].name.substring(0,10) == 'ServiceDue') {
						i = 1;
					}
				}
			}
		}
	}	
*/

/*
	if(frm.email.value != '') {
		if(!(IsEmail(frm.email.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}
	
	if(frm.wofdue.value != '') {
		if(IsDate(frm.wofdue.value) != 'OK') {
			msg = msg + delim + ' - A valid WOF due date';
			delim = '\n';
		}
	}
	if(frm.servicedue.value != '') {
		if(IsDate(frm.servicedue.value) != 'OK') {
			msg = msg + delim + ' - A valid Service due date';
			delim = '\n';
		}
	}
	if(frm.registrationdue.value != '') {
		if(IsDate(frm.registrationdue.value) != 'OK') {
			msg = msg + delim + ' - A valid Registration due date';
			delim = '\n';
		}
	}
	if(frm.email.value != '') {
		if(IsEmail(frm.email.value,';') != 'OK') {
			msg = msg + delim + ' - Valid Email Addresses';
			delim = '\n';
		}
	}

	if(msg != '') {
		alert('You must enter valid information for the following:\n' + msg);
		return(false);
	}
*/
}
    </script>
</head>
<body>
    <h1>There is a problem with date formats.  Please enter dates in the format of d mmm yyyy eg: 5 Jul 2017</h1>
    <form name="vehicles" method="post" action="process.asp" onsubmit="return checkform();">
        <table class="display" cellspacing="0" width="100%" id="vehicles">
            <thead>
                <tr>
                    <th>Registration</th>
                    <th>Description</th>
                    <th>WOF Due</th>
                    <th>Registration Due</th>
                    <th>Service Due</th>
                    <th>Notes</th>
                    <th>Email</th>
                    <th>Hold Email Till</th>
                    <th>Mobile</th>
                    <th>Hold Mobile Till</th>
                    <th>Odo</th>
                    <th>Del</th>
                </tr>
            </thead>
            <tbody>
                <%
	'connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\datainn.co.nz\VehicleReminders.mdb"
 	connection_string = "Provider=SQLOLEDB;Data Source=VM29E6AC2\MSSQLSERVER2016; Initial Catalog = DataInnovations; User Id = Online; Password=Online"

	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT vehicle_CTR, registration, description, format(wofdue,'dd MMM yy') as wofdue, format(registrationdue,'dd MMM yy') as registrationdue , format(servicedue,'dd MMM yy') as servicedue , notes, email, format(holdemailtill,'dd MMM yy') as holdemailtill , mobile, format(holdmobiletill,'dd MMM yy') as holdmobiletill  from vehicle order by description, registration "
	rs.Open sql, db
	do until rs.EOF
		response.write "<tr>"
		response.write "<td><input name=""" & rs("vehicle_CTR") & """ type=""text"" id=""" & rs("vehicle_CTR") & """ style=""width:70px"" value=""" & rs("registration") & """ maxlength=""6""></td>"
		response.write "<td><input name=""description" & rs("vehicle_CTR") & """ type=""text"" id=""description" & rs("vehicle_CTR") & """ style=""width:250px"" value=""" & rs("description") & """></td>"
		response.write "<td><input name=""WOFDue" & rs("vehicle_CTR") & """ type=""text"" id=""WOFDue" & rs("vehicle_CTR") & """ style=""width:70px"" value=""" & rs("WOFDue") & """ maxlength=""11""></td>"
		response.write "<td><input name=""RegistrationDue" & rs("vehicle_CTR") & """ type=""text"" id=""RegistrationDue" & rs("vehicle_CTR") & """ style=""width:70px"" value=""" & rs("RegistrationDue") & """ maxlength=""11""></td>"
		response.write "<td><input name=""ServiceDue" & rs("vehicle_CTR") & """ type=""text"" id=""ServiceDue" & rs("vehicle_CTR") & """ style=""width:70px"" value=""" & rs("ServiceDue") & """ maxlength=""11""></td>"
		response.write "<td><input name=""Notes" & rs("vehicle_CTR") & """ type=""text"" id=""Notes" & rs("vehicle_CTR") & """ style=""width:400px"" value=""" & rs("Notes") & """></td>"
		response.write "<td><input name=""Email" & rs("vehicle_CTR") & """ type=""text"" id=""Email" & rs("vehicle_CTR") & """ style=""width:400px"" value=""" & rs("Email") & """></td>"
		response.write "<td><input name=""HoldEmailTill" & rs("vehicle_CTR") & """ type=""text"" id=""HoldEmailTill" & rs("vehicle_CTR") & """ style=""width:70px"" value=""" & rs("HoldEmailTill") & """ maxlength=""11""></td>"
		response.write "<td><input name=""Mobile" & rs("vehicle_CTR") & """ type=""text"" id=""Mobile" & rs("vehicle_CTR") & """ style=""width:200px"" value=""" & rs("Mobile") & """></td>"
		response.write "<td><input name=""HoldMobileTill" & rs("vehicle_CTR") & """ type=""text"" id=""HoldMobileTill" & rs("vehicle_CTR") & """ style=""width:70px"" value=""" & rs("HoldMobileTill") & """ maxlength=""11""></td>"
		response.write "<td><a href=""odometer.asp?vehicle_CTR=" & rs("vehicle_CTR") & """>Odo</a></td>"
		response.write "<td><input name=""_delete" & rs("vehicle_CTR") & """ type=""checkbox"" id=""_delete" & rs("vehicle_CTR") & """ value=""-1""></td>"
		response.write "</tr>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
                %>
                <tr>
                    <td>
                        <input name="new" type="text" id="new" value="" style="width: 70px" maxlength="6"></td>
                    <td>
                        <input name="descriptionnew" type="text" id="descriptionnew" value="" style="width: 250px"></td>
                    <td>
                        <input name="wofduenew" type="text" id="wofduenew" value="" style="width: 70px" maxlength="10"></td>
                    <td>
                        <input name="registrationduenew" type="text" id="registrationduenew" value="" style="width: 70px" maxlength="10"></td>
                    <td>
                        <input name="serviceduenew" type="text" id="serviceduenew" value="" style="width: 70px" maxlength="10"></td>
                    <td>
                        <input name="notesnew" type="text" id="notesnew" value="" style="width: 400px"></td>
                    <td>
                        <input name="emailnew" type="text" id="emailnew" value="" style="width: 400px"></td>
                    <td>
                        <input name="holdemailTilll" type="text" id="holdemailTilll" value="" style="width: 70px" maxlength="10"></td>
                    <td>
                        <input name="mobilenew" type="text" id="mobilenew" value="" style="width: 200px"></td>
                    <td>
                        <input name="holdmobileTilll" type="text" id="holdmobileTilll" value="" style="width: 70px" maxlength="10"></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <input name="submit" type="submit" id="submit" value="Submit">
    </form>
</body>
</html>
