<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Partner_Management.Default" %>

<!DOCTYPE html>

<html>

<head>
    <title>Partners</title>
    <link rel="stylesheet" href="Styles/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="Styles/default.css" type="text/css">
    <script src="Scripts/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>
    <script src="Scripts/default.js"></script>


</head>

<body>
    <form runat="server">

        <div class="modal" id="policiesViewModal">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Policies</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="" style="overflow: auto;">
                            <asp:Repeater ID="rptPoliciesView" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-hover">
                                        <thead>
                                            <tr class="text-center">
                                                <th scope="col">Policy Number</th>
                                                <th scope="col">Policy Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr class="text-center" key="1">
                                        <td><%# ((Policy)Container.DataItem).PolicyNumber%></td>
                                        <td><%# ((Policy)Container.DataItem).PolicyAmount%></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
</table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal" id="addNewPolicy">
            <div class="modal-dialog modal-dialog-centered ">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <asp:Label ID="lblTitle_AddNewPolicyModal" runat="server" Text="Add new policy"></asp:Label></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div runat="server" id="divPolicyNumber" class="form-group row">
                            <asp:Label ID="lblPolicyNumber" runat="server" for="tbPolicyNumber" class="col-sm-6 col-form-label">Policy Number</asp:Label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbPolicyNumber" Style="width: 200px" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:Label Style="font-size: 13px; color: red;" ID="valid_tbPolicyNumber" runat="server" Visible="false" Text="Only numbers allowed, min. 10 numbers, max. 15 numbers!"></asp:Label>
                            </div>
                        </div>
                        <asp:Label Style="font-size: 16px; display: block; text-align: center; color: green;" CssClass="col-12" ID="lblSuccess" runat="server" Text="New policy added successfully!" Visible="false"></asp:Label>
                        <div runat="server" id="divPolicyAmount" class="form-group row">
                            <asp:Label ID="lblPolicyAmount" runat="server" for="tbPolicyAmount" class="col-sm-6 col-form-label">Policy Amount</asp:Label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbPolicyAmount" Style="width: 200px" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:Label Style="font-size: 13px; color: red;" ID="valid_tbPolicyAmount" runat="server" Text="Only numbers allowed, with or without decimal places and greater or equal 0!" Visible="false"></asp:Label>
                            </div>
                        </div>

                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <asp:Button runat="server" UseSubmitBehavior="false" ID="savePolicy" OnClick="savePolicy_Click" class="btn btn-primary" Text="Save" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal" id="partnerDetailsModal">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Partner details</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive" style="height: fit-content; overflow: auto;">
                            <asp:Repeater ID="rptPartnersDetails" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-hover">
                                        <thead>
                                            <tr style="font-size: 13px;" class="text-center">
                                                <th scope="col">Full Name</th>
                                                <th scope="col">Partner Number</th>
                                                <th scope="col">Croatian PIN</th>
                                                <th scope="col">Partner Type</th>
                                                <th scope="col">Created UTC</th>
                                                <th scope="col">Foreign </th>
                                                <th scope="col">Gender </th>
                                                <th scope="col">Address</th>
                                                <th scope="col">Created by</th>
                                                <th scope="col">External Code</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr style="font-size: 13px;" class="text-center" key="<%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Partner_ID %>">
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.FirstName + ' ' + ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.LastName  %></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.PartnerNumber%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.CroatianPIN%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).PartnerType.TypeName%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.CreatedAtUtc%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.IsForeign%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Gender%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Address%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.CreatedByUser%></td>
                                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.ExternalCode%></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
 </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="btn-toolbar">
            <asp:LinkButton Style="margin: 10px;" ID="AddNewPartner" OnClick="AddNewPartner_Click" ToolTip="Add new partner" runat="server" CssClass="btn btn-small btn-primary actions"><img src="Icons/person-add.svg" /></asp:LinkButton>
        </div>
        <div class="table-responsive" style="overflow: auto;">
            <asp:Repeater ID="rptPartners" runat="server">
                <HeaderTemplate>
                    <table id="PartnersTable" class="table table-hover">
                        <thead>
                            <tr class="text-center">
                                <th scope="col">Full Name</th>
                                <th scope="col">Partner Number</th>
                                <th scope="col">Croatian PIN</th>
                                <th scope="col">Partner Type</th>
                                <th scope="col">Created UTC</th>
                                <th scope="col">Foreign </th>
                                <th scope="col">Gender </th>
                                <th scope="col">Policies Actions </th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class="text-center partnersRow" key="<%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Partner_ID %>">
                        <td class="FullName"><%# (((Wrapper_Partner_PartnerType)Container.DataItem).IsMarked ? "* " : "") + ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.FirstName + ' ' + ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.LastName  %></td>
                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.PartnerNumber%></td>
                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.CroatianPIN%></td>
                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).PartnerType.TypeName%></td>
                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.CreatedAtUtc%></td>
                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.IsForeign%></td>
                        <td><%# ((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Gender%></td>
                        <td>
                            <asp:LinkButton OnClick="ViewPolicies_Click" CausesValidation="false" CommandArgument='<%#((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Partner_ID%>' OnClientClick="event.stopPropagation()" ID="ViewPolicies" ToolTip="View policies" runat="server" CssClass="btn btn-small btn-primary actions"><img src="Icons/card-list.svg" /></asp:LinkButton>
                            <asp:LinkButton OnClick="AddNewPolicy_Click" CausesValidation="false" CommandArgument='<%#((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Partner_ID%>' OnClientClick="event.stopPropagation()" ID="AddNewPolicy" ToolTip="Add new policy" runat="server" CssClass="btn btn-small btn-primary actions"><img src="Icons/plus.svg" /></asp:LinkButton>

                        </td>

                        <td style="display: none;">
                            <asp:Button ID="btnPartnersDetails" CausesValidation="false" OnClick="btnPartnersDetails_Click" CommandArgument='<%#((Wrapper_Partner_PartnerType)Container.DataItem).Partner.Partner_ID%>' Style="margin: 10px auto;" CssClass="details" runat="server" Text="View" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
    </table>
                </FooterTemplate>
            </asp:Repeater>

        </div>

    </form>
</body>
</html>
