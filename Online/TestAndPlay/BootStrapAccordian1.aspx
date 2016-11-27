<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BootStrapAccordian1.aspx.cs" Inherits="Online.TestAndPlay.BootStrapAccordian1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Card 1 -->

    <!-- Accordian header start -->

    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapse_card1">Card 1 - Trading Operations</a>
                </h4>
            </div>
            <div id="collapse_card1" class="panel-collapse collapse">
                <div class="panel-body">

                    <!-- Accordian header end -->

                    <div class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse_card2">Card 1A - Trading Operations</a>
                                </h4>
                            </div>
                            <div id="collapse_card2" class="panel-collapse collapse">
                                <div class="panel-body">

                                    <!-- Accordian header end -->

                                    <div class="form-group">
                                        <label class="control-label col-sm-4" for="cb_1.1.1a">Caterer</label>
                                        <div class="col-sm-8">

                                            <input id="cb_1.1.1a" name="cb_1.1" type="checkbox" />

                                        </div>
                                    </div>
                                    <!-- Accordian footer start -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Accordian footer end -->


                    <!-- Accordian footer start -->
                </div>
        </div>
    </div>
    <!-- Accordian footer end -->





    <div class="accordion" id="accordion1">

        <div class="accordion-group">
            <div class="accordion-heading">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo">Collapsible Group #2 (With nested accordion inside)
                </a>
            </div>
            <div id="collapseTwo" class="accordion-body collapse">
                <div class="accordion-inner">

                    <!-- Here we insert another nested accordion -->

                    <div class="accordion" id="accordion2">
                        <div class="accordion-group">
                            <div class="accordion-heading">
                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseInnerOne">Collapsible Inner Group Item #1
                                </a>
                            </div>
                            <div id="collapseInnerOne" class="accordion-body collapse in">
                                <div class="accordion-inner">
                                    Anim pariatur cliche...
                                </div>
                            </div>
                        </div>
                        <div class="accordion-group">
                            <div class="accordion-heading">
                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseInnerTwo">Collapsible Inner Group Item #2
                                </a>
                            </div>
                            <div id="collapseInnerTwo" class="accordion-body collapse">
                                <div class="accordion-inner">
                                    Anim pariatur cliche...
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inner accordion ends here -->

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
