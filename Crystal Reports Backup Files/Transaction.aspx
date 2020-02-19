<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="UBC.People.Transaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="hf_person_transaction_id" name="hf_person_transaction_id" value="<%: hf_person_transaction_id %>" />
    <table>
        <tbody>
            <tr>
                <td>ID</td>
                <td><%: hf_person_transaction_id %></td>
            </tr>
            <tr>
                <td>Person</td>
                <td>
                    <select id="dd_person_id" name="dd_person_id">
                        <option></option>
                        <option value="20">Aaliyah Grant</option>
                        <option value="86">Aazaria Taripo</option>
                        <option value="114">Abby Hawkes</option>
                        <option value="101">Adam Howie</option>
                        <option value="33">Aibel Antony</option>
                        <option value="44">Akkharawin Morin</option>
                        <option value="143">Alison Collier</option>
                        <option value="61">Ally Keenan</option>
                        <option value="22">Amelia  Lagidela</option>
                        <option value="102">Anika Robinson</option>
                        <option value="24">Antonia Lockton</option>
                        <option value="115">Aromea Te Maipi</option>
                        <option value="96">Bella Duncan</option>
                        <option value="105">Ben Young</option>
                        <option value="59">Bob Evans</option>
                        <option value="16">Brendan Edwardson</option>
                        <option value="77">Brennan Knopf</option>
                        <option value="64">Brittney Robertson</option>
                        <option value="53">Cameron Dainault</option>
                        <option value="122">Catherine Dainault (Cath)</option>
                        <option value="14">Chalice Whittaker</option>
                        <option value="21">Charlee Kendrick</option>
                        <option value="112">Chris Keenan</option>
                        <option value="139">Claire Lilley</option>
                        <option value="126">Coralene Christiansen</option>
                        <option value="23">Cordelia Lockton</option>
                        <option value="134">Craig Patchett</option>
                        <option value="120">Curt Weir</option>
                        <option value="89">Dakota Barry</option>
                        <option value="123">Darryl Dainault</option>
                        <option value="52">Donny Thompson</option>
                        <option value="87">Emma Hartell</option>
                        <option value="137">Fiapaipai Casserley</option>
                        <option value="11">Flurina Doenz</option>
                        <option value="129">Gene Peni</option>
                        <option value="69">Graceyn Buchanan</option>
                        <option value="95">Grant Ryder</option>
                        <option value="1">Greg Tichbon</option>
                        <option value="48">Hamish Dodds-McIntosh</option>
                        <option value="28">Hamish Jenkins</option>
                        <option value="103">Hunter Moulder</option>
                        <option value="104">Ian Brider (Butch)</option>
                        <option value="136">Ioana Casserley</option>
                        <option value="31">Isabela Carrano (Bela)</option>
                        <option value="39">Jacob Wylie</option>
                        <option value="109">Jaedyn Thompson</option>
                        <option value="34">Jaiden Farmer</option>
                        <option value="10">Jaiden Mills-Nossiter</option>
                        <option value="32">Jared Pellow</option>
                        <option value="37">Jaxon  Taylor</option>
                        <option value="63">Jayde Hawke</option>
                        <option value="100">Jemal Weston</option>
                        <option value="92">Jennie Evans</option>
                        <option value="47">Jennifer Evans (Jen)</option>
                        <option value="128">Jim Stormont</option>
                        <option value="113">Jo Moulder</option>
                        <option value="132">Joanne Dixon (Jo)</option>
                        <option value="141">Joany Casey</option>
                        <option value="85">John Carter</option>
                        <option value="97">Jordyn Mohr</option>
                        <option value="27">Jorja Whiteman</option>
                        <option value="98">Josh Wood</option>
                        <option value="2">Judy Kumeroa</option>
                        <option value="119">Julie Weir</option>
                        <option value="43">Justice Robertson-Hiri</option>
                        <option value="125">Justin Lett</option>
                        <option value="71">Keri Browning</option>
                        <option value="124">Kristal Hartell</option>
                        <option value="51">Kurt Browning</option>
                        <option value="75">Kyla Joseph</option>
                        <option value="73">Kylee Thompson</option>
                        <option value="29">Kyra Meis</option>
                        <option value="72">Leah Johnston</option>
                        <option value="145">Leanne Kirk</option>
                        <option value="56">Leigha Stormont</option>
                        <option value="17">Lenox Fold</option>
                        <option value="130">Lerae Edwards</option>
                        <option value="138">Lia Connor</option>
                        <option value="58">Lis Nielsen</option>
                        <option value="133">Lisa Patchett</option>
                        <option value="140">Luzanne Priest</option>
                        <option value="74">Maeve Weir</option>
                        <option value="46">Maia Simpson</option>
                        <option value="118">Mal Rerekura</option>
                        <option value="117">Marie Aue</option>
                        <option value="142">Mark Robertson</option>
                        <option value="38">Marlene Ziegler</option>
                        <option value="84">Martin Bridger</option>
                        <option value="35">Matua Carston</option>
                        <option value="15">Merekara Whittaker</option>
                        <option value="68">Mike Connor</option>
                        <option value="67">Mike O'Sullivan</option>
                        <option value="62">Milly Keenan</option>
                        <option value="25">Mystique  Green-Symes</option>
                        <option value="45">Neo Tichbon</option>
                        <option value="40">Neve Duxfield</option>
                        <option value="18">Oskar Swanson</option>
                        <option value="94">Patrick Carroll (Pat)</option>
                        <option value="57">Peer Nielsen</option>
                        <option value="66">Peter Ninham</option>
                        <option value="93">Philippa Baker-Hogan</option>
                        <option value="111">Pip Keenan</option>
                        <option value="79">Piper Neil</option>
                        <option value="127">Raylene Stormont (Ray)</option>
                        <option value="30">Rhiannon Peni</option>
                        <option value="26">Ringatuhuia Walters</option>
                        <option value="9">Robbie Tyler</option>
                        <option value="110">Rod Trott</option>
                        <option value="107">Rodney Calder (Rod)</option>
                        <option value="116">Rory Grant</option>
                        <option value="144">Sarah Ninham</option>
                        <option value="121">Sarita Payne</option>
                        <option value="81">Savannah Priest</option>
                        <option value="135">Scott Wylie</option>
                        <option value="36">Sebastian ????</option>
                        <option value="42">Shontay Dixon</option>
                        <option value="55">Siena McLean</option>
                        <option value="7">Sofia Selmi</option>
                        <option value="76">Steph Weston</option>
                        <option value="82">Steve ?</option>
                        <option value="65">Tama Casserley</option>
                        <option value="83">Te Manawa Pinnock</option>
                        <option value="19">Tieren  Cameron</option>
                        <option value="41">Tina Pointon</option>
                        <option value="8">Toa Therrien</option>
                        <option value="99">Tom Sutherland</option>
                        <option value="60">Tomasi Connor</option>
                        <option value="131">Troy Dixon</option>
                        <option value="80">Xavier Mohr</option>
                        <option value="12">Yanisa Prosri</option>
                        <option value="13">Yuto Nagashima</option>
                        <option value="70">Zara Gapes</option>
                    </select></td>
            </tr>
            <tr>
                <td>Date</td>
                <td>
                    <input type="date" id="tb_date" name="tb_date" value="<%: tb_date %>" /></td>
            </tr>
            <tr>
                <td>Amount</td>
                <td>
                    <input type="number" id="tb_amount" name="tb_amount" value="<%: tb_amount %>" /></td>
            </tr>
            <tr>
                <td>Note</td>
                <td>
                    <textarea id="tb_note" name="tb_note"><%: tb_note %></textarea></td>
            </tr>
            <tr>
                <td>System</td>
                <td>
                    <select id="dd_system" name="dd_system">
                        <option></option>
                        <option value="Friends">Friends</option>
                        <option value="UBC">UBC</option>
                    </select></td>
            </tr>
            <tr>
                <td>Detail</td>
                <td>
                    <input type="text" id="tb_detail" name="tb_detail" value="<%: tb_detail %>" /></td>
            </tr>
            <tr>
                <td>Code</td>
                <td>
                    <select id="dd_code" name="dd_code">
                        <option></option>
                        <option value="Regatta">Regatta</option>
                        <option value="Regatta">Boat Transport</option>
                    </select></td>
            </tr>
            <tr>
                <td>Banked</td>
                <td>
                     <input type="date" id="tb_banked" name="tb_banked" value="<%: tb_banked %>" /></td>
            </tr>
            <tr>
                <td>Event</td>
                <td>
                    <select id="dd_event_id" name="dd_event_id">
                        <option></option>
                        <option value="150">Hawkes Bay Cup Regatta / Clive</option>
                        <option value="107">John Trophy Regatta, Waitara</option>
                        <option value="274">Maadi</option>
                        <option value="250">North Island Secondary School Championships</option>
                    </select></td>
            </tr>
        </tbody>
    </table>
    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />

</asp:Content>
