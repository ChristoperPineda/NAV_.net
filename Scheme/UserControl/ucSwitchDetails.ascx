﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSwitchDetails.ascx.cs" Inherits="NAV.Scheme.UserControl.ucSwitchDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>

<AjaxControlToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></AjaxControlToolkit:ToolkitScriptManager>
    
    <script type="text/javascript" src="https://www.google.com/jsapi?key=ABQIAAAAJIc7LVNGdtica6PhZe_sFRQqgDN7nsaPpAk-csjZoyzusnQgwBSfA71pi0A-I91r0MmWO8okG_Zq6Q"></script>
     
    <script type="text/javascript">
        google.load("jquery", "1.7.1"); // google.load("jqueryui", "1.8.1");        
    </script>
    
    <script src="../js/switchJS.js"></script>   

    <script type="text/javascript">

        $ = jQuery.noConflict();

        $(function() {
            $('#<%= txtPopupFund.ClientID %>').removeAttr('onchange').removeAttr('onkeypress');
            $('#<%= PopupFundSearch.ClientID %> a').attr('onclick', "getFlickerSolved('<%= PopupFundSearch.ClientID %>');");
        });    

        function hidePopup(oModalPopup) {
            var modalPopup = $find(oModalPopup);
            var hasDiscretionary = '<%=Session["HasDiscretionary"]%>'
            if ((hasDiscretionary == 1) || (hasDiscretionary == -1)) {
                $find('bhvrThirdSwitchPopup', null).show();
                modalPopup.hide();
            }
            else {
                $find('bhvrSecondSwitchPopup', null).show();
                modalPopup.hide();
            }
        }

        function validateTextbox() {
            if (document.getElementById('ctl00_ContentPlaceHolder1_txtSMSMobileNo').value == '') {
                alert('Please enter mobile number!');
                document.getElementById('ctl00_ContentPlaceHolder1_txtSMSMobileNo').focus()
                return false;
            }
        }
        function validateSwitchAllocation() {
            var CurrentAllocation = window.document.getElementById("ctl00_ContentPlaceHolder1_gvSwitchFooterHfTotalAllocation").value
            if (CurrentAllocation != 100.00) {
                alert("Unable to proceed. Total allocation must be set equal to 100. Your total allocation is:" + CurrentAllocation);
                $find('bhvrFirstSwitchPopup', null).hide();
                return false;
            }
            else {
                $find('bhvrFirstSwitchPopup', null).show();
            }
        }
        function confirmApprove() {
            var result = confirm("Do you want to approve this scheme?");
            if (result) {
                $find('bhvrThirdSwitchPopup', null).show();
            }
            else {
                $find('bhvrThirdSwitchPopup', null).hide();
            }
        }
    </script>
<table width="100%">
    <tr>
        <td>
            <asp:Button runat="server" ID="btnComplete" Text="Complete Switch" OnClientClick="return confirm('Proceed changing the status of this Switch to Complete?')" OnClick="btnComplete_Click" Visible="false"  />
        </td>
    </tr>
</table>
<table width="100%">
    <tr>
        <td  class="table1_header" align="left">           
            <b><asp:Label runat="server" ID="lblTitle_ProposePortfolio" Text="Proposed Portfolio"/></b>
        </td>
    </tr>
    <tr>
        <td align="left">
            <asp:Label runat="server" ID="lblSwitchStatusTitle" Text="Status: " />&nbsp;<asp:Label runat="server" ID="lblSwitchStatusValue" />
        </td>
    </tr>     
    <tr>
        <td>
            <div class="table2">
            <asp:GridView runat="server" ID="gvSchemeSwitch" AutoGenerateColumns="false" Width="100%" ShowFooter="true" BorderStyle="None" CellPadding="0" CellSpacing="0" UseAccessibleHeader="true" CssClass="table2">
                <Columns>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="t2_header" />
                        <ItemStyle HorizontalAlign="Center" BorderStyle="None"/>
                        <FooterStyle HorizontalAlign="Center"  CssClass="t2_results"/>
                        <ItemTemplate>
                            <asp:ImageButton runat="server" id="ibtnRemoveFund" ImageUrl="~/Images/remove_btn.png" OnClientClick="document.getElementById('ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfIsContribution').value = false; return confirm('Proceed removing this fund?')" OnCommand="lbtnRemoveFund_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "propFund.propFundID")%>' Visible='<%#Eval("propIsDeletable")%>' />
                        </ItemTemplate>
                        <FooterTemplate>                                                        
                            <img src="~/Images/add_btn.png" onclick='javascript:popUp_AddFunds(false);' onmouseover="javascript:this.style.cursor='pointer'" id="imgAddFund" runat="server"/>
                        </FooterTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" >
                        <HeaderStyle HorizontalAlign="Left"  VerticalAlign="Top" CssClass="t2_header"/>
                        <ItemStyle HorizontalAlign="Left"  BorderStyle="None"/>
                        <FooterStyle HorizontalAlign="Left" CssClass="t2_results"/>
                        <FooterTemplate>
                            <a id="lbtnAddFund" href='javascript:popUp_AddFunds(false);' runat="server">Add more funds</a>
                        </FooterTemplate>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderFundName" Text="Fund Name"  />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="added_fund"  style='<%# HideClickableFundLinks(Eval("propIsDeletable"))%>'>                                
                                <a runat="server" href='<%#String.Format("javascript:popUp_EditFunds({0}, false)",Eval("propFund.propFundID"))%>' id="lbtnFundName"><%# DataBinder.Eval(Container.DataItem, "propFund.propFundName") %></a>
                            </div>
                            <div style='<%# ShowClickableFundLinks(Eval("propIsDeletable"))%>'  >
                                <%# DataBinder.Eval(Container.DataItem, "propFund.propFundName")%>
                            </div>                                
                            <asp:HiddenField runat="server" ID="hfSwitchDetailsID" Value='<%# Eval("propSwitchDetailsID")%>' />
                            <asp:HiddenField runat="server" ID="hfSelectedFundID" Value='<%# DataBinder.Eval(Container.DataItem, "propFund.propFundID")%>' />
                            <asp:HiddenField runat="server" ID="hfCurrencyMultiplier" Value='<%# Eval("propCurrencyMultiplier")%>' />                                                        
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price">
                        <HeaderStyle HorizontalAlign="Right"  VerticalAlign="Top" CssClass="t2_header"/>
                        <ItemStyle HorizontalAlign="Right"  BorderStyle="None"/>
                        <FooterStyle CssClass="t2_results"/>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblFundCurrencySwitch" Text='<%# DataBinder.Eval(Container.DataItem, "propFund.propCurrency")%>'/>&nbsp;&nbsp;<asp:Label ID='lblPrice' runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "propFund.propPrice", "{0:n4}")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:TemplateField>
                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" CssClass="t2_header" />
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderUnits" Text="Unit" />
                        </HeaderTemplate>                    
                        <ItemStyle HorizontalAlign="Right" BorderStyle="None" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="gvSwitchDetailsLblUnits" Text='<% #Eval("propUnits", "{0:n4}") %>'/>     
                            <asp:HiddenField runat="server" ID="gvhfSwitchDetailsLblUnits" Value='<% #Eval("propUnits", "{0:n4}") %>' />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results"/>
                    </asp:TemplateField>                    
                    <asp:TemplateField>
                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" CssClass="t2_header" />
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderValue" Text="Value" />
                        </HeaderTemplate>                    
                        <ItemStyle HorizontalAlign="Right" BorderStyle="None" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="gvSwitchDetailsLblValue" Text='<% #Eval("propValue", "{0:n0}") %>'/>
                            <asp:HiddenField runat="server" ID="gvhfSwitchHeaderValue" Value='<% #Eval("propValue", "{0:n0}") %>' />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results"/>
                        <FooterTemplate>
                            Total:&nbsp;<asp:Label runat="server" ID="gvSwitchFooterLblTotalValue" />
                        </FooterTemplate>
                    </asp:TemplateField>                                        
                    <asp:TemplateField HeaderText="Allocation %">
                        <HeaderStyle HorizontalAlign="Right"  VerticalAlign="Top" CssClass="t2_header"/>
                        <ItemStyle HorizontalAlign="Right"  BorderStyle="None"/>
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results"/>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderValue" Text='<% #Eval("propAllocation", "{0:0.00}") %>' />                            
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label runat="server" ID="gvSwitchFooterLblTotalAllocationOrig" />
                        </FooterTemplate>                        
                    </asp:TemplateField>                                                            
                    <asp:TemplateField HeaderText="Target Allocation %">
                        <HeaderStyle HorizontalAlign="Left"  VerticalAlign="Top" CssClass="t2_header" />
                        <ItemStyle HorizontalAlign="Right"  BorderStyle="None" />
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results" />
                        <ItemTemplate>
                            <asp:RequiredFieldValidator runat="server" ID="gvSwitchRfvTargetAllocation" ControlToValidate="gvSwitchTxtTargetAllocation" SetFocusOnError="true" Display="None" ValidationGroup="vgSwitchDetails" ></asp:RequiredFieldValidator>                            
                            <asp:CompareValidator runat="server" ID="gvSwitchCvTargetAllocation" ControlToValidate="gvSwitchTxtTargetAllocation" SetFocusOnError="true" Operator="DataTypeCheck" Type="Double"  Display="None" ValidationGroup="vgSwitchDetails"></asp:CompareValidator>
                            <asp:HiddenField runat="server" ID="hfCurrentValueClient"/>                                                        
                            <asp:RegularExpressionValidator ID="regexpName" runat="server" Display="Dynamic"
                                    ErrorMessage="(0.00 - 100.00)" 
                                    ControlToValidate="gvSwitchTxtTargetAllocation"      
                                    ValidationExpression="^\d*(|[.]\d{0,1}[0-9])?$" 
                                    Font-Size="X-Small"
                                    ValidationGroup="vgSwitchDetails"/>
                            <asp:RangeValidator runat="server" ID="gvSwitchRvTargetAllocation" ControlToValidate="gvSwitchTxtTargetAllocation" SetFocusOnError="true" MaximumValue="100" MinimumValue="0"  Type="Double" Display="Dynamic" ValidationGroup="vgSwitchDetails" ErrorMessage="(0.00 - 100.00)" Font-Size="X-Small"></asp:RangeValidator>
                            <asp:TextBox runat="server" ID="gvSwitchTxtTargetAllocation" Width="70" Text='<% #Eval("propAllocation", "{0:0.00}") %>'  MaxLength="6" CausesValidation="true" AutoPostBack="false" ValidationGroup="vgSwitchDetails" onblur='javascript:computeRows(this, false);' OnKeyUp='javascript:computeRows(this, false);' onkeypress="javascript:return onlyNumbers(this,event);"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label runat="server" ID="gvSwitchFooterLblTotalAllocation" />
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
        </td>
    </tr>    
    <tr>
        <td>
            <asp:HiddenField runat="server" ID="gvSwitchFooterHfTotalAllocation"/>
            <asp:HiddenField runat="server" ID="hfFundIDOrig"/>
            <asp:HiddenField runat="server" ID="hfFundIDNew"/>
            <asp:HiddenField runat="server" ID="hfCurrentValueClientTotal"/>
            <asp:HiddenField runat="server" ID="hfFundCount"/>
            <asp:HiddenField runat="server" ID="hfPopUpFundAction"/>
            <asp:ValidationSummary runat="server" ID="vsSwitchDetails" ShowSummary="false"  ShowMessageBox="true" ValidationGroup="vgSwitchDetails" EnableClientScript="true" HeaderText="Please input numeric values from 0.00 to 100.00" />
            <asp:Label ID="fixAjaxValidationSummaryErrorLabel" Text="" runat="server" OnPreRender="FixAjaxValidationSummaryErrorLabel_PreRender" />
        </td>
    </tr>
</table>&nbsp;






















<table width="100%">
    <tr>
        <td  class="table1_header" align="left">           
            <b><asp:Label runat="server" ID="lblTitle_ContributionAllocation" Text="Contribution Allocation"/></b>
        </td>
    </tr>
    <tr>
        <td align="left">
            <asp:Button runat="server" ID="btnMirrorFundAllocation" Text="Mirror Fund Allocation" OnClick="btnMirrorFundAllocation_Click" />
        </td>
    </tr>
    <tr>
        <td>
            <div class="table2">
            <asp:GridView runat="server" ID="gvContributionSwitch" AutoGenerateColumns="false" Width="100%" ShowFooter="true" BorderStyle="None" CellPadding="0" CellSpacing="0" UseAccessibleHeader="true" CssClass="table2">
                <Columns>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="t2_header" />
                        <ItemStyle HorizontalAlign="Center" BorderStyle="None"/>
                        <FooterStyle HorizontalAlign="Center"  CssClass="t2_results"/>
                        <ItemTemplate>
                            <asp:ImageButton runat="server" id="ibtnRemoveFund" ImageUrl="~/Images/remove_btn.png" OnClientClick="document.getElementById('ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfIsContribution').value = true; return confirm('Proceed removing this fund?')" OnCommand="lbtnRemoveFund_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "propFund.propFundID")%>' Visible='<%#Eval("propIsDeletable")%>' />
                        </ItemTemplate>
                        <FooterTemplate>                                                        
                            <img src="~/Images/add_btn.png" onclick='javascript:popUp_AddFunds(true);' onmouseover="javascript:this.style.cursor='pointer'" id="imgAddFund" runat="server"/>
                        </FooterTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" >
                        <HeaderStyle HorizontalAlign="Left"  VerticalAlign="Top" CssClass="t2_header"/>
                        <ItemStyle HorizontalAlign="Left"  BorderStyle="None"/>
                        <FooterStyle HorizontalAlign="Left" CssClass="t2_results"/>
                        <FooterTemplate>
                            <a id="lbtnAddFund" href='javascript:popUp_AddFunds(true);' runat="server">Add more funds</a>
                        </FooterTemplate>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderFundName" Text="Fund Name"  />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="added_fund"  style='<%# HideClickableFundLinks(Eval("propIsDeletable"))%>'>
                                <a runat="server" href='<%#String.Format("javascript:popUp_EditFunds({0}, true)",Eval("propFund.propFundID"))%>' id="lbtnFundName"><%# DataBinder.Eval(Container.DataItem, "propFund.propFundName") %></a>
                            </div>
                            <div style='<%# ShowClickableFundLinks(Eval("propIsDeletable"))%>'  >
                                <%# DataBinder.Eval(Container.DataItem, "propFund.propFundName")%>
                            </div>                                
                            <asp:HiddenField runat="server" ID="hfSwitchDetailsID" Value='<%# Eval("propSwitchDetailsID")%>' />
                            <asp:HiddenField runat="server" ID="hfSelectedFundID" Value='<%# DataBinder.Eval(Container.DataItem, "propFund.propFundID")%>' />
                            <asp:HiddenField runat="server" ID="hfCurrencyMultiplier" Value='<%# Eval("propCurrencyMultiplier")%>' />                                                        
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price">
                        <HeaderStyle HorizontalAlign="Right"  VerticalAlign="Top" CssClass="t2_header"/>
                        <ItemStyle HorizontalAlign="Right"  BorderStyle="None"/>
                        <FooterStyle CssClass="t2_results"/>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblFundCurrencySwitch" Text='<%# DataBinder.Eval(Container.DataItem, "propFund.propCurrency")%>'/>&nbsp;&nbsp;<asp:Label ID='lblPrice' runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "propFund.propPrice", "{0:n4}")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:TemplateField>
                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" CssClass="t2_header" />
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderUnits" Text="Unit" />
                        </HeaderTemplate>                    
                        <ItemStyle HorizontalAlign="Right" BorderStyle="None" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="gvSwitchDetailsLblUnits" Text='<% #Eval("propUnits", "{0:n4}") %>'/>     
                            <asp:HiddenField runat="server" ID="gvhfSwitchDetailsLblUnits" Value='<% #Eval("propUnits", "{0:n4}") %>' />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results"/>
                    </asp:TemplateField>                    
                    <asp:TemplateField>
                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" CssClass="t2_header" />
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderValue" Text="Value" />
                        </HeaderTemplate>                    
                        <ItemStyle HorizontalAlign="Right" BorderStyle="None" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="gvSwitchDetailsLblValue" Text='<% #Eval("propValue", "{0:n0}") %>'/>
                            <asp:HiddenField runat="server" ID="gvhfSwitchHeaderValue" Value='<% #Eval("propValue", "{0:n0}") %>' />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results"/>
                        <FooterTemplate>
                            Total:&nbsp;<asp:Label runat="server" ID="gvSwitchFooterLblTotalValue" />
                        </FooterTemplate>
                    </asp:TemplateField>                                        
                    <asp:TemplateField HeaderText="Allocation %">
                        <HeaderStyle HorizontalAlign="Right"  VerticalAlign="Top" CssClass="t2_header"/>
                        <ItemStyle HorizontalAlign="Right"  BorderStyle="None"/>
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results"/>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="gvSwitchHeaderValue" Text='<% #Eval("propAllocation", "{0:0.00}") %>' />                            
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label runat="server" ID="gvSwitchFooterLblTotalAllocationOrig" />
                        </FooterTemplate>                        
                    </asp:TemplateField>                                                            
                    <asp:TemplateField HeaderText="Target Allocation %">
                        <HeaderStyle HorizontalAlign="Left"  VerticalAlign="Top" CssClass="t2_header" />
                        <ItemStyle HorizontalAlign="Right"  BorderStyle="None" />
                        <FooterStyle HorizontalAlign="Right" CssClass="t2_results" />
                        <ItemTemplate>
                            <asp:RequiredFieldValidator runat="server" ID="gvSwitchRfvTargetAllocation" ControlToValidate="gvSwitchTxtTargetAllocation" SetFocusOnError="true" Display="None" ValidationGroup="vgSwitchDetails" ></asp:RequiredFieldValidator>                            
                            <asp:CompareValidator runat="server" ID="gvSwitchCvTargetAllocation" ControlToValidate="gvSwitchTxtTargetAllocation" SetFocusOnError="true" Operator="DataTypeCheck" Type="Double"  Display="None" ValidationGroup="vgSwitchDetails"></asp:CompareValidator>
                            <asp:HiddenField runat="server" ID="hfCurrentValueClient"/>                                                        
                            <asp:RegularExpressionValidator ID="regexpName" runat="server" Display="Dynamic"
                                    ErrorMessage="(0.00 - 100.00)" 
                                    ControlToValidate="gvSwitchTxtTargetAllocation"      
                                    ValidationExpression="^\d*(|[.]\d{0,1}[0-9])?$" 
                                    Font-Size="X-Small"
                                    ValidationGroup="vgSwitchDetails"/>
                            <asp:RangeValidator runat="server" ID="gvSwitchRvTargetAllocation" ControlToValidate="gvSwitchTxtTargetAllocation" SetFocusOnError="true" MaximumValue="100" MinimumValue="0"  Type="Double" Display="Dynamic" ValidationGroup="vgSwitchDetails" ErrorMessage="(0.00 - 100.00)" Font-Size="X-Small"></asp:RangeValidator>
                            <asp:TextBox runat="server" ID="gvSwitchTxtTargetAllocation" Width="70" Text='<% #Eval("propAllocation", "{0:0.00}") %>'  MaxLength="6" CausesValidation="true" AutoPostBack="false" ValidationGroup="vgSwitchDetails" onblur='javascript:computeRows(this, true);' OnKeyUp='javascript:computeRows(this, true);' onkeypress="javascript:return onlyNumbers(this,event);"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label runat="server" ID="gvSwitchFooterLblTotalAllocation" />
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
        </td>
    </tr>    
    <tr>
        <td>
            <asp:HiddenField runat="server" ID="gvSwitchFooterHfTotalAllocation_Contribution"/>
            <asp:HiddenField runat="server" ID="hfFundIDOrig_Contribution"/>
            <asp:HiddenField runat="server" ID="hfFundIDNew_Contribution"/>
            <asp:HiddenField runat="server" ID="hfCurrentValueClientTotal_Contribution"/>
            <asp:HiddenField runat="server" ID="hfFundCount_Contribution"/>
            <%--<asp:HiddenField runat="server" ID="hfPopUpFundAction_Contribution"/>                        --%>
        </td>
    </tr>
</table>&nbsp;
<br />&nbsp;































<div runat="server" id="divSwitch">
    <center>
        <button id="btnSave" onclick="javascript:SwitchSave();" type="button" causesvalidation="true" runat="server">Save</button>&nbsp;        
        <input type="button" id="btnSwitch" runat="server" onclick="return validateSwitchAllocation();" value="Switch"/>
        <asp:Button runat="server" ID="btnCancel"  Text="Cancel" UseSubmitBehavior="false" CausesValidation="false" OnClientClick='if (!confirm("Cancel this switch?")) { return; }' OnClick="btnCancel_Click" />        
    </center>
</div>
<div runat="server" id="divAmend" visible="false">
    <center>
        <asp:Button runat="server" ID="btnApprove" Text="Approve" OnClientClick="return confirm('Do you want to approve this Scheme?');" onclick="btnApprove_Click" />
        <asp:Button runat="server" ID="btnReject" Text="Reject" OnClick="btnReject_Click" />
    </center>
</div>
<div runat="server" id="divRequestforDiscussion" visible="false">
    <center>
        <asp:Button runat="server" ID="btnAmend" Text="Amend" OnClick="btnAmend_Click" />
        <asp:Button runat="server" ID="btnResubmit" Text="Resubmit" OnClick="btnResubmit_Click" />        
        <asp:Button runat="server" ID="btnCancel2" Text="Cancel" UseSubmitBehavior="false" CausesValidation="false" OnClientClick='if (!confirm("Cancel this switch?")) { return; }' OnClick="btnCancel_Click" />        
    </center>
</div>

<AjaxControlToolkit:ModalPopupExtender ID="mpeFundSearch" runat="server" TargetControlID="Button2" PopupControlID="PopupFundSearch" BackgroundCssClass="modalBackground" DropShadow="true" BehaviorID="bhvrPopupFundSearch" />
<asp:Panel runat="server" ID="PopupFundSearch" CssClass="modalBox" ScrollBars="Both" style="display:none;overflow:auto;" Height="700px" Width="800px" DefaultButton="btnPopupFund" >    
    <div style="text-align:left;width:100%;margin-top:1px;">               
           <asp:HiddenField runat="server" ID="hfIsContribution"/>
        <table width="100%">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>                                    
            <tr>
                <td>
                    <asp:ValidationSummary runat="server" ID="vsFundSearch" ShowSummary="false"  ShowMessageBox="true" ValidationGroup="vgFundSearch" EnableClientScript="true"/>
                    <asp:RequiredFieldValidator runat="server" ID="RfvFundSearch" ControlToValidate="txtPopupFund" SetFocusOnError="true" Display="None" ValidationGroup="vgFundSearch" ErrorMessage="Please input a search criteria" ></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtPopupFund" AutoPostBack="true" OnTextChanged="txtPopupFund_TextChanged" CausesValidation="true" ValidationGroup="vgFundSearch"/>&nbsp;<asp:Button runat="server" ID="btnPopupFund" Text="Search" UseSubmitBehavior="false" OnClick="btnPopupFund_Click" CausesValidation="true" ValidationGroup="vgFundSearch"/>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <div id="Div1">
                    <asp:GridView runat="server" ID="gvFunds" AutoGenerateColumns="false" Width="100%" BorderStyle="Solid" BorderWidth="1">
                        <Columns>
                            <asp:BoundField DataField="propFundID" Visible="false" />
                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" >
                                <HeaderStyle CssClass="t1_column_color1" BorderStyle="None" VerticalAlign="Middle" HorizontalAlign="Center"/>
                                <ItemStyle HorizontalAlign="Left" BorderStyle="None" CssClass="t1_column_color1" />                        
                                <FooterStyle BorderStyle="None" CssClass="t1_column_color1"/>
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="gvHeaderFundName" Text="Fund Name"  />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lbtnFundName" Text='<%# Eval("propFundName")%>' ForeColor="Black" OnCommand="gvFunds_lbtnFundName_Click" CommandArgument='<%# Eval("propFundID")%>' ></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="propDatePriceUpdated" HeaderText="Date Price Update" DataFormatString="{0:dd/MM/yyyy}"                                    
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BorderStyle="None" HeaderStyle-VerticalAlign="Middle" HeaderStyle-CssClass="t1_column_color2"
                                    ItemStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="None" ItemStyle-CssClass="t1_column_color2"
                                    FooterStyle-BorderStyle="None" FooterStyle-CssClass="t1_column_color2"                                    />                            
                            <asp:BoundField DataField="propCurrency" HeaderText="Currency" 
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BorderStyle="None" HeaderStyle-VerticalAlign="Middle" HeaderStyle-CssClass="t1_column_color1"
                                    ItemStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="None" ItemStyle-CssClass="t1_column_color1"
                                    FooterStyle-BorderStyle="None" FooterStyle-CssClass="t1_column_color1" />
                            <asp:BoundField DataField="propPrice" HeaderText="Price" DataFormatString="{0:n2}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BorderStyle="None" HeaderStyle-VerticalAlign="Middle" HeaderStyle-CssClass="t1_column_color2"
                                    ItemStyle-HorizontalAlign="Right" ItemStyle-BorderStyle="None" ItemStyle-CssClass="t1_column_color2"
                                    FooterStyle-BorderStyle="None" FooterStyle-CssClass="t1_column_color2"/>
                        </Columns>
                        <EmptyDataTemplate>
                            No data found.
                        </EmptyDataTemplate>
                        <EmptyDataRowStyle BorderStyle="None" Font-Bold="true" />
                        <AlternatingRowStyle BackColor="#d1d1ef" />
                    </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Button runat="server" ID="btnCloseFundSearch" Text="  Close  " OnClick="btnCloseFundSearch_Click" />
                </td>
            </tr>
        </table>                        
    </div>
</asp:Panel>

<AjaxControlToolkit:ModalPopupExtender ID="mdlFirstSwitchPopup" runat="server" TargetControlID="Button2" PopupControlID="FirstSwitchPopup" CancelControlID="btnSwitchCancel" BackgroundCssClass="modalBackground" DropShadow="true" BehaviorID="bhvrFirstSwitchPopup" />
    
<asp:Panel ID="FirstSwitchPopup" runat="server" style="display:none;" CssClass="modalBox"> 
    <div style="text-align:right;width:100%;margin-top:5px;">
        <asp:Label runat="server" ID="lblSwitchMessage" Text="You are about to perform this Switch. Are you sure you want to proceed?"></asp:Label><br /><br />
        <center>
        <input type="button" id="btnSwitchProceed" runat="server" onclick="hidePopup('bhvrFirstSwitchPopup');" value="Proceed"/>&nbsp;&nbsp;<asp:Button runat="server" ID="btnSwitchCancel" Text="Cancel" />
        </center>
        <AjaxControlToolkit:ModalPopupExtender ID="mdlSecondSwitchPopup" runat="server" TargetControlID="Button2" PopupControlID="SecondSwitchPopup" CancelControlID="" BackgroundCssClass="modalBackground" DropShadow="true" BehaviorID="bhvrSecondSwitchPopup" />
    </div>
</asp:Panel>
    
<asp:Panel ID="SecondSwitchPopup" runat="server" style="display:none;" CssClass="modalBox">
    <div style="text-align:right;width:100%;margin-top:5px;">
        <asp:Label runat="server" ID="lblMessage2" Text="Client Approval required. Request client approval for this switch"></asp:Label><br /><br />
        <center>
        <asp:Button ID="btnSwitchYes" Text="Yes" runat="server" OnClientClick="hidePopup('bhvrSecondSwitchPopup')" />
        <asp:Button ID="btnSwitchNo" runat="server" Text="No" OnClick="btnSwitchNo_Click" />
        </center>
        <AjaxControlToolkit:ModalPopupExtender ID="mdlThirdSwitchPopup" runat="server" TargetControlID="btnSwitchYes" CancelControlID="btnSwitchSendCancel" PopupControlID="ThirdSwitchPopup" BackgroundCssClass="modalBackground" DropShadow="true" BehaviorID="bhvrThirdSwitchPopup" />
    </div>
</asp:Panel>

<asp:Panel runat="server" ID="ThirdSwitchPopup" style="display:none;" CssClass="modalBox" Width="350px" DefaultButton="btnSwitchSendSave">
    <div style="text-align:left;width:100%;margin-top:1px;">
    <h4>Portfolio Description</h4>
        <table width="100%">
            <tr><td colspan="2"><asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="multilineTextbox" Rows="10" width="95%"></asp:TextBox></td></tr>
            <tr><td>&nbsp;</td></tr>
            <tr><td><asp:Label ID="lblSMSMobileNo" runat="server" Text="Mobile no.:" Width="35%"></asp:Label><asp:TextBox runat="server" ID="txtSMSMobileNo" width="60%" ></asp:TextBox></td></tr>
        </table>
    <center>
        <br />
        <asp:Button runat="server" ID="btnSwitchSendSave" Text="Save" OnClick="btnSwitchSendSave_Click" />&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnSwitchSendCancel" Text="Cancel" />
        <br />
    </center>
    </div>
</asp:Panel>

<asp:Button ID="Button2" runat="server"  Text="" style="display:none;"/>

<script language="javascript" type="text/javascript">

    function SwitchSave() {
        confirmSave = confirm('Proceed saving this switch?')

        if (confirmSave) {

            var CurrentAllocation = window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation").value

            if (CurrentAllocation != 100.00) {
                alert("Unable to proceed. Total allocation must be set equal to 100. Your total allocation is: " + CurrentAllocation);
            }
            else {
                __doPostBack('btnSave', 'SaveSwitchDetails');
            }
        }
        else { return false; }
    }

    function validateSwitchAllocation() {
        
        var CurrentAllocation = window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation").value
        if (CurrentAllocation != 100.00) {
            alert("Unable to proceed. Total allocation must be set equal to 100. Your total allocation is:" + CurrentAllocation);
            $find('bhvrFirstSwitchPopup', null).hide();
            return false;
        }
        else {
            $find('bhvrFirstSwitchPopup', null).show();
        }
    }    

    function computeRows(sender, isContribution) {
    
        ctlID = sender.id.substring(sender.id.lastIndexOf('ctl'), sender.id.length).split('_');
        ctlID = ctlID[0]

        if (isContribution) {
            gridview = "gvContributionSwitch_"
            fundCount = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfFundCount_Contribution").value;
            currentValueClient = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfCurrentValueClientTotal_Contribution").value;
        }
        else {
            gridview = "gvSchemeSwitch_"
            fundCount = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfFundCount").value;
            currentValueClient = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfCurrentValueClientTotal").value;        
        }
             
        totalRowCount = parseInt(fundCount) + 2;        
        if (parseInt(totalRowCount) < 10) {
            totalRowCount = '0' + totalRowCount.toString();
        }        
        
        price = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_lblPrice").innerHTML;
        allocationDisplay = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvSwitchHeaderValue");
        value_ = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvSwitchDetailsLblValue");
        units_ = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvSwitchDetailsLblUnits");
        currencyMultiplier = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_hfCurrencyMultiplier").value;
        totalAlloc1 = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "ctl" + totalRowCount + "_gvSwitchFooterLblTotalAllocationOrig");
        totalAlloc2 = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "ctl" + totalRowCount + "_gvSwitchFooterLblTotalAllocation");

        allocation = sender.value;

        if (allocation == '') { allocation = 0 };
        allocationDisplay.innerHTML = allocation;

        try {
            units_.innerHTML = CommaFormatted(parseFloat(computeUnits(allocation, currentValueClient, price, currencyMultiplier)).toFixed(4), true);
            document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvhfSwitchDetailsLblUnits").value = CommaFormatted(parseFloat(computeUnits(allocation, currentValueClient, price, currencyMultiplier)).toFixed(4), true);
        }
        catch (err) {
            units_.innerHTML = 0.00;
            document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvhfSwitchDetailsLblUnits").value = 0.00;
        }

        try {
            value_.innerHTML = CommaFormatted(parseFloat(computeValue(allocation, currentValueClient)).toFixed(0));
            document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvhfSwitchHeaderValue").value = CommaFormatted(parseFloat(computeValue(allocation, currentValueClient)).toFixed(0));            
        }
        catch (err) {
            value_.innerHTML = 0.00;
            document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "" + ctlID + "_gvhfSwitchHeaderValue").value = 0.00;
        }

        _total = computeTotalAllocation(fundCount, gridview);
        _total = parseFloat(_total).toFixed(2);

        btnSwitch = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_btnSwitch");
        btnSave = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_btnSave");

        if (isNaN(_total)) {
            totalAlloc1.innerHTML = "-error-"
            totalAlloc2.innerHTML = "-error-"
            totalAlloc1.style.color = "#FF0000";
            totalAlloc2.style.color = "#FF0000";
            btnSave.disabled = true;
            btnSwitch.disabled = true;

        } else {
            totalAlloc1.innerHTML = _total;
            totalAlloc2.innerHTML = totalAlloc1.innerHTML;

            if (isContribution) {
                window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation_Contribution").value = totalAlloc2.innerHTML
                if (parseFloat(window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation_Contribution").value) > 100) {
                    totalAlloc1.style.color = "#FF0000";
                    totalAlloc2.style.color = "#FF0000";
                }
                else {
                    totalAlloc1.style.color = "#000000";
                    totalAlloc2.style.color = "#000000";
                }                
            }
            else {
                window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation").value = totalAlloc2.innerHTML
                if (parseFloat(window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation").value) != 100) {
                    totalAlloc1.style.color = "#FF0000";
                    totalAlloc2.style.color = "#FF0000";
                }
                else {
                    totalAlloc1.style.color = "#000000";
                    totalAlloc2.style.color = "#000000";
                }
            }

            if ((parseFloat(window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation").value) != 100) || (parseFloat(window.document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_gvSwitchFooterHfTotalAllocation_Contribution").value) > 100)) 
            {
                btnSave.disabled = true;
                btnSwitch.disabled = true;
            }
            else {
                btnSave.disabled = false;
                btnSwitch.disabled = false;
            }
        }        
    }

    function computeValue(fPercentAllocation, fTotalValue) {
        if (fPercentAllocation != 0) {
            fPercentAllocation = parseFloat(replaceAll(fPercentAllocation, ',', ''));
        }

        fTotalValue = parseFloat(replaceAll(fTotalValue, ',', ''));

        value = ((fPercentAllocation / 100) * fTotalValue);

        return parseFloat(value);
    }

    function computeUnits(fPercentAllocation, fTotalValue, fPrice, fCurrencyMultiplier) {

        if (fPercentAllocation != 0) {
            fPercentAllocation = parseFloat(replaceAll(fPercentAllocation, ',', ''));
        }

        fTotalValue = parseFloat(replaceAll(fTotalValue, ',', ''));
        fPrice = parseFloat(replaceAll(fPrice, ',', ''));
        fCurrencyMultiplier = parseFloat(replaceAll(fCurrencyMultiplier, ',', ''));

        fPrice = fPrice * fCurrencyMultiplier;

        strPrice = String(fPrice).split('.');

        if (strPrice.length > 1) {
            strPriceDecimal = strPrice[1].substring(0, 3);
            strNewPrice = strPrice[0] + "." + strPrice[1].substring(0, 3);
            //fPrice = parseFloat(strNewPrice);
            fPrice = parseFloat(strNewPrice);
        }

        //units = (((fPercentAllocation / 100) * fTotalValue) / (fPrice * fCurrencyMultiplier).toFixed(4));
        units = (((fPercentAllocation / 100) * fTotalValue) / (fPrice).toFixed(4));




        //alert('((' + fPercentAllocation + ' / 100) * ' + fTotalValue + ') / (' + (fPrice * fCurrencyMultiplier).toFixed(4) + ') = ' + units);

        return units;  //parseFloat(units, 10).toFixed(4);
    }

    function computeTotalAllocation(FundCount, gridview) {         
        var i = 1;
        var total = 0;
        var ctlID;
        while (i <= FundCount) {
            i++;
            if (i < 10) {
                ctlID = '0' + i;
            } else { ctlID = i }
            
            rowFundAllocation = document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_" + gridview + "ctl" + ctlID + "_gvSwitchTxtTargetAllocation").value;

            if (rowFundAllocation == '' || isNaN(rowFundAllocation)) {
                rowFundAllocation = parseFloat(0);
            } else {
                rowFundAllocation = rowFundAllocation;
            }

            total = parseFloat(total) + parseFloat(rowFundAllocation);

            if (parseFloat(total) > 0) {
                total = total;
            }
        }
        return total;
    }

    function onlyNumbers(sender, e) {
        if (window.event)
            charCode = window.event.keyCode; // IE
        else
            charCode = e.which; // Firefox

        if (charCode == 8 || charCode == 0) {
            return true;
        }

        if ((!(charCode > 47 && charCode < 58)) && charCode != 46) { return false; }

        if (charCode == 46) {
            if ((count(sender.value, '\\.') == 1) || sender.value == '') {
                return false;
            }
        }

        //	    if (parseFloat(sender.value) > parseFloat(100)) {sender.value = sender.value.slice(0, -1);return false;}

        //	    try {
        //	        decimalctr = sender.value.split('.');
        //	        if (decimalctr[1] != undefined) {
        //	            if (parseInt(decimalctr[1].length) > 2) {
        //	                sender.value = sender.value.slice(0, -1);
        //	                return false;
        //	            }
        //	        }
        //	    }catch (err) { }


        return true;
    }

    function count(s1, letter) {

        try {
            return String(s1).match(new RegExp(letter, 'g')).length;
        } catch (err) { }
    }

    function CommaFormatted(Num, showDecimal) {
        //var Num = document.form.input.value;
        var newNum = "";
        var newNum2 = "";
        var count = 0;

        //check for decimal number
        if (Num.indexOf('.') != -1) {  //number ends with a decimal point
            if (Num.indexOf('.') == Num.length - 1) {
                Num += "00";
            }
            if (Num.indexOf('.') == Num.length - 2) { //number ends with a single digit
                Num += "0";
            }

            var a = Num.split(".");
            Num = a[0];   //the part we will commify
            var end = a[1] //the decimal place we will ignore and add back later
        }
        else { var end = "00"; }

        //this loop actually adds the commas   
        for (var k = Num.length - 1; k >= 0; k--) {
            var oneChar = Num.charAt(k);
            if (count == 3) {
                newNum += ",";
                newNum += oneChar;
                count = 1;
                continue;
            }
            else {
                newNum += oneChar;
                count++;
            }
        }  //but now the string is reversed!

        //re-reverse the string
        for (var k = newNum.length - 1; k >= 0; k--) {
            var oneChar = newNum.charAt(k);
            newNum2 += oneChar;
        }

        if (showDecimal == true) {
            newNum2 = newNum2 + "." + end;
        }

        return newNum2;
    }

    function replaceAll(txt, replace, with_this) { return txt.replace(new RegExp(replace, 'g'), with_this); }

    //Popup FUNDS///////////////////////////////////
    function ValidateSearchInput() {
        if (event.keyCode == 13) {

            var SearchTextBox = window.document.getElementById("txtPopupFund").value

            if (SearchTextBox == "") {
                alert("Please input a search criteria");
            }
        }
    }

    function popUp_AddFunds(isContribution) {
        
        document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfPopUpFundAction").value = 'add';
        document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfIsContribution").value = isContribution;
        
        $find("bhvrPopupFundSearch", null).show();
    }

    function popUp_EditFunds(FundIDOrig, isContribution) {

        document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfFundIDOrig").value = FundIDOrig;
        document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfPopUpFundAction").value = 'edit';

        document.getElementById("ctl00_ContentPlaceHolder1_ucSwitchDetails1_hfIsContribution").value = isContribution;

        $find("bhvrPopupFundSearch", null).show();
    }


    //Popup FUNDS///////////////////////////////////
    
</script>