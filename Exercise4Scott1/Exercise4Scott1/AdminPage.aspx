<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="Exercise4Scott1.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
AdminPage</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:Label ID="lblError" runat="server" Font-Size="Large" ForeColor="Red"></asp:Label>
<br/><br/>
        <asp:Panel ID="pnlLog" runat="server" Height="549px" Width="988px">
        <asp:Panel ID="pnlLogFields" runat="server" Height="235px" Width="846px"><table style="width: 408px">   
          
        <tr>
            <td><asp:Label ID="lblLoginID" runat="server" Text="LoginID: "></asp:Label></td>
            <td style="width: 273px"> <asp:TextBox ID="txtloginID" runat="server" CssClass="TxtBox" ReadOnly="True"></asp:TextBox></td> 
        </tr>
        <tr>
            <td><asp:Label ID="lblUserName" runat="server" Text="User Name: "></asp:Label></td>
            <td style="width: 273px"><asp:TextBox ID="txtuserName" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblLogSuccess" runat="server" Text="Login Successful: "></asp:Label> </td>
            <td style="width: 273px"><asp:TextBox ID="txtloginSuccess" runat="server" CssClass="TxtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblLogDate" runat="server" Text="Login Date: "></asp:Label> </td>
            <td style="width: 273px"><asp:TextBox ID="txtlogDate" runat="server" CssClass="TxtBox"></asp:TextBox></td>
         </tr>
        
     
       </table>
 </asp:Panel>

      <asp:Panel ID="pnlEditDelete" runat="server">
          <table>
                <tr>
                    <td><asp:Button ID="btnDelete" runat="server" Text="Delete Log" onclick="btnDelete_Click" CausesValidation="False" /></td>
                 </tr>
         </table>
     </asp:Panel>

<asp:GridView ID="LoginGridView" runat="server" DataKeyNames="LoginID" 
         onrowcommand="LoginGridView_RowCommand" CssClass="Grids" CellPadding="4" 
            ForeColor="#333333" GridLines="Horizontal" Width="913px" Height="134px" 
                 HorizontalAlign="Left" AllowPaging="True" 
                 onpageindexchanging="LoginGridView_PageIndexChanging" 
                AutoGenerateColumns="False" PageSize="5">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:ButtonField ButtonType="Button" CommandName="Select Log" 
                Text="Select" />
            
            <asp:BoundField DataField="LoginID" HeaderText="LoginID" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" />
            <asp:BoundField DataField="LoginSuccessful" HeaderText="Login Successful" />
            <asp:BoundField DataField="LogDate" HeaderText="Log Date" />
            
                        
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" Wrap="False" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView> </asp:Panel>
  <br />
        <br />
</asp:Content>
