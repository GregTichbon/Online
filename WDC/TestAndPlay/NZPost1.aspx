<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NZPost1.aspx.cs" Inherits="Online.TestAndPlay.NZPost1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <style>
        .ui-autocomplete-loading {
            background: white url("http://wdc.whanganui.govt.nz/eservices/images/processing_16x16.gif") right center no-repeat;
        }

        .ui-menu-item a {
            font-size: 10px;
        }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {
            $("#tb_residentialaddress").autocomplete({
                source: "https://address.nzpost.co.nz/api/find.json?address_line_1=7+waterloo+quay&address_line_2=wellington&callback=cb123&max=10&private_api_key=2bf67d1b2b1747f0AA68D3808032523D&type=All",
                minLength: 3,
                select: function (event, ui) {
                   alert(ui.item);
                }
            })
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


                <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="4"></textarea>



Takes an address fragment, and returns a set of addresses that match the fragment.

[Try it here](https://address.nzpost.co.nz/api/find/form)

### API Details

<table width="100%">
	<thead>
		<th scope="col">URL</th>
		<th scope="col">HTTP request types</th>
		<th scope="col">Request format</th>
		<th scope="col">Response formats</th>
	</thead>
	<tbody>
		<tr>
			<td>https://address.nzpost.co.nz/api/find</td>
			<td>GET</td>
			<td>application/x-www-form-urlencoded</td>
			<td>JSON, XML, HTML</td>
		</tr>
	</tbody>
</table>

### Request Parameters

<table width="100%">
	<thead>
		<th scope="col">Parameter</th>
		<th scope="col">Description</th>
		<th scope="col">Value</th>
		<th scope="col">Required</th>
		<th scope="col">Example</th>
	</thead>
	<tbody>
		<tr>
			<td>public_api_key or private_api_key</td>
			<td>An API Key allocated by NZ Post for your license, can be either your public or private api key. Read more here on which api key to use.</td>
			<td>String</td>
			<td>Yes</td>
			<td>639c1950-aea0-012e-9c7e-442c03203548</td>
		</tr>
		<tr>
			<td>address_line_1</td>
			<td>First line of address to query.</td>
			<td>String</td>
			<td>Yes</td>
			<td>7 waterloo quay</td>
		</tr>
		<tr>
			<td>address_line_2..5</td>
			<td>Other lines of address to query.</td>
			<td>String</td>
			<td>No</td>
			<td>wellington</td>
		</tr>
		<tr>
			<td>max</td>
			<td>Maximum number of results to return (defaults to 10).</td>
			<td>Integer</td>
			<td>No</td>
			<td>15</td>
		</tr>
		<tr>
			<td>type</td>
			<td>Type of addresses to search.<br>
				Either <i>Postal</i>, <i>Physical</i>, or <i>All</i> (default).</td>
			<td>String</td>
			<td>No</td>
			<td>Postal</td>
		</tr>
		<tr>
			<td>callback</td>
			<td>The JSONP callback function name.</td>
			<td>String</td>
			<td>No</td>
			<td>jquery2347823</td>
		</tr>
	</tbody>
</table>

### Response elements

<table width="100%">
	<thead>
		<th scope="col">Elements</th>
		<th scope="col">Description</th>
		<th scope="col">Value</th>
		<th scope="col">Required</th>
		<th scope="col">Example</th>
	</thead>
	<tbody>
		<tr>
			<td>success</td>
			<td>Indicates if the request succeeded or not</td>
			<td>Boolean</td>
			<td>Yes</td>
			<td><i>true</i></td>
		</tr>
		<tr>
			<td>error</td>
			<td>Hash containing a computer-readable code and human-readable message</td>
			<td>Hash</td>
			<td>No</td>
			<td><i>{code: 1001, message: "Private API key not found"}</i></td>
		</tr>
		<tr>
			<td>addresses</td>
			<td>Array of address results.</td>
			<td>Array</td>
			<td>No</td>
			<td><i>[{address_elements},..]</i></td>
		</tr>
	</tbody>
</table>

#### Examples

An example of an XML request:

**Request**

    https://address.nzpost.co.nz/api/find.xml?address_line_1=7+waterloo+quay&address_line_2=wellington&callback=cb123&max=10&private_api_key=YOUR_PRIVATE_API_KEY&type=All


**Response**

	<hash>
    	<success type="boolean">true</success>
    	<addresses type="array">
      		<address>
		        <DPID type="integer">3111226</DPID>
		        <FullAddress>7 Waterloo Quay, Pipitea, Wellington 6011</FullAddress>
		        <SourceDesc>Postal\Physical - Not Delivered</SourceDesc>
		        <MatchScore type="integer">95</MatchScore>
		        <MatchedUnit>Y</MatchedUnit>
		        <MatchedFloor>Y</MatchedFloor>
		        <MatchedNumber>Y</MatchedNumber>
		        <MatchedStreetAlpha>Y</MatchedStreetAlpha>
		        <MatchedRoadName>Y</MatchedRoadName>
		        <MatchedRoadTypeName>Y</MatchedRoadTypeName>
		        <MatchedRoadSuffixName>Y</MatchedRoadSuffixName>
		        <MatchedSuburb>N</MatchedSuburb>
		        <MatchedRuralDelivery>N</MatchedRuralDelivery>
		        <MatchedLobby>N</MatchedLobby>
		        <MatchedCity>Y</MatchedCity>
		        <MatchedBoxBagType>N</MatchedBoxBagType>
		        <Deliverable>N</Deliverable>
		        <Physical>Y</Physical>
      		</address>
    	</addresses>
  	</hash></asp:Content>

