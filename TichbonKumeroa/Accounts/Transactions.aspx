<%@ Page Title="" Language="C#" MasterPageFile="~/TichbonKumeroa.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="TichbonKumeroa.Accounts.Transactions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        <!--
        body, td, th {
            font-size: 8px;
            font-family: Verdana, Arial, Helvetica, sans-serif;
        }

        .recurring td {
            background-color: #00CC00;
            border-color: #00CC00; 
        }

        .transactionamount {
            text-align: right;
            text-wrap: none;
        }

        .itemnarrative {
            width: 200px;
        }

        .itemamount {
            text-align: right;
            width: 50px;
        }

        .greg {
            background-color: #00FFFF;
        }

        .jude {
            background-color: #FF66CC;
        }

        .datagrid {
            font-size: 8px;
            color: #333333;
            width: 100%;
            border-width: 1px;
            border-color: #729ea5;
            border-collapse: collapse;
        }

        .datagrid th {
            font-size: 8px;
            background-color: #acc8cc;
            border-width: 1px;
            padding: 2px;
            border-style: solid;
            border-color: #729ea5;
            text-align: left;
        }

        .datagrid tr {
            background-color: #d4e3e5;
        }

        .datagrid td {
            font-size: 8px;
            border-width: 1px;
            padding: 2px;
            border-style: solid;
            border-color: #729ea5;
        }

        .datagrid tr:hover {
            background-color: #ffffff;
        }
-->
    </style>
    <script type="text/javascript">
        var tbl_items = "";
        var codingsearch_options = "";
        var coding_options = "";
        var recurring = "";
        var newkey = 0;


        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            var account_options = '<option value=""></option>';
            $.getJSON("data.asmx/get_account_options", function (data) {
                $.each(data, function (i, item) {
                    account_options += '<option value="' + item.fullaccount + '">' + item.fullaccount + '</option>';
                });
                $('#account').append(account_options);
            });


            var lasttype = '';
            var lastarea = '';
            //$.getJSON("data.asmx/get_coding_options", function (data) {
            //$.each(data, function (i, item) {
            $.ajax({
                async: false,
                url: "data.asmx/get_coding_options", success: function (result) {
                    codingarray = $.parseJSON(result);
                    $.each(codingarray, function (i, item) {

                        if (item.type != lasttype) {
                            if (codingsearch_options != '') {
                                codingsearch_options += '</optgroup>';
                                codingsearch_options += '</optgroup>';
                                coding_options += '</optgroup>';
                                coding_options += '</optgroup>';
                            }
                            codingsearch_options += '<optgroup disabled="disabled" label="&nbsp;' + item.type + '">';
                            codingsearch_options += '<optgroup label="&nbsp;&nbsp;&nbsp;&nbsp;' + item.area + '">';
                            coding_options += '<optgroup disabled="disabled" label="&nbsp;' + item.type + '">';
                            coding_options += '<optgroup label="&nbsp;&nbsp;&nbsp;&nbsp;' + item.area + '">'; lasttype = item.type;
                            lastarea = item.area;
                        } else {
                            if (item.area != lastarea) {
                                if (codingsearch_options != '') {
                                    codingsearch_options += '</optgroup>';
                                    coding_options += '</optgroup>';
                                }
                                codingsearch_options += '<optgroup label="&nbsp;&nbsp;&nbsp;&nbsp;' + item.area + '">';
                                coding_options += '<optgroup label="&nbsp;&nbsp;&nbsp;&nbsp;' + item.area + '">';
                                lastarea = item.area;
                            }
                        }
                        codingsearch_options += '<option value="' + item.codeid + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + item.detail + '</option>';
                        coding_options += '<option value="' + item.codeid + '">' + item.type.substring(0, 1) + item.area.substring(0, 1) + item.detail.substring(0, 3) + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + item.detail + '</option>';
                    });
                    codingsearch_options += '</optgroup>';
                    codingsearch_options += '</optgroup>';
                    coding_options += '</optgroup>';
                    coding_options += '</optgroup>';
                    $('#coded').append(codingsearch_options);
                    $('#coded').multipleSelect({
                        selectAll: false,
                        intcountSelected: 1
                    });
                }
            });

            $("#latest").click(function () {
                $('#account').val('All');
                $('#uncoded').prop('checked', true);
                var now = new Date();
                now.setDate(now.getDate() - 14);
                var d = now.getDate();
                var m = now.getMonth() + 1;
                var y = now.getFullYear();
                $('#fromdate').val(d + "/" + m + "/" + y);
                $('#todate').val('');
            });

            $('body').on('click', '.additem', function () {
                transactionid = $(this).attr('id').substring(8);
                //alert(transactionid);
                tbl_item = newitem(transactionid);
                //alert(tbl_item);
                $('#tbl_tran_' + transactionid).append(tbl_item);
                

            });

            $("#submit").click(function () {
                alert('Save any changed records and load according to specified params');
                getdata();
            });

        });

        function nextnewkey() {
            newkey++;
        }

        function getdata() {
            $(".rowdata").remove();
            $.ajax({
                async: false,
                url: "data.asmx/get_transactions?account=" + $('#account').val() + "&creditcard=" + $('#creditcard').val() + "&uncoded=" + $('#uncoded').val() + "&datefrom=" + $('#datefrom').val() + "&dateto=" + $('#dateto').val() + "&search=" + $('#search').val() + "&coded=" + $('#coded').val(), success: function (result) {
                    transactionarray = $.parseJSON(result);
                    $.each(transactionarray, function (i, transaction) {
                        tbl_items = '';
                        $.ajax({
                            async: false,
                            url: "data.asmx/get_items?transactionid=" + transaction.transactionid, success: function (result) {
                                itemarray = $.parseJSON(result);
                                $.each(itemarray, function (i, item) {
                                    if (item.RecurringItemID != 0) {
                                        recurring = ' recurring';
                                    } else {
                                        recurring = '';
                                    }
                                    tbl_items = tbl_items + '<tr id="' + "item_" + item.itemid + '">';
                                    tbl_items = tbl_items + '<td><select data-selectvalue="' + item.code + '" id="itemcode_' + item.itemid + '">' + coding_options + '</select></td>';
                                    tbl_items = tbl_items + '<td><input class="itemnarrative" id="itemnarrative_' + item.itemid + ' value="' + item.narrative + '" /></td>';
                                    tbl_items = tbl_items + '<td><input class="itemamount" id="itemamount_' + item.itemid + ' value="' + item.amount + '" /></td>';
                                    tbl_items = tbl_items + '</tr>';
                                });
                                //itemid, narrative, code, amount, query, invoice, invoicenarrative, invoicenotes, RecurringItemID
                                if (tbl_items == "") {
                                    tbl_items = newitem(transaction.transactionid);
                                }
                                id = "tran_" + transaction.transactionid;
                                switch (transaction.account) {
                                    case '4367-****-****-5171':
                                        account = 'C/C <span class="jude">Jude</span>'
                                        break;
                                    case '4367-****-****-7433':
                                        account = 'C/C <span class="jude">Jude</span>'
                                        break;
                                    case '4367-****-****-8457':
                                        account = 'C/C <span class="greg">Greg</span>'
                                        break;
                                    default:
                                        account = transaction.account
                                }
                                switch (transaction.memo.substring(0, 25)) {
                                    case '4367-****-****-5171':
                                        memo = '<span class="judy">Judy</span> ' + transaction.memo
                                        break;
                                    case 'Eft Pos 4367******** 7433':
                                        memo = '<span class="jude">Jude</span> ' + transaction.memo
                                        break;
                                    case 'Eft Pos 4367******** 6457':
                                        memo = '<span class="greg">Greg</span> ' + transaction.memo
                                        break;
                                    default:
                                        memo = transaction.memo
                                }

                                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                                    $('<td>').html(account),
                                    $('<td>').html(transaction.type),
                                    $('<td>').html(transaction.posteddate),
                                    $('<td>').html(transaction.transactiondate),
                                    $('<td class="transactionamount">').html(transaction.amount),
                                    $('<td>').html(transaction.name),
                                    $('<td>').html(memo),
                                    $('<td class="additem" id="additem_' + transaction.transactionid + '">').html("Add"),
                                    $('<td>').html('<table id="tbl_' + id + '" class="coding' + recurring + '">' + tbl_items + '</table>'),
                                    $('<td>').html("Recurring")
                                ).appendTo('#tbl_transactions');
                            }
                        });
                    });
                }
            });


            $('[data-selectvalue]').each(function () {
                //alert( $(this).attr("id") + ":" +                         $(this).data("selectvalue") );
                $(this).val($(this).data("selectvalue"));
            });
            /*
	xtra = ""
	if uncoded = "yes" then
		having = " HAVING (((Sum(Items.[amount])) Is Null Or (Sum(Items.[amount]))<>[trnamt]))"
	end if
	if fromdate <> "" then
		xtra = xtra & " and dtposted >= #" & di.di_format(fromdate,"d mmm yyyy") & "#"
	end if
	if todate <> "" then
		xtra = xtra & " and dtposted <= #" & di.di_format(todate,"d mmm yyyy") & "#"
	end if
	if search <> "" then
		xtra = xtra & " and (transactions.myname like '%" & search & "%' or memo like '%" & search & "%' or items.narrative like '%" & search & "%'"
		if isnumeric(search) then xtra = xtra & " or abs(transactions.trnamt) = abs(" & search & ")"
		xtra = xtra & ")"
	end if
	if coded <> "" then
		xtra = xtra & " and [items].[code] in (" & coded & ")"
	end if
	sql = "SELECT Transactions.TransactionID, Transactions.fullaccount, Transactions.trntype, Transactions.dtposted, Transactions.trnamt, Transactions.fitid, Transactions.myname, Transactions.memo, Transactions.creditcard, Transactions.dttrans, Transactions.RecurringCreated, Transactions.RecurringCreateFrom, Sum([amount]) AS SumofItems " & _
			"FROM Transactions LEFT JOIN Items ON Transactions.TransactionID = Items.TransactionID " & _
			"where 1 = 1 "
			
	if account <> "All" then
		sql = sql & " and fullaccount = '" & account & "'" 
	end if
	if creditcard <> "" then
		sql = sql & " and right(creditcard,4) = '" & creditcard & "'" 
	end if
			
	sql = sql & xtra & " GROUP BY Transactions.TransactionID, Transactions.fullaccount, Transactions.trntype, Transactions.dtposted, Transactions.trnamt, Transactions.fitid, Transactions.myname, Transactions.memo, Transactions.creditcard, Transactions.dttrans, Transactions.RecurringCreated, Transactions.RecurringCreateFrom"
	
	sql = sql & having & " order by fullaccount, creditcard, dtposted desc, Transactions.transactionid desc"
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	set rsi =  Server.CreateObject("ADODB.Recordset")
	rs.Open sql, db


	do until rs.eof
		c1 = c1 + 1
	
		response.write "<tr>"
		if account = "All" then
				response.write "<td>" & rs("fullaccount") & "</td>"
		end if
		if cc or account = "All" then 
			response.write "<td>" 
			response.write right(rs("creditcard"),4)
			if right(rs("creditcard"),4) = "7433" then
				response.write "<br><span class=""jude"">Jude</span>"
			elseif right(rs("creditcard"),4) = "8457" then
				response.write "<br><span class=""greg"">Greg</span>"
			end if			
			response.write "</td>"
		end if
		response.write "<td>" & rs("trntype") & "</td>"
		response.write "<td>" & di.di_format(rs("dtposted"),"ddd") & " " & rs("dtposted") & "</td>"
		if cc or account = "All" then response.write "<td>" & di.di_format(rs("dttrans"),"ddd") & " " & rs("dttrans") & "</td>"		
		response.write "<td nowrap align=""right""><input name=""amt_" & rs("transactionid") & """ id=""amt_" & rs("transactionid") & """ type=""hidden"" value=""" & rs("trnamt") & """>" & formatcurrency(rs("trnamt")) & "</td>"
		response.write "<td>" & rs("myname") & "</td>"
		response.write "<td>"
		response.write rs("memo")
		if left(rs("memo"),25) = "Eft Pos 4367******** 7433" then
			response.write "<br><span class=""jude"">Jude</span>"
		elseif left(rs("memo"),25) = "Eft Pos 4367******** 8457" then
			response.write "<br><span class=""greg"">Greg</span>"
		end if			
		response.write "</td>"
		response.write "<td bgcolor=""red"" class=""add"" id=""row_" & rs("transactionid") & """></td>"
		
		response.write "<td><table class=""coding"" id=""items_" & rs("transactionid") & """>"
		sql = "select * from items where transactionid = " & rs("transactionid")
		rsi.Open sql, db
		tot = 0
		lcnt = 0
		allowrecurring = true
		if rsi.eof then
'recurring, makesure ids are correct
			sql = "select RecurringItems.Narrative, RecurringItems.Code, RecurringItems.Amount " & _
				  "FROM Recurring INNER JOIN RecurringItems ON Recurring.RecurringID = RecurringItems.RecurringID " & _
				  "where fullaccount = '" & rs("fullaccount") & "' and trntype = '" & rs("trntype") & "' and trnamt = " & rs("trnamt") & " and myname = '" & replace(rs("myname") & "","'","") & "' and memo = '" & rs("memo") & "'"
			rsr.Open sql, db
			do until rsr.eof 
				allowrecurring = false
				tot = tot + rsr("amount")
				lcnt = lcnt + 1
				tid = rs("transactionid") & "." & lcnt
				response.write "<tr class=""item newrecurring"">"
				response.write "<td>"
				response.write "<input transactionid=""" & tid & """ type=""hidden"" id=""invoice_new" & tid & """ name=""invoice_new" & tid & """ value="""">"
				response.write "<input transactionid=""" & tid & """ type=""hidden"" id=""invoicenarr_new" & tid & """ name=""invoicenarr_new" & tid & """ value="""">"
				response.write "<img class=""edititem"" id=""edititem_new" & rs("transactionid") & """ src=""add.jpg"">"
				response.write "</td>"
				response.write "<td><select transactionid=""" & tid & """ selvalue=""" & rsr("code") & """ class=""codingoptions"" id=""code_new" & tid & """ name=""code_new" & tid & """ size=""1""></select></td>"
				response.write "<td><input transactionid=""" & tid & """ class=""narrative"" type=""text"" size=""50"" id=""narr_new" & tid & """ name=""narr_new" & tid & """ value=""" & rsr("narrative") & """></td>"
				response.write "<td><input transactionid=""" & tid & """ class=""amount"" type=""text"" size=""10"" id=""amount_new" & tid & """ name=""amount_new" & tid & """ value=""" & rsr("amount") & """></td>"
				response.write "</tr>"
				rsr.movenext
			loop
			rsr.close
		else
			do until rsi.eof
				allowrecurring = false
				tot = tot + rsi("amount")
				lcnt = lcnt + 1
				tid = rs("transactionid") & "." & lcnt
				response.write "<tr class=""item"" id=""row_" & rsi("itemid") & """>"
				response.write "<td>"
				response.write "<input transactionid=""" & tid & """ type=""hidden"" id=""invoice_" & rsi("itemid") & """ name=""invoice_" & rsi("itemid") & """ value=""" & rsi("invoice") & """>"
				response.write "<input transactionid=""" & tid & """ type=""hidden"" id=""invoicenarr_" & rsi("itemid") & """ name=""invoicenarr_" & rsi("itemid") & """ value=""" & rsi("invoicenarrative") & """>"
				response.write "<img class=""edititem"" transactionid=""" & tid & """ id=""edititem" & rsi("itemid") & """ src=""add.jpg"">"
				response.write "</td>"				
				response.write "<td><select transactionid=""" & tid & """ selvalue=""" & rsi("code") & """ class=""codingoptions"" id=""code_" & rsi("itemid") & """ name=""code_" & rsi("itemid") & """ size=""1""></select></td>"
				response.write "<td><input transactionid=""" & tid & """ class=""narrative"" type=""text"" size=""50"" id=""narr_" & rsi("itemid") & """ name=""narr_" & rsi("itemid") & """ value=""" & rsi("narrative") & """></td>"
				response.write "<td><input transactionid=""" & tid & """ class=""amount"" type=""text"" size=""10"" id=""amount_" & rsi("itemid") & """ name=""amount_" & rsi("itemid") & """ value=""" & formatcurrency(zeroise(rsi("amount"))) & """></td>"
				response.write "</tr>"
				rsi.movenext
			loop
		end if
		rsi.close
		if tot <> rs("trnamt") then	
			lcnt = lcnt + 1
			tid = rs("transactionid") & "." & lcnt
			response.write "<tr class=""item"">"
			response.write "<td>"
			response.write "<input transactionid=""" & tid & """ type=""hidden"" id=""invoice_new" & rs("transactionid") & """ name=""invoice_new" & rs("transactionid") & """ value="""">"
			response.write "<input transactionid=""" & tid & """ type=""hidden"" id=""invoicenarr_new" & rs("transactionid") & """ name=""invoicenarr_new" & rs("transactionid") & """ value="""">"
			response.write "<img class=""edititem"" id=""edititem_new" & tid & """ transactionid=""" & rs("transactionid") & """ src=""add.jpg"">"
			response.write "</td>"
			response.write "<td><select transactionid=""" & tid & """ class=""codingoptions"" name=""code_new" & rs("transactionid") & """ id=""code_new" & rs("transactionid") & """ size=""1""></select></td>"
			response.write "<td><input transactionid=""" & tid & """ class=""narrative"" type=""text"" size=""50"" id=""narr_new" & rs("transactionid") & """ name=""narr_new" & rs("transactionid") & """ value=""""></td>"
			response.write "<td><input transactionid=""" & tid & """ class=""amount"" type=""text"" size=""10"" id=""amount_new" & rs("transactionid") & """ name=""amount_new" & rs("transactionid") & """ value=""""></td>"
			response.write "</tr>"
		end if
		response.write "</table></td>"
		
		if rs("RecurringCreated") & "" <> "" or rs("RecurringCreateFrom") & "" <> "" or not(allowrecurring) then
			recurring = "&nbsp;"
		else
			recurring = "<div id=""x" & rs("transactionid") & """><a href=""javascript:void(0);"" onClick=""javascript:recordrecurring('x" & rs("transactionid") & "', " & rs("transactionid") & ");"">Create</a></div>"
		end if
		response.write "<td>" & recurring & "</td>"
		response.write "</tr>" 
		rs.movenext
	loop

	
	set rsi = nothing
	rs.close
	set rs = nothing
	set rsr = nothing
	db.close
	set db = nothing	
    */
        }

        

        function newitem(transactionid) {
            nextnewkey();
            id = 'new_' + transactionid + '_' + newkey;
            tbl_item = '<tr id="item_' + id + '">';
            tbl_item = tbl_item + '<td><select id="itemcode_' + id + '"><option></option>' + coding_options + '</select></td>';
            tbl_item = tbl_item + '<td><input class="itemnarrative" id="itemnarrative_' + id + '" /></td>';
            tbl_item = tbl_item + '<td><input class="itemamount" id="itemamount_' + id + '" /></td>';
            tbl_item = tbl_item + '</tr>';
            return tbl_item;
        }

        function savedata() {

        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%; vertical-align: middle">
        <tr style="background-color: aqua">
            <td>Account:
            <select name="account" size="1" id="account">
                <option value="">--- Select ---</option>
                <option value="All">All</option>
            </select></td>
            <td>Credit Card:
            <select name="creditcard" size="1" id="creditcard">
                <option value="">Either</option>
                <option value="7433, 5171'">5171 / 7433 - Jude</option>
                <option value="8457">8457 - Greg</option>
            </select></td>
            <td>Uncoded only:    
            <input name="uncoded" type="checkbox" id="uncoded" value="yes" /></td>
            <td>From:
            <input name="datefrom" type="text" id="datefrom" value="1 Oct 2016" /></td>
            <td>To:
            <input name="dateto" type="text" id="dateto" value="31 Oct 2016" /></td>
            <td>Search:
            <input name="search" type="text" id="search" /></td>
            <td>Coded:
            <select name="coded" multiple="multiple" id="coded">
            </select></td>
            <td>Inhibit update:
            <input name="inhibitupdate" type="checkbox" id="inhibitupdate" value="yes" /></td>
            <td><a id="latest" href="javascript:void(0)">Latest</a></td>
            <td>
                <input type="button" id="submit" value="Submit" /></td>
        </tr>
    </table>

    <table id="tbl_transactions" class="datagrid" style="width: 100%; vertical-align: middle">
        <tr>
            <th>Account</th>
            <th>Type</th>
            <th>Date Posted</th>
            <th>Transaction Date </th>
            <th style="text-align: right">Amount</th>
            <th>Name</th>
            <th>Memo</th>
            <th>Add</th>
            <th>Coding</th>
            <th>Recuring</th>
        </tr>
    </table>
</asp:Content>
