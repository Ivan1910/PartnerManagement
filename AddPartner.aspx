<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddPartner.aspx.cs" Inherits="Partner_Management.AddPartner" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Add partner</title>
    <link rel="stylesheet" href="Styles/bootstrap.css" type="text/css">
    <script src="Scripts/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="formWrap" style="margin: 10px auto; padding: 10px; max-width: 400px; background-color: rgb(128, 128, 128,5%); padding: 10px; border-radius: 15px;">
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbFirstName" Style="margin: 10px;">First name:</asp:Label>
                    <asp:TextBox ID="tbFirstName" MaxLength="64" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidFirstName" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbLastName" Style="margin: 10px;">Last name:</asp:Label>
                    <asp:TextBox ID="tbLastName" MaxLength="64" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidLastName" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbAddress" Style="margin: 10px;">Address:</asp:Label>
                    <asp:TextBox ID="tbAddress" MaxLength="128" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidAddress" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbPartnerNumber" Style="margin: 10px;">Partner number:</asp:Label>
                    <asp:TextBox ID="tbPartnerNumber" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidPartnerNumber" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="cbIsForeign" Style="margin: 10px;">Foreigner:</asp:Label>
                    <asp:CheckBox runat="server" OnCheckedChanged="cbIsForeign_CheckedChanged" AutoPostBack="true" ID="cbIsForeign" />
                </div>
            </div>
            <div runat="server" id="divForeigner" class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbCroatianPIN" Style="margin: 10px;">Croatian PIN:</asp:Label>
                    <asp:TextBox ID="tbCroatianPIN" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidCroatianPIN" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="ddlPartnerType" Style="margin: 10px;">Partner type:</asp:Label>
                    <asp:DropDownList runat="server" ID="ddlPartnerType"></asp:DropDownList>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="ddlGender" Style="margin: 10px;">Gender:</asp:Label>
                    <asp:DropDownList runat="server" ID="ddlGender">
                        <asp:ListItem Selected="True" Text="Not specified" Value="N"></asp:ListItem>
                        <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbExternalCode" Style="margin: 10px;">External code:</asp:Label>
                    <asp:TextBox ID="tbExternalCode" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidExternalCode" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Label runat="server" AssociatedControlID="tbCreatedByUser" Style="margin: 10px;">User (email):</asp:Label>
                    <asp:TextBox ID="tbCreatedByUser" MaxLength="124" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-12">
                    <asp:Label Visible="false" Style="font-size: 13px; color: red;" ID="lblValidCreatedByUser" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row" style="justify-content: center; margin: 10px;">
                <div class="col-12">
                    <asp:Button CssClass="btn btn-primary" runat="server" ID="btnAddPartner" Text="Add partner" OnClick="btnAddPartner_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
